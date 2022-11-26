import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;

// ClientHandler class
public class Handler implements Runnable {
    private Socket clientSocket;
    private JsonObject jsonFromClient = null;

    public Handler(Socket socket)  {
        this.clientSocket = socket;
    }

    @Override
    public void run() {
        this.readJSon();
        String request = this.jsonFromClient.get("action").toString();
        request = request.substring(1,request.length()-1); // delete character "
        switch (request) {
            case "login":
                this.LoginHandler();
                break;
            default:
                break;
        }
    }

    public void LoginHandler(){
        JsonObject json = new JsonObject();
        json.addProperty("property1",1);
        json.addProperty("property2",2);

        this.writeJSon(json);
    }

    public void readJSon() {
        JsonParser parser = new JsonParser();
        Object obj = null;
        try {
            obj = parser.parse(new BufferedReader(new InputStreamReader(this.clientSocket.getInputStream())).readLine());
            this.jsonFromClient = (JsonObject) obj;
        }
        catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void writeJSon(JsonObject json) {
        try {
            new PrintWriter(clientSocket.getOutputStream(), true).println(json);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
