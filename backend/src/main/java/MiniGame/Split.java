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
            json.put("miniGame_rules", this.getRules());
            this.reportToAll(json);
            //send timestamp
            json = new HashMap<>();
            json.put("timeStamp", new Timestamp(new Date().getTime()).toString());
            this.reportToAll(json);
            // validate
            this.validate();
            //next step
            json = new HashMap<>();
            json.put("nextStep", "true");
            this.reportToAll(json);
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
    public Player validate() {
        Map<String,String> json;
        double box = 0;
        for (Player player:this.players){
            json = Json.readJson(player.getSocket());
            box += Double.parseDouble(json.get("money"));
            this.lastAnswer.put(player.getUsername(),json.get("money"));
        }
        final double finalBox = (box + box*0.2)/this.players.size();
        this.players.forEach(p->{
            p.addProfit(finalBox);
            //reportToAll needs O(n) time. It's better notify all here.
            Map<String,String> prize = new HashMap<>();
            prize.put("prize", Double.valueOf(finalBox).toString());
            Json.writeJson(p.getSocket(),prize);
        });
        return null;
    }

    @Override
    public String getRules(){
        return "rule";
    }

    @Override
    public double getPrize(){
        return 13.3;
    }
}