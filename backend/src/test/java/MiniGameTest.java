import Player.Player;
import Player.Hacker;
import com.google.gson.Gson;
import junit.framework.TestCase;
import org.junit.After;
import org.junit.Before;

import java.util.HashMap;
import java.util.Map;

public class MiniGameTest extends TestCase {
    private Map<String,String> req;
    private Player player;

    @Before
    @Override
    public void setUp() throws Exception {
        super.setUp();
        req = new HashMap<>();
        player = new Hacker("0","testPlayer",0,null);
        player.addProfit(100);
        assertNotNull(req);
        assertNotNull(player);
    }

    @After
    @Override
    public void tearDown() throws Exception {
        super.tearDown();
        req = null;
        player = null;
    }

    public void testCheckSplitTrue(){
        req.put("split","true");
        double lastPrize = 100;
        int numberOfPlayer = 4;
        Map <String,String> resp = new HashMap<>();

        resp.put("winner","false");
        if(req.get("split").equals("true")) {
            resp.put("prize", String.valueOf(lastPrize / numberOfPlayer));
            player.addProfit(lastPrize / numberOfPlayer);
        }else
            resp.put("prize","0");

        assertEquals(player.getProfit(),125.0);
        assertEquals(new Gson().toJson(resp),"{\"winner\":\"false\",\"prize\":\"25.0\"}");
    }

    public void testCheckSplitFalse(){
        req.put("split","false");
        double lastPrize = 100;
        int numberOfPlayer = 4;
        Map <String,String> resp = new HashMap<>();

        resp.put("winner","false");
        if(req.get("split").equals("true")) {
            resp.put("prize", String.valueOf(lastPrize / numberOfPlayer));
            player.addProfit(lastPrize / numberOfPlayer);
        }else
            resp.put("prize","0");

        assertEquals(player.getProfit(),100.0);
        assertEquals(new Gson().toJson(resp),"{\"winner\":\"false\",\"prize\":\"0\"}");
    }

    public void testReceiveMoneyTrue(){
        req.put("username","testPlayer");
        req.put("prize","50");
        Map <String,String> resp = new HashMap<>();
        if(!req.get("username").equals("")){
            player.addProfit(Double.parseDouble(req.get("prize")));
            resp.put("prize",req.get("prize"));
        }
        assertEquals(player.getProfit(),150.0);
        assertEquals(new Gson().toJson(resp),"{\"prize\":\"50\"}");
    }

    public void testReceiveMoneyFalse(){
        req.put("username","");
        req.put("prize","");
        Map <String,String> resp = new HashMap<>();
        if(!req.get("username").equals("")){
            player.addProfit(Double.parseDouble(req.get("prize")));
            resp.put("prize",req.get("prize"));
        }
        assertEquals(player.getProfit(),100.0);
        assertNotNull(resp);
    }
}
