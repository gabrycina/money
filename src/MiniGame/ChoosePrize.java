package MiniGame;

import java.net.Socket;
import java.util.List;

public class ChoosePrize extends MiniGame {
    public ChoosePrize(){

    }

    @Override
    public String getRule(){
        return "rule";
    }
    @Override
    public double getPrizes(){
        return 13.2;
    }
    @Override
    public void play(List<Socket> socket){

    }
}
