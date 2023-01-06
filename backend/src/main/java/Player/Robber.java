package Player;

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
    public void useSuperPower(List<Player> players, Player lastWinner, Map<String,String> lastAnswer){
        String username = this.read().get("username");
        Player target = players.stream()
                .filter(p->p.getUsername().equals(username))
                .findFirst().orElse(this);

        double loot = Math.round(target.getProfit()*0.05*100)/100.0;
        target.addProfit(-loot);
        this.addProfit(loot);

        Map<String,String> json = new HashMap<>();
        json.put("result", "You stole " + Double.valueOf(loot).toString() + "$ from " + target.getUsername());
        this.write(json);
    }
}
