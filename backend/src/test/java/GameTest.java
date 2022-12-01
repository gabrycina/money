import Handler.Game;
import Handler.MockRedis;
import com.google.gson.Gson;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import junit.framework.TestCase;
import org.bson.Document;
import org.bson.conversions.Bson;
import org.junit.After;
import org.junit.Before;

import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

public class GameTest extends TestCase {
    private String requestString;
    private Map requestMap;

    @Before
    @Override
    public void setUp() throws Exception {
        super.setUp();
        requestString = "{action=login, data={username=admin, password=admin}}";
        requestMap = new TreeMap<>(); // TreeMap permette di mantenere l'ordine di inserimento delle chiavi ma le op sono più costose
        requestMap.put("action","login");
        requestMap.put("data","{username=admin, password=admin}");
        assertNotNull(requestString);
        assertNotNull(requestMap);
    }

    @After
    @Override
    public void tearDown() throws Exception {
        super.tearDown();
        requestString = null;
        requestMap = null;
    }

    public void testJsonStringToMap(){
        Map json = new Gson().fromJson(requestString,Map.class);
        assertEquals(requestString,json.toString());
    }

    public void testMapToJsonString(){
        assertEquals(requestMap.toString(),requestString);
    }

    public void testSignIn(){
        MongoClient access = MongoClients.create("mongodb+srv://money:py8EaXXi2ZD4cqxH@cluster0.iutok3h.mongodb.net/?retryWrites=true&w=majority");
        MongoDatabase db = access.getDatabase("money");
        MongoCollection<Document> users = db.getCollection("Users");

        Map data = new Gson().fromJson(requestMap.get("data").toString(),Map.class);
        Bson filter = Filters.and(Filters.eq("username", data.get("username")), Filters.eq("password", data.get("password")));
        Document doc = users.find(filter).first(); // unique username

        Map<String,String> responce = new HashMap<>();
        if (doc==null) {
            responce.put("error","user does not exists");
        }else {
            responce.put("money", doc.get("money").toString()); //bank account
        }

        assertEquals(responce.toString(),"{money=100.0}");
    }

    public void testCreateNewParty(){
        MockRedis games = MockRedis.getDb();

        Game game = new Game();
        String id = game.getId();
        games.putGame(id,game);

        Map data = new TreeMap<>();
        data.put("code",id);

        assertNotNull(games.getGame(id));
        assertEquals(data.toString(), "{code="+id+"}");
    }
}
