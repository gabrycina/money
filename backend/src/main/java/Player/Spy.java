package Player;

import Handler.Json;

import java.net.Socket;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Spy extends Player {

    public Spy(String id, String username, double money,Socket player){
        super(id,username,money,player);
    }

    @Override
    public String getRole(){
        return "Spy";
    }

    @Override
    public void useSuperPower(List<Player> players, Player lastWinner, double lastPrize, Map<String,String> lastAnswer){
        Player target = players.stream()
                .filter(p->p.getUsername().equals(Json.readJson(this.getSocket()).get("username")))
                .findFirst().orElse(this);
        Map<String,String> bankAccount = new HashMap<>();
        bankAccount.put("result",Double.valueOf(target.getProfit()).toString());
        Json.writeJson(this.getSocket(),bankAccount);
    }
}
