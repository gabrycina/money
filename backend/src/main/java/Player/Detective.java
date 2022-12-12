package Player;

import Handler.Json;

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
        json.put("result",lastWinner.getUsername());
        Json.writeJson(this.getSocket(),json);
    }
}
