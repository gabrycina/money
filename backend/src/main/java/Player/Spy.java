package Player;

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
    public void useSuperPower(List<Player> players, Player lastWinner, Map<String,String> lastAnswer){
        String username = this.read().get("username");
        Player target = players.stream()
                .filter(p->p.getUsername().equals(username))
                .findFirst().orElse(this);

        Map<String,String> bankAccount = new HashMap<>();
        bankAccount.put("result", target.getUsername() + " has got " + Double.valueOf(target.getProfit()).toString() + "$");
        this.write(bankAccount);
    }
}
