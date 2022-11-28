package Player;

import java.net.Socket;

public class TraderCreator implements PlayerCreator {
    private Socket player;
    private String id;
    private String username;
    private double money;

    public TraderCreator(String id, String username, double money,Socket player){
        this.id = id;
        this.username = username;
        this.money = money;
        this.player = player;
    }

    @Override
    public Player create() {
        return new Trader(this.id,this.username,this.money,this.player);
    }
}
