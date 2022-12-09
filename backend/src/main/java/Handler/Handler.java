package Handler;

import Player.User;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
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
    private final MongoCollection<Document> USERS;
    private User user;

    public Handler(Socket socket, MongoDatabase db)  {
        this.CLIENT_SOCKET = socket;
        this.USERS = db.getCollection("Users");
    }

    @Override
    public void run() {
        String action;
        do {
            this.json = Json.readJson(this.CLIENT_SOCKET);
            action = this.json.get("action");
            switch (action) {
                case "login" -> this.loginHandler();
                case "create_party" -> {
                    this.newPartyHandler();
                    action = "join_party";
                }
            }
        } while (!action.equals("join_party"));

        MockRedis games = MockRedis.getDb();
        Game game = games.getGame(this.json.get("code"));
        synchronized (this) {
            game.assignRole(this.user, this.CLIENT_SOCKET);
        }
    }

    private void leaderBoardHandler(){
        List<Document> list = new ArrayList<>();
        Bson projection = Projections.fields(Projections.exclude("password"), Projections.excludeId());
        this.USERS.find().projection(projection).sort(descending(("money"))).into(list);

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
        Document doc = this.USERS.find(filter).first(); // unique username

        if(doc==null) {
            Map<String,String> resp = new HashMap<>();
            resp.put("error", "user does not exists");

            Json.writeJson(this.CLIENT_SOCKET, resp);
        } else {
            this.user = new User(doc.get("_id").toString(),
                    doc.get("username").toString(),
                    Double.parseDouble(doc.get("money").toString()));

            this.leaderBoardHandler();
        }
    }

    private void newPartyHandler() {
        MockRedis games = MockRedis.getDb();
        Game game;
        synchronized (this) { //race condition per id
            game = new Game(this.USERS);
        }
        String id = game.getId();
        games.putGame(id,game);
        this.json.put("code",id);
    }
}
