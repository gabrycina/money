package MiniGame;

import Handler.Json;
import Player.Player;
import java.util.*;
import java.sql.Timestamp;

public class Max extends MiniGame {
    @Override
    public void play(List<Player> players){
        this.players = players;
        Map<String,String> json;
        for(int i=1; i<3; i++) {
            this.round = i;
            // send rules;
            json = new HashMap<>();
            json.put("miniGameRules", this.getRules());
            this.reportToAll(json);
            //send timestamp
            json = new HashMap<>();
            json.put("timeStamp", new Timestamp(new Date().getTime()).toString());
            this.reportToAll(json);
            // validate, set last winner and send him the prize
            this.validate();
            json = new HashMap<>();
            if (this.lastWinner == null){
                json.put("winner","false");
                json.put("prize", "0");
                this.reportToAll(json);
            }else {
                this.lastPrize = this.getPrize();
                json.put("winner", "true");
                json.put("prize", Double.valueOf(this.lastPrize).toString());
                Json.writeJson(this.lastWinner.getSocket(), json);
                //check split
                this.checkSplit();
            }
            // receive player and money to send
            this.receiveMoney();
            // check if the player wants to use superpower
            for (Player player:this.players) {
                json = Json.readJson(player.getSocket());
                if (json.get("useSuperPower").equals("true"))
                    player.useSuperPower(players,this.lastWinner,this.lastPrize,this.lastAnswer);
            }
        }
    }

    @Override
    public void validate() {
        Map<String,String> json;
        Map<Integer,List<Player>> options = new HashMap<>();
        int option;

        for (Player player:this.players){
            json = Json.readJson(player.getSocket());
            option = Integer.parseInt(json.get("option"));

            List<Player> list = options.get(option);
            if (list == null)
                list = new ArrayList<>();
            list.add(player);

            options.put(option,list);
            this.lastAnswer.put("player", String.valueOf(option));
        }

        int res = options.entrySet().stream()
                    .filter(e->e.getValue().size()==1)
                    .map(Map.Entry::getKey).max(Comparator.naturalOrder()).orElse(-1);

        if (res != -1) this.lastWinner=options.get(res).get(0);
        else this.lastWinner = null;
    }

    @Override
    public String getRules(){
        return "rule";
    }
}
