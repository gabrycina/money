import junit.framework.TestCase;
import org.junit.After;
import org.junit.Before;

import java.util.*;

public class MaxTest extends TestCase {
    private Map<String,Integer> winningChoices;
    private Map<String,Integer> losingChoices;
    private int round;

    @Before
    @Override
    public void setUp() {
        this.winningChoices = new HashMap<>();
        this.winningChoices.put("Player1",0);
        this.winningChoices.put("Player2",0);
        this.winningChoices.put("Player3",12);
        this.winningChoices.put("Player4",20);

        this.losingChoices = new HashMap<>();
        this.losingChoices.put("Player1",0);
        this.losingChoices.put("Player2",0);
        this.losingChoices.put("Player3",12);
        this.losingChoices.put("Player4",12);

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
        double sumOption = 0;

        for (Map.Entry<String, Integer> entry:this.winningChoices.entrySet()){
            option = entry.getValue();
            sumOption += option;

            List<String> list = options.get(option);
            if (list == null)
                list = new ArrayList<>();
            list.add(entry.getKey());

            options.put(option,list);
        }

        int res = options.entrySet().stream()
                .filter(e->e.getValue().size()==1)
                .map(Map.Entry::getKey).max(Comparator.naturalOrder()).orElse(-1);


        double lastPrize = Math.round(((100+400*(this.round-1))/sumOption)*100)/100.0;
        assertEquals(res,20);
        assertEquals(lastPrize,3.13);

        this.round = 2;
        lastPrize = Math.round(((100+400*(this.round-1))/sumOption)*100)/100.0;
        assertEquals(lastPrize,15.63);
    }

    public void testValidateLoserCase() {
        Map<Integer,List<String>> options = new HashMap<>();
        int option;
        double sumOption = 0;

        for (Map.Entry<String, Integer> entry:this.losingChoices.entrySet()){
            option = entry.getValue();
            sumOption += option;

            List<String> list = options.get(option);
            if (list == null)
                list = new ArrayList<>();
            list.add(entry.getKey());

            options.put(option,list);
        }

        int res = options.entrySet().stream()
                .filter(e->e.getValue().size()==1)
                .map(Map.Entry::getKey).max(Comparator.naturalOrder()).orElse(-1);

        double lastPrize = Math.round(((100+400*(this.round-1))/sumOption)*100)/100.0;
        assertEquals(res,-1);
        assertEquals(lastPrize,4.17);
    }
}
