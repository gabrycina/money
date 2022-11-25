package MiniGame;

import java.net.Socket;
import java.util.List;

public abstract class MiniGame {
    private double profit;
    abstract public String getRule();
    abstract public double getPrizes();
    abstract public void play(List<Socket> socket);
}
