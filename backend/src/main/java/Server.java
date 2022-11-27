import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoDatabase;

import java.io.*;
import java.net.*;

class Server {
    public static void main(String[] args){
        MongoClient access = MongoClients.create("mongodb+srv://money:py8EaXXi2ZD4cqxH@cluster0.iutok3h.mongodb.net/?retryWrites=true&w=majority");
        MongoDatabase db = access.getDatabase("money");
        ServerSocket server = null;
        try {
            server = new ServerSocket(8080);
            server.setReuseAddress(true);
            while (true) {
                Socket client = server.accept();
                System.out.println("New client connected " + client.getInetAddress().getHostAddress());

                Handler clientSock = new Handler(client,db);
                new Thread(clientSock).start();
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (server != null) {
                try {
                    server.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
