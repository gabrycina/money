package Player;

import java.net.Socket;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Detective extends Player {

    public Detective(String id, String username, double money,Socket player) {
        super(id,username,money,player);
    }

    @Override
    public String getRole(){
        return "Detective";
    }

    @Override
    public void useSuperPower(List<Player> players, Player lastWinner, Map<String,String> lastAnswer){
        Map<String,String> json = new HashMap<>();
        if (lastWinner==null) json.put("result","nobody");
        else json.put("result",lastWinner.getUsername());
        this.write(json);
    }
}
