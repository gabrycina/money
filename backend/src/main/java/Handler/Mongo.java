package Handler;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import org.bson.Document;

public class Mongo {
    public static MongoCollection<Document> USERS;

    public static void init(String client){
        Mongo.USERS = MongoClients.create(client)
                .getDatabase("money")
                .getCollection("Users");
    }
}
