package Handler;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import org.jetbrains.annotations.NotNull;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.Map;

public class Json {
    public static Map<String,String> readJson(@NotNull Socket client) {
        String json = null;
        try {
            do {
                json = new BufferedReader(new InputStreamReader(client.getInputStream()))
                        .readLine();
                System.out.println("server receive --> " + json);
            }while(json.equals("keep-alive"));
            System.out.println("end wait");
        } catch (IOException e) {
            e.printStackTrace();
        }
        return new Gson().fromJson(json, new TypeToken<Map<String,String>>() {}.getType()); //create Map<String,String>
    }

    public static Map<String,String> readJson(@NotNull BufferedReader buffer) {
        String json = null;
        try {
            do {
                json = buffer.readLine();
                System.out.println("server receive --> "+json);
            }while(json.equals("keep-alive"));
            System.out.println("end wait");
        } catch (IOException e) {
            e.printStackTrace();
        }
        return new Gson().fromJson(json, new TypeToken<Map<String,String>>() {}.getType()); //create Map<String,String>
    }

    public static void writeJson(Socket client,Map<String,String> json) {
        try {
            new PrintWriter(client.getOutputStream(), true)
                    .println(new Gson().toJson(json));
            System.out.println("server send --> "+new Gson().toJson(json));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
