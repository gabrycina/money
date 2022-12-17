package Handler;

import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import org.bson.Document;

public class Mongodb {
    public static MongoCollection<Document> USERS;

    public static void init(String client){
        Mongodb.USERS = MongoClients.create(client)
                .getDatabase("money")
                .getCollection("Users");
    }
}
