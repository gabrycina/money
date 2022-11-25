package Player;

import java.net.Socket;

public abstract class Player {
    private double profit;
    private int token;
    private Socket client;

    abstract public String getRole();
    abstract public void useSuperPower();
    abstract public void save();
}
