import junit.framework.TestCase;
import org.junit.After;
import org.junit.Before;

import java.util.*;

public class MinTest extends TestCase {
    private Map<String,Integer> winningChoices;
    private Map<String,Integer> losingChoices;
    private int round;

    @Before
    @Override
    public void setUp() {
        this.winningChoices = new HashMap<>();
        this.winningChoices.put("Player1",1);
        this.winningChoices.put("Player2",4);
        this.winningChoices.put("Player3",4);
        this.winningChoices.put("Player4",4);

        this.losingChoices = new HashMap<>();
        this.losingChoices.put("Player1",1);
        this.losingChoices.put("Player2",1);
        this.losingChoices.put("Player3",1);
        this.losingChoices.put("Player4",1);

        this.round = 1;
        assertNotNull(this.winningChoices);
        assertNotNull(this.losingChoices);
    }

    @After
    @Override
    public void tearDown() {
        this.winningChoices = null;
    }

    public void testValidateWinnerCase() {
        Map<Integer,List<String>> options = new HashMap<>();
        int option;
        int minOption = Integer.MAX_VALUE;

        for (Map.Entry<String, Integer> entry:this.winningChoices.entrySet()){
            option = entry.getValue();
            minOption = Math.min(minOption,option);

            List<String> list = options.get(option);
            if (list == null)
                list = new ArrayList<>();
            list.add(entry.getKey());

            options.put(option,list);
        }

        int res = options.entrySet().stream()
                .filter(e->e.getValue().size()==1)
                .map(Map.Entry::getKey).min(Comparator.naturalOrder()).orElse(-1);


        double lastPrize = 50*this.round*minOption;
        assertEquals(res,1);
        assertEquals(lastPrize,50.0);

        this.round = 2;
        lastPrize = 50*this.round*minOption;
        assertEquals(lastPrize,100.0);
    }

    public void testValidateLoserCase() {
        Map<Integer,List<String>> options = new HashMap<>();
        int option;
        int minOption = Integer.MAX_VALUE;

        for (Map.Entry<String, Integer> entry:this.losingChoices.entrySet()){
            option = entry.getValue();
            minOption = Math.min(minOption,option);

            List<String> list = options.get(option);
            if (list == null)
                list = new ArrayList<>();
            list.add(entry.getKey());

            options.put(option,list);
        }

        int res = options.entrySet().stream()
                .filter(e->e.getValue().size()==1)
                .map(Map.Entry::getKey).min(Comparator.naturalOrder()).orElse(-1);

        assertEquals(res,-1);
    }
}
