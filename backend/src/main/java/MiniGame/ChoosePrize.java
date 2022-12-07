package MiniGame;

import Handler.Json;
import Player.Player;

import java.sql.Timestamp;
import java.util.*;

public class ChoosePrize extends MiniGame {
    private boolean boost;

    public ChoosePrize() {
        this.boost = false;
    }

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
            // validate,
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
        Set<String> set = new HashSet<>();
        for(Player player:this.players){
            json = Json.readJson(player.getSocket());
            set.add(json.get("prize"));
            this.lastAnswer.put(player.getUsername(),json.get("prize"));
        }
        if(set.size()==this.players.size()) this.boost = true; //everyone choose a different prize
        return null;
    }

    @Override
    public String getRules(){
        return "rule";
    }

    @Override
    public double getPrize(){
        return 13.2;
    }

    public boolean getBoost(){
        return this.boost;
    }
}
