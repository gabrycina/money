import Player.Hacker;
import Player.Player;
import junit.framework.TestCase;
import org.junit.After;
import org.junit.Before;

import java.util.*;

public class ChoosePrizeTest extends TestCase {
    private Map<Player,String> playersChoices;
    private boolean boost;
    private Player player1;
    private Player player2;
    private Player player3;
    private Player player4;

    @Before
    @Override
    public void setUp() {
        this.playersChoices = new HashMap<>();
        player1 = new Hacker("1","Player1",100,null);
        player2 = new Hacker("2","Player2",100,null);
        player3 = new Hacker("3","Player3",100,null);
        player4 = new Hacker("4","Player4",100,null);

        this.playersChoices.put(player1,"0");
        this.playersChoices.put(player2,"50");
        this.playersChoices.put(player3,"100");

        this.boost = true;
        assertNotNull(player1);
        assertNotNull(player2);
        assertNotNull(player3);
        assertNotNull(player4);
        assertNotNull(this.playersChoices);
    }

    @After
    @Override
    public void tearDown() {
        player1 = null;
        player2 = null;
        player3 = null;
        player4 = null;
        this.playersChoices = null;
    }

    public void testValidateBoost() {
        this.playersChoices.put(player4,"M");
        Map<String,List<Player>> options = new HashMap<>();
        String option;

        for (Map.Entry<Player, String> entry:this.playersChoices.entrySet()){
            option = entry.getValue();

            List<Player> list = options.get(option);
            if (list == null)
                list = new ArrayList<>();
            list.add(entry.getKey());

            options.put(option,list);
        }

        double prize;
        for(Map.Entry<String,List<Player>> e:options.entrySet()){
            if(e.getValue().size()==1) {
                if (e.getKey().equals("M") || e.getKey().equals("2M")) {
                    e.getValue().get(0).addToken();
                    if (e.getKey().equals("2M")) e.getValue().get(0).addToken();
                } else{
                    prize = Double.parseDouble(e.getKey());
                    e.getValue().get(0).addProfit(prize);
                }
            } else {
                this.boost = false;
            }
        }

        assertEquals(player1.getProfit(),0.0);
        assertEquals(player2.getProfit(),50.0);
        assertEquals(player3.getProfit(),100.0);
        assertEquals(player4.getProfit(),0.0);
        assertTrue(this.boost);
    }

    public void testValidateNoBoost() {
        this.playersChoices.put(player4,"0");
        Map<String,List<Player>> options = new HashMap<>();
        String option;

        for (Map.Entry<Player, String> entry:this.playersChoices.entrySet()){
            option = entry.getValue();

            List<Player> list = options.get(option);
            if (list == null)
                list = new ArrayList<>();
            list.add(entry.getKey());

            options.put(option,list);
        }

        double prize;
        for(Map.Entry<String,List<Player>> e:options.entrySet()){
            if(e.getValue().size()==1) {
                if (e.getKey().equals("M") || e.getKey().equals("2M")) {
                    e.getValue().get(0).addToken();
                    if (e.getKey().equals("2M")) e.getValue().get(0).addToken();
                } else{
                    prize = Double.parseDouble(e.getKey());
                    e.getValue().get(0).addProfit(prize);
                }
            } else {
                this.boost = false;
            }
        }

        assertEquals(player1.getProfit(),0.0);
        assertEquals(player2.getProfit(),50.0);
        assertEquals(player3.getProfit(),100.0);
        assertEquals(player4.getProfit(),0.0);
        assertFalse(this.boost);
    }
}
