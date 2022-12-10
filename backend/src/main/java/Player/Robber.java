package Player;

import Handler.Json;

import java.net.Socket;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Robber extends Player {

    public Robber(String id, String username, double money,Socket player){
        super(id,username,money,player);
    }

    @Override
    public String getRole(){
        return "Robber";
    }

    @Override
    public void useSuperPower(List<Player> players, Player lastWinner, double lastPrize, Map<String,String> lastAnswer){
        Player target = players.stream()
                .filter(p->p.getUsername().equals(Json.readJson(this.getSocket()).get("username")))
                .findFirst().orElse(this);
        double loot = target.getProfit()*0.05;
        target.addProfit(-loot);
        this.addProfit(loot);
        Map<String,String> json = new HashMap<>();
        json.put("result",Double.valueOf(loot).toString());
        Json.writeJson(this.getSocket(),json);
    }
}
