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
        System.out.println("sono dentro");
        Player target = players.stream()
                .filter(p->p.getUsername().equals(this.read().get("username")))
                .findFirst().orElse(this);

        double loot = target.getProfit()*0.05;
        target.addProfit(-loot);
        this.addProfit(loot);
        System.out.println("sono al centro");
        Map<String,String> json = new HashMap<>();
        json.put("result",Double.valueOf(loot).toString());
        System.out.println("sto per scrivere");
        this.write(json);
    }
}
