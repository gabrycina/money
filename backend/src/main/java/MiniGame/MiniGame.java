package MiniGame;

import Handler.Json;
import Player.Player;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public abstract class MiniGame {
    private double profit;
    protected List<Player> players;
    protected int round;
    protected Player lastWinner;
    protected double lastPrize;
    protected Map<String,String> lastAnswer = new HashMap<>();

    protected void reportToAll(Map<String,String> json){
        for (Player player:this.players)
            Json.writeJson(player.getSocket(), json);
    }

    protected void checkSplit(){
        Map<String, String> json = new HashMap<>();
        if(Json.readJson(this.lastWinner.getSocket()).get("split").equals("true")){
            json.put("prize", Double.valueOf(this.lastPrize/this.players.size()).toString());
            this.players.forEach(p -> {
                p.addProfit(this.lastPrize/this.players.size());
                Json.writeJson(p.getSocket(), json); //reportToAll needs O(n) time. It's better notify all here.
            });
        }else{
            json.put("prize", "0");
            this.lastWinner.addProfit(this.lastPrize);
            this.players.stream()
                    .filter(p->!p.getUsername().equals(this.lastWinner.getUsername()))
                    .forEach(p -> Json.writeJson(p.getSocket(), json));
        }
    }

    protected void receiveMoney(){
        for (Player player:this.players){
            Map<String,String> json = Json.readJson(player.getSocket());
            String username = json.get("username");
            if (!username.equals("")){
                double money = Double.parseDouble(json.get("money"));
                final Map<String, String> finalJson = new HashMap<>();
                finalJson.put("prize", Double.toString(money));
                this.players.stream()
                        .filter(p -> p.getUsername().equals(username))
                        .forEach(p->{ //therefore username is unique the player will be one
                            p.addProfit(money);
                            Json.writeJson(p.getSocket(),finalJson);
                        });
            }
        }
    }

    protected Map<String,String> getLastAnswer(){
        return this.lastAnswer;
    }
    abstract public Player validate();
    abstract public String getRules();
    abstract public double getPrize();
    abstract public void play(List<Player> players);
}
