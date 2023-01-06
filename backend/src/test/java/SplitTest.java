import junit.framework.TestCase;
import org.junit.After;
import org.junit.Before;

import java.util.*;

public class SplitTest extends TestCase {
    private Map<String,Integer> playersChoices;
    private int round;

    @Before
    @Override
    public void setUp() {
        this.playersChoices = new HashMap<>();
        this.playersChoices.put("Player1",100);
        this.playersChoices.put("Player2",200);
        this.playersChoices.put("Player3",150);
        this.playersChoices.put("Player4",0);

        this.round = 1;
        assertNotNull(this.playersChoices);
    }

    @After
    @Override
    public void tearDown() {
        this.playersChoices = null;
    }

    public void testValidate() {
        double box = 0;
        for (Map.Entry<String, Integer> entry:this.playersChoices.entrySet()){
            box += entry.getValue();
        }
        double finalBox = Math.round(((box + box*(0.25*this.round))/4)*100)/100.0;
        assertEquals(finalBox,140.63);
        this.round = 2;
        finalBox = Math.round(((box + box*(0.25*this.round))/4)*100)/100.0;
        assertEquals(finalBox,168.75);
    }
}
