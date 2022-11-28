package Player;

import java.net.Socket;

public class LudopaticCreator implements PlayerCreator {
    private final Socket player;
    private final String id;
    private final String username;
    private double money;

    public LudopaticCreator(String id, String username, double money, Socket player){
        this.id = id;
        this.username = username;
        this.money = money;
        this.player = player;
    }

    @Override
    public Player create() {
        return new Ludopatic(this.id,this.username,this.money,this.player);
    }
}
