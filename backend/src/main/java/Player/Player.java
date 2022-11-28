package Player;

import java.net.Socket;
public abstract class Player extends User {
    private double profit;
    private int token;
    private Socket player;

    public Player(String id, String username, double money,Socket player) {
            super(id,username,money);
            this.player = player;
    }

    public Socket getSocket(){
        return this.player;
    }
    abstract public String getRole();
    abstract public void useSuperPower();
    abstract public void save();
}
