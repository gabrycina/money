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
            json.put("miniGame_rules", this.getRules());
            this.reportToAll(json);
            //send timestamp
            json = new HashMap<>();
            json.put("timeStamp", new Timestamp(new Date().getTime()).toString());
            this.reportToAll(json);
            // validate, set last winner and send him the prize
            this.lastWinner = this.validate();
            this.lastPrize = this.getPrize();
            json = new HashMap<>();
            json.put("prize", Double.valueOf(this.lastPrize).toString());
            Json.writeJson(this.lastWinner.getSocket(), json);
            //check split
            this.checkSplit();
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
        Player winner = null;
        Timestamp tmp = Timestamp.valueOf("2999-12-12 23:59:59");
        Timestamp timeStamp;
        int max = Integer.MIN_VALUE;
        int option;
        for (Player player:this.players){
            json = Json.readJson(player.getSocket());
            timeStamp = Timestamp.valueOf(json.get("timeStamp"));
            option = Integer.parseInt(json.get("option"));
            this.lastAnswer.put(player.getUsername(),json.get("option"));
            if(option > max && timeStamp.compareTo(tmp)<0){
                max = option;
                tmp = timeStamp;
                winner = player;
            }
        }
        return winner;
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
