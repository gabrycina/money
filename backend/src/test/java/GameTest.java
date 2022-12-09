import junit.framework.TestCase;
import org.junit.After;
import org.junit.Before;

import java.util.*;

public class GameTest extends TestCase {
    private List<Integer> miniGames;
    private List<Integer> role;
    private int roleIndex;
    @Before
    @Override
    public void setUp() throws Exception {
        super.setUp();
        roleIndex = 0;

        role = new ArrayList<>(Arrays.asList(0,1,2,3,4));
        Collections.shuffle(role);

        miniGames = Arrays.asList(0,1,2,3);
        Collections.shuffle(miniGames);
        miniGames = Arrays.asList(miniGames.get(0),miniGames.get(1));

        assertNotNull(role);
        assertNotNull(miniGames);
    }

    @After
    @Override
    public void tearDown() throws Exception {
        super.tearDown();
        role = null;
        miniGames = null;
    }

    public void testAssignMiniGames(){
        assertTrue(miniGames.get(0) > -1 && miniGames.get(0) < 4);
        assertTrue(miniGames.get(1) > -1 && miniGames.get(1) < 4);
    }

    public void testAssignRole(){
        assertTrue(role.get(roleIndex) > -1 && role.get(roleIndex++) < 5);
        assertTrue(role.get(roleIndex) > -1 && role.get(roleIndex++) < 5);
        assertTrue(role.get(roleIndex) > -1 && role.get(roleIndex++) < 5);
        assertTrue(role.get(roleIndex) > -1 && role.get(roleIndex++) < 5);
        assertTrue(role.get(roleIndex) > -1 && role.get(roleIndex++) < 5);

        assertEquals(roleIndex,5);
    }
}

