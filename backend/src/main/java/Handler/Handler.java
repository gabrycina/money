package Handler;

import Player.User;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import org.bson.Document;
import org.bson.conversions.Bson;
import java.net.Socket;
import java.util.HashMap;
import java.util.Map;

// ClientHandler class
public class Handler implements Runnable {
    private final Socket clientSocket;
    private Map<String,String> json;
    private final MongoCollection<Document> users;
    private User user;

    public Handler(Socket socket, MongoDatabase db)  {
        this.clientSocket = socket;
        this.users = db.getCollection("Users");
    }

    @Override
    public void run() {
        String action;
        do {
            this.json = Json.readJson(this.clientSocket);
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
        game.assignRole(this.user,this.clientSocket);
    }

    public void loginHandler() {
        Bson filter = Filters.and(Filters.eq("username", this.json.get("username")),
                                    Filters.eq("password", this.json.get("password")));
        Document doc = this.users.find(filter).first(); // unique username
        Map<String,String> resp = new HashMap<>();

        if(doc==null) {
            resp.put("error", "user does not exists");
        } else {
            this.user = new User(doc.get("_id").toString(),
                        doc.get("username").toString(),
                        (double)doc.get("money"));
            resp.put("money", doc.get("money").toString());
        }

        Json.writeJson(this.clientSocket, resp);
    }

    public void newPartyHandler() {
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
