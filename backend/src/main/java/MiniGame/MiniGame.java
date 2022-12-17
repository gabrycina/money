package MiniGame;

import Player.Player;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public abstract class MiniGame {
    protected double profit;
    protected List<Player> players;
    protected int round;
    protected Player lastWinner;
    protected double lastPrize;
    protected Map<String,String> lastAnswer = new HashMap<>();

    protected void reportToAll(Map<String,String> json){
        for (Player player:this.players)
           player.write(json);
    }

    protected void checkSplit(){
        Map<String, String> json = new HashMap<>();
        json.put("winner", "false");
        if(this.lastWinner.read().get("split").equals("true")){
            json.put("prize", Double.valueOf(this.lastPrize/this.players.size()).toString());
            this.players.forEach(p -> {
                p.addProfit(this.lastPrize/this.players.size());
                p.write(json); //reportToAll needs O(n) time. It's better notify all here.
            });
        }else{
            json.put("prize", "0");
            this.lastWinner.addProfit(this.lastPrize);
            this.reportToAll(json);
        }
    }

    protected void receiveMoney(){
        for (Player player:this.players){
            Map<String,String> json = player.read();
            String username = json.get("username");
            if (!username.equals("")){
                double money = Double.parseDouble(json.get("prize"));
                player.addProfit(-money);
                final Map<String, String> finalJson = new HashMap<>();
                finalJson.put("prize", json.get("prize"));
                this.players.stream()
                        .filter(p -> p.getUsername().equals(username))
                        .forEach(p->{ //therefore username is unique the player will be one
                            p.addProfit(money);
                            p.write(finalJson);
                        });
            }
        }
    }

    public double getProfit(){
        return this.profit;
    }
    abstract public void play(List<Player> players);
    abstract public void validate();
    abstract public String getRules();
}
