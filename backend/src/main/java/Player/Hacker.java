package Player;

import Handler.Json;

import java.net.Socket;
import java.util.HashMap;
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
        StringBuilder value = new StringBuilder();

        for(Map.Entry<String,String> entry:lastAnswer.entrySet())
            value.append(entry.getKey()).append(" answered ").append(entry.getValue()).append("\n");

        Map<String, String> map = new HashMap<>();
        map.put("result", String.valueOf(value));
        Json.writeJson(this.getSocket(),map);
    }
}
