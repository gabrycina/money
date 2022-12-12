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
        this.profit = 0;
        Map<String,String> json;
        // send rules;
        json = new HashMap<>();
        json.put("miniGame","ChoosePrize");
        json.put("miniGameRules", this.getRules());
        this.reportToAll(json);

        double tmp;
        for(int i=1; i<3; i++) {
            this.round = i;
            tmp = this.players.stream().mapToDouble(Player::getProfit).sum();
            this.profit += (tmp+tmp*0.25*this.round)/this.players.size();
            //send timestamp
            json = new HashMap<>();
            json.put("timeStamp", new Timestamp(new Date().getTime()).toString());
            this.reportToAll(json);
            // validate
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
        double box = 0;
        String option;
        for (Player player:this.players){
            json = Json.readJson(player.getSocket());
            option = json.get("option");
            box += Double.parseDouble(option);
            player.addProfit(-Double.parseDouble(option));
            this.lastAnswer.put(player.getUsername(),option);
        }
        final double finalBox = (box + box*(0.25*this.round))/this.players.size();
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
        return """
                Each player choose an amount from their bank account and put it in a box
                At the end of the round, every player get the (total money in the box plus a X%) divided equally by the number of players
                Round 1: 25%
                Round 2: 50%
               """;
    }

}