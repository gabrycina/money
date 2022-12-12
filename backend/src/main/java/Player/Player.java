package Player;

import Handler.Mongo;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Updates;

import java.net.Socket;
import java.util.List;
import java.util.Map;

public abstract class Player extends User {
    private double profit;
    private int token;
    private final Socket socketPlayer;

    public Player(String id, String username, double money,Socket player) {
            super(id,username,money);
            this.profit = 0;
            this.token = 0;
            this.socketPlayer = player;
    }

    public void save(){ //update bank account
        Mongo.USERS.updateOne(Filters.eq("username", super.getUsername()),
                Updates.set("money", String.valueOf(super.getMoney()+this.getProfit())));
    }

    public Socket getSocket(){
        return this.socketPlayer;
    }

    public double getProfit(){
        return this.profit;
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
