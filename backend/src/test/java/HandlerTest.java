import Handler.Game;
import Handler.MockRedis;
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

public class HandlerTest extends TestCase {
    private Map<String,String> requestMap;

    @Before
    @Override
    public void setUp() throws Exception {
        super.setUp();
        requestMap = new HashMap<>();
        requestMap.put("action","login");
        requestMap.put("username","admin");
        requestMap.put("password","admin");
        assertNotNull(requestMap);
    }

    @After
    @Override
    public void tearDown() throws Exception {
        super.tearDown();
        requestMap = null;
    }

    public void testLogin(){
        MongoClient access = MongoClients.create("mongodb+srv://money:py8EaXXi2ZD4cqxH@cluster0.iutok3h.mongodb.net/?retryWrites=true&w=majority");
        MongoDatabase db = access.getDatabase("money");
        MongoCollection<Document> users = db.getCollection("Users");

        Bson filter = Filters.and(Filters.eq("username", requestMap.get("username")),
                Filters.eq("password", requestMap.get("password")));
        Document doc = users.find(filter).first(); // unique username

        Map<String,String> resp= new HashMap<>();
        if (doc==null) {
            resp.put("error","user does not exists");
        }else {
            resp.put("money", doc.get("money").toString()); //bank account
        }

        assertEquals(resp.toString(),"{money=100.0}"); //the user is in the collection
    }

    public void testNewParty(){
        MockRedis games = MockRedis.getDb();

        Game game = new Game(null);
        String id = game.getId();
        games.putGame(id,game);

        Map<String,String> data = new HashMap<>();
        data.put("code",id);

        assertNotNull(games.getGame(id));
        assertEquals(data.toString(), "{code="+id+"}");
    }
}
