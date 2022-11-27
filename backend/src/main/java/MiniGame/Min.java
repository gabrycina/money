package MiniGame;

import java.net.Socket;
import java.util.List;

public class Min extends MiniGame {
    public Min(){

    }

    @Override
    public String getRule(){
        return "rule";
    }
    @Override
    public double getPrizes(){
        return 13.3;
    }
    @Override
    public void play(List<Socket> socket){

    }
}
