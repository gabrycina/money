import java.io.*;
import java.net.*;
import Handler.Handler;
import Handler.Mongodb;

public class Server {
    public static void main(String[] args){
        Mongodb.init("mongodb+srv://money:py8EaXXi2ZD4cqxH@cluster0.iutok3h.mongodb.net/?retryWrites=true&w=majority");
        ServerSocket server = null;
        try {
            server = new ServerSocket(1234);
            server.setReuseAddress(true);
            while (true) {
                Socket client = server.accept();
                System.out.println("New client connected " + client.getInetAddress().getHostAddress());

                Handler clientSock = new Handler(client,null);
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
