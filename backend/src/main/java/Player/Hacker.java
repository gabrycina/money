package Player;

import Handler.Json;

import java.net.Socket;
import java.util.List;
import java.util.Map;

public class Hacker extends Player {

    public Hacker(String id, String username, double money,Socket player){
        super(id,username,money,player);
    }

    @Override
    public String getRole(){
        return "Hacker";
    }

    @Override
    public void useSuperPower(List<Player> players, Player lastWinner, double lastPrize, Map<String,String> lastAnswer){
        Json.writeJson(this.getSocket(),lastAnswer);
    }
}
