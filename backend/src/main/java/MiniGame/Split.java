package MiniGame;

import Handler.Json;
import Player.Player;

import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Split extends MiniGame {
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
            // validate
            this.validate();
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
        double box = 0;
        String option;
        for (Player player:this.players){
            json = Json.readJson(player.getSocket());
            option = json.get("option");
            box += Double.parseDouble(option);
            player.addProfit(-Double.parseDouble(option));
            this.lastAnswer.put(player.getUsername(),option);
        }
        final double finalBox = (box + box*0.2)/this.players.size();
        this.players.forEach(p->{
            p.addProfit(finalBox);
            //reportToAll needs O(n) time. It's better notify all here.
            Map<String,String> prize = new HashMap<>();
            prize.put("winner","false");
            prize.put("prize", Double.valueOf(finalBox).toString());
            Json.writeJson(p.getSocket(),prize);
        });
    }

    @Override
    public String getRules(){
        return "rule";
    }

}