import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import junit.framework.TestCase;
import org.junit.After;
import org.junit.Before;
import java.util.Map;

public class JsonTest extends TestCase {
    private String requestString;
    private Map<String,String> requestMap;

    @Before
    @Override
    public void setUp() throws Exception {
        super.setUp();
        requestString = "{\"action\":\"login\",\"username\":\"admin\",\"password\":\"admin\"}";
        requestMap = new Gson().fromJson(requestString, new TypeToken<Map<String,String>>() {}.getType());
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
        assertEquals(requestMap.get("action"),"login");
        assertEquals(requestMap.get("username"),"admin");
        assertEquals(requestMap.get("password"),"admin");
    }

    public void testWriteJson(){
        assertEquals(new Gson().toJson(requestMap),requestString);
    }
}
