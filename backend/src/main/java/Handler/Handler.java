package Handler;

import Player.User;
import com.google.gson.Gson;
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
    private Map json;
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
            action = this.json.get("action").toString();
            switch (action) {
                case "login":
                    this.loginHandler();
                    break;
                case "create_party":
                    this.newPartyHandler();
                    action = "join_party";
                    break;
                default:
                    break;
            }
        } while (!action.equals("join_party"));

        MockRedis games = MockRedis.getDb();
        Map data = new Gson().fromJson(this.json.get("data").toString(),Map.class);

        games.getGame(data.get("code").toString()).assignRole(this.user,this.clientSocket);
    }

    public void loginHandler() {
        Map data = new Gson().fromJson(this.json.get("data").toString(),Map.class);
        Bson filter = Filters.and(Filters.eq("username", data.get("username")), Filters.eq("password", data.get("password")));
        Document doc = this.users.find(filter).first(); // unique username
        Map<String,String> map = new HashMap<>();
        this.user = new User(doc.get("_id").toString(),
                        doc.get("username").toString(),
                        (double)doc.get("money"));

        if(doc==null) {
            map.put("error", "user does not exists");
        } else {
            map.put("money", doc.get("money").toString());
        }

        Json.writeJson(this.clientSocket, map);
    }

    public void newPartyHandler() { //attenzione l'attributo id è condiviso dai thread
        MockRedis games = MockRedis.getDb();
        Game game = new Game();
        String id = game.getId();
        games.putGame(id,game);
        Map data = new Gson().fromJson(this.json.get("data").toString(),Map.class);
        data.put("code",id);
        this.json.put("data",data.toString());
    }
}
