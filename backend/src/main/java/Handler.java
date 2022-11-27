import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.internal.LinkedTreeMap;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import org.bson.Document;
import org.bson.conversions.Bson;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.HashMap;
import java.util.Map;

// ClientHandler class
public class Handler implements Runnable {
    private final Socket clientSocket;
    private Map json;
    private final MongoCollection<Document> users;

    public Handler(Socket socket, MongoDatabase db)  {
        this.clientSocket = socket;
        this.users = db.getCollection("Users");
        this.json = Json.readJson(this.clientSocket);
    }

    @Override
    public void run() {
        switch (this.json.get("action").toString()) {
            case "login":
                this.LoginHandler();
                break;
            default:
                break;
        }
    }

    public void LoginHandler() {
        Map data = new Gson().fromJson(this.json.get("data").toString(),Map.class);
        Bson filter = Filters.and(Filters.eq("username", data.get("username")), Filters.eq("password", data.get("password")));
        Document doc = this.users.find(filter).first(); // unique username
        Map<String,String> map = new HashMap<>();

        if(doc==null) {
            map.put("error", "user does not exists");
        } else {
            map.put("money", doc.get("money").toString());
        }

        Json.writeJson(this.clientSocket, map);
    }
}
