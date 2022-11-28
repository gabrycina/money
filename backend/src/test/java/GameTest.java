import com.google.gson.Gson;
import junit.framework.TestCase;
import org.junit.After;
import org.junit.Before;

import java.util.Map;

public class GameTest extends TestCase {
    private String s;
    private Map json;

    @Before
    @Override
    protected void setUp() throws Exception {
        super.setUp();
        s = "{action=login, data={username=user, password=psw}}";
        json = new Gson().fromJson(s,Map.class);
        assertNotNull(s);
        assertNotNull(json);
    }

    @After
    @Override
    protected void tearDown() throws Exception {
        super.tearDown();
        s = null;
        json = null;
    }

    public void testJsonStringToMap(){
        s = "{action=login, data={username=user, password=psw}}";
        json = new Gson().fromJson(s,Map.class);
        assertEquals(s,json.toString());
    }
}
