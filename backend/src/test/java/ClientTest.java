import junit.framework.TestCase;
import org.junit.After;
import org.junit.Before;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;

import static java.lang.Thread.sleep;

public class ClientTest extends TestCase {
    private Socket socket;

    @Before
    @Override
    public void setUp() throws Exception {
        Runnable runnable = () -> Server.main(null);
        Thread thread = new Thread(runnable);
        thread.start();
        sleep(1000);
        socket = new Socket("localhost",8080);
        assertNotNull(socket);
    }

    @After
    @Override
    public void tearDown() throws Exception {
        socket.close();
    }

    public void testClientRequest() throws IOException {
        PrintWriter out = new PrintWriter(socket.getOutputStream(), true);
        BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()));

        String req = "{\"action\":\"login\",\"username\":\"admin\",\"password\":\"admin\"}";
        out.println(req);
        out.flush();

        String resp = in.readLine();
        assertEquals(resp,"{\"money\":\"100.0\",\"username\":\"admin\"}");

        req = "{\"action\":\"createParty\"}";
        out.println(req);
        out.flush();

        resp = in.readLine();
        assertEquals(resp,"{\"code\":\"1273\",\"players\":\"[admin]\"}");
    }
}
