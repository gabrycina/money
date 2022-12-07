import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import junit.framework.TestCase;
import org.junit.After;
import org.junit.Before;

import java.util.HashMap;
import java.util.Map;

public class JsonTest extends TestCase {
    private String requestString;
    private Map<String,String> requestMap;

    @Before
    @Override
    public void setUp() throws Exception {
        super.setUp();
        requestString = "{action=login, username=admin, password=admin}";
        requestMap = new HashMap<>();
        requestMap.put("action","login");
        requestMap.put("username","admin");
        requestMap.put("password","admin");
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

    public void testReadJson(){
        Map<String,String> json = new Gson().fromJson(requestString,new TypeToken<Map<String,String>>() {}.getType());
        assertEquals(requestString,json.toString());
    }

    public void testWriteJson(){
        assertEquals(requestMap.get("action"),"login");
        assertEquals(requestMap.get("username"),"admin");
        assertEquals(requestMap.get("password"),"admin");
    }
}
