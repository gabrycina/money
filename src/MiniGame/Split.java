package MiniGame;

import java.net.Socket;
import java.util.List;

public class Split extends MiniGame {
    public Split(){

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
