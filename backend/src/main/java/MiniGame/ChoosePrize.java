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
            json.put("miniGameRules", this.getRules());
            this.reportToAll(json);
            //send timestamp
            json = new HashMap<>();
            json.put("timeStamp", new Timestamp(new Date().getTime()).toString());
            this.reportToAll(json);
            // validate,
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
        Map<String,List<Player>> options = new HashMap<>();
        String option;

        for (Player player:this.players){
            json = Json.readJson(player.getSocket());
            option = json.get("option");

            List<Player> list = options.get(option);
            if (list == null)
                list = new ArrayList<>();
            list.add(player);

            options.put(option,list);
            this.lastAnswer.put("player", String.valueOf(option));
        }

        this.boost = true;
        json = new HashMap<>();
        json.put("winner","false");
        double prize;
        for(Map.Entry<String,List<Player>> e:options.entrySet()){
            if(e.getValue().size()==1) {
                if (e.getKey().equals("M")) {
                    e.getValue().get(0).addToken();
                    if (this.round == 2) {
                        if (this.boost){
                            e.getValue().get(0).addToken();
                            json.put("prize","3M");
                        }
                        e.getValue().get(0).addToken();
                        json.put("prize","2M");
                    }
                    json.put("prize","M");
                } else{
                    prize = Double.parseDouble(e.getKey());
                    if (this.round == 2) {
                        if (this.boost) prize += prize;
                        else prize += prize * 0.2;
                    }
                    e.getValue().get(0).addProfit(prize);
                    json.put("prize",String.valueOf(prize));
                }
                Json.writeJson(e.getValue().get(0).getSocket(),json);
            } else {
                this.boost = false;
                json.put("prize","0");
                for (Player player:e.getValue())
                    Json.writeJson(player.getSocket(),json);
            }
        }
    }

    @Override
    public String getRules(){
        return "rule";
    }
}
