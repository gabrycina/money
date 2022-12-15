package Handler;

import Player.User;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Projections;
import org.bson.Document;
import org.bson.conversions.Bson;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.mongodb.client.model.Sorts.descending;

// ClientHandler class
public class Handler implements Runnable {
    private final Socket CLIENT_SOCKET;
    private Map<String,String> json;
    private User user;

    public Handler(Socket socket)  {
        this.CLIENT_SOCKET = socket;
    }

    @Override
    public void run() {
        String action;
        do {
            this.json = Json.readJson(this.CLIENT_SOCKET);
            action = this.json.get("action");
            switch (action) {
                case "login" -> this.loginHandler();
                case "leaderBoard" -> this.leaderBoardHandler();
                case "createParty" -> {
                    this.newPartyHandler();
                    action = "joinParty";
                }
            }
        } while (!action.equals("joinParty") && !action.equals("close"));

        if(action.equals("close")){
            try {
                this.CLIENT_SOCKET.close();
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
            return;
        }

        MockRedis games = MockRedis.getDb();
        Game game = games.getGame(this.json.get("code"));
        synchronized (this) {
            game.assignRole(this.user, this.CLIENT_SOCKET);
        }
    }

    private void leaderBoardHandler(){
        List<Document> list = new ArrayList<>();
        Bson projection = Projections.fields(Projections.exclude("password"), Projections.excludeId());
        Mongo.USERS.find().projection(projection).sort(descending(("money"))).into(list);

        String leaderboard = list.stream().map(Document::toJson).toList().toString();
        try {
            new PrintWriter(this.CLIENT_SOCKET.getOutputStream(), true)
                    .println("{"+"\"leaderboard\""+":\""+leaderboard+"\""+"}");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void loginHandler() {
        Bson filter = Filters.and(Filters.eq("username", this.json.get("username")),
                                    Filters.eq("password", this.json.get("password")));
        Document doc = Mongo.USERS.find(filter).first(); // unique username

        Map<String,String> resp = new HashMap<>();
        if(doc==null) {
            resp.put("error", "user does not exists");
        } else {
            this.user = new User(doc.get("_id").toString(),
                    doc.get("username").toString(),
                    Double.parseDouble(doc.get("money").toString()));

            resp.put("username",this.user.getUsername());
            resp.put("money",String.valueOf(this.user.getMoney()));
        }
        Json.writeJson(this.CLIENT_SOCKET, resp);
    }

    private void newPartyHandler() {
        MockRedis games = MockRedis.getDb();
        Game game;
        synchronized (this) { //race condition per id
            game = new Game();
        }
        String id = game.getId();
        games.putGame(id,game);
        this.json.put("code",id);
    }
}
