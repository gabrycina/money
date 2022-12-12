package MiniGame;

import Handler.Json;
import Player.Player;

import java.sql.Timestamp;
import java.util.*;

public class ChoosePrize extends MiniGame {
    private boolean boost;

    public ChoosePrize() {
        this.boost = true;
    }

    @Override
    public void play(List<Player> players){
        this.players = players;
        this.profit = 600;
        Map<String,String> json;
        // send rules;
        json = new HashMap<>();
        json.put("miniGame","ChoosePrize");
        json.put("miniGameRules", this.getRules());
        this.reportToAll(json);

        for(int i=1; i<3; i++) {
            this.round = i;
            //send timestamp
            json = new HashMap<>();
            json.put("timeStamp", new Timestamp(new Date().getTime()).toString());
            this.reportToAll(json);
            // validate,
            this.validate();
            // receive player and money to send
            this.receiveMoney();
            json = new HashMap<>();
            json.put("nextStep","true");
            this.reportToAll(json);
            // check if the player wants to use superpower
            for (Player player:this.players) {
                json = Json.readJson(player.getSocket());
                if (json.get("useSuperPower").equals("true"))
                    player.useSuperPower(players,this.lastWinner,this.lastAnswer);
            }
            json = new HashMap<>();
            json.put("nextStep","true");
            this.reportToAll(json);
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

        json = new HashMap<>();
        json.put("winner","false");
        double prize;
        for(Map.Entry<String,List<Player>> e:options.entrySet()){
            if(e.getValue().size()==1) {
                if (e.getKey().equals("M") || e.getKey().equals("2M")) {
                    e.getValue().get(0).addToken();
                    if (e.getKey().equals("2M")) e.getValue().get(0).addToken();
                } else{
                    prize = Double.parseDouble(e.getKey());
                    e.getValue().get(0).addProfit(prize);
                }
                json.put("prize",e.getKey());
                Json.writeJson(e.getValue().get(0).getSocket(),json);
            } else {
                this.boost = false;
                json.put("prize","0");
                for (Player player:e.getValue())
                    Json.writeJson(player.getSocket(),json);
            }
        }
        json = new HashMap<>();
        json.put("boost",String.valueOf(this.boost));
        this.reportToAll(json);
    }

    @Override
    public String getRules(){
        return """
                Each player choose a price [X, Y, Z, W]
                If everyone choose a different price the next round is boosted
                If two players (or n players) choose the same price they got nothing
                Round 1: [0, 50, 100, M]
                Round 2: [-50, 100, 500, M]
                Round 2 (boosted): [100, 250, 500, 2M]
               """;
    }
}
