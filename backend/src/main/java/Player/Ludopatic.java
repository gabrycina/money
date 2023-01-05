package Player;

import java.net.Socket;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Ludopatic extends Player {

    public Ludopatic(String id, String username, double money,Socket player){
        super(id,username,money,player);
    }

    @Override
    public String getRole(){
        return "Ludopatic";
    }

    @Override
    public void useSuperPower(List<Player> players, Player lastWinner, Map<String,String> lastAnswer){
        System.out.println("sono dentro");
        Player target = players.stream()
                .filter(p->p.getUsername().equals(this.read().get("username")))
                .findFirst().orElse(this);
        System.out.println("sono al centro");
        this.addProfit(target.getProfit()*0.1);
        Map<String,String> json = new HashMap<>();
        json.put("result",Double.valueOf(target.getProfit()*0.1).toString());
        System.out.println("sto per scrivere");
        this.write(json);
    }
}
