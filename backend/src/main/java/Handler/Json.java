package Handler;

import com.google.gson.Gson;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.Map;

public class Json {
    static Map readJson(Socket client) {
        String json = new String();
        try {
            json = new BufferedReader(
                    new InputStreamReader(
                            client.getInputStream()))
                    .readLine();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return new Gson().fromJson(json, Map.class);
    }

    static void writeJson(Socket client,Map json) {
        try {
            new PrintWriter(client.getOutputStream(), true).println(json.toString());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
