package Player;

import Handler.Json;
import Handler.Mongodb;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Updates;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.Socket;
import java.util.List;
import java.util.Map;

public abstract class Player extends User {
    private double profit;
    private int token;
    private final Socket socketPlayer;
    private BufferedReader buffer;

    public Player(String id, String username, double money,Socket player) {
            super(id,username,money);
            this.profit = 0;
            this.token = 0;
            this.socketPlayer = player;

            try {
                this.buffer = new BufferedReader(new InputStreamReader(player.getInputStream()));
            } catch(IOException e){
                e.printStackTrace();
            }
    }

    public void save(){ //update bank account
        Mongodb.USERS.updateOne(Filters.eq("username", super.getUsername()),
                Updates.set("money", String.valueOf(super.getMoney()+this.getProfit())));
    }

    public Map<String,String> read(){
        return Json.readJson(this.buffer);
    }

    public void write(Map<String,String> json){
        Json.writeJson(this.getSocket(),json);
    }

    public Socket getSocket(){
        return this.socketPlayer;
    }

    public double getProfit(){
        return Math.round(this.profit*100)/100.0;
    }

    public int getToken(){
        return this.token;
    }

    public void addProfit(double prize){
        this.profit += prize;
    }

    public void addToken(){
        this.token += 1;
    }
    abstract public String getRole();
    abstract public void useSuperPower(List<Player> players, Player lastWinner, Map<String,String> lastAnswer);
}
