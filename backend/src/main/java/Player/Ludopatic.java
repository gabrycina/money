package Player;

import Handler.Json;

import java.net.Socket;
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
    public void useSuperPower(List<Player> players, Player lastWinner, double lastPrize, Map<String,String> lastAnswer){
        Map<String,String> json = Json.readJson(this.getSocket());
        String betOn = json.get("username");
    }

    @Override
    public void save(){

    }
}
