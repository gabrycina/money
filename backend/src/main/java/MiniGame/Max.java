package MiniGame;

import Player.Player;
import java.util.*;
import java.sql.Timestamp;

public class Max extends MiniGame {
    @Override
    public void play(List<Player> players){
        this.players = players;
        this.profit = 150;
        Map<String,String> json;
        // send rules;
        json = new HashMap<>();
        json.put("miniGame","Max");
        json.put("miniGameRules", this.getRules());
        this.reportToAll(json);

        for(int i=1; i<3; i++) {
            this.round = i;
            //send timestamp
            json = new HashMap<>();
            json.put("timeStamp", new Timestamp(new Date().getTime()).toString());
            this.reportToAll(json);
            // validate, set last winner and send him the prize
            this.validate(); //player1
            json = new HashMap<>();
            if (this.lastWinner == null){
                json.put("winner","false");
                json.put("prize", "0");
                this.reportToAll(json);
            }else {
                if(this.round==2) this.lastWinner.addToken();
                json.put("winner", "true");
                json.put("prize", Double.valueOf(this.lastPrize).toString());
                this.lastWinner.write(json);
                //check split
                this.checkSplit();
            }
            // receive player and money to send
            this.receiveMoney();
            json = new HashMap<>();
            json.put("nextStep","true");
            this.reportToAll(json);
            // check if the player wants to use superpower
            for (Player player:this.players) {
                json = player.read();
                System.out.println(player.getRole()+" "+player.getUsername());
                if (json.get("useSuperPower").equals("true"))
                    player.useSuperPower(players,this.lastWinner,this.lastAnswer);
            }
            for (Player player:this.players) {
                System.out.println("Prima" + player.getUsername());
                player.read();
                System.out.println("dopo" + player.getUsername());
            };
            json = new HashMap<>();
            for (Player player:this.players) {
                json.put("bankAccount",String.valueOf(player.getProfit()));
                player.write(json);
            };
        }
    }

    @Override
    public void validate() {
        Map<String,String> json;
        Map<Integer,List<Player>> options = new HashMap<>();
        int option;
        double sumOption = 0;

        for (Player player:this.players){
            json = player.read();
            option = Integer.parseInt(json.get("option"));
            sumOption += option;

            List<Player> list = options.get(option);
            if (list == null)
                list = new ArrayList<>();
            list.add(player);

            options.put(option,list);
            this.lastAnswer.put(player.getUsername(), String.valueOf(option));
        }

        int res = options.entrySet().stream()
                    .filter(e->e.getValue().size()==1)
                    .map(Map.Entry::getKey).max(Comparator.naturalOrder()).orElse(-1);

        if (res != -1) this.lastWinner=options.get(res).get(0);
        else this.lastWinner = null;

        this.lastPrize = Math.round(((100+400*(this.round-1))/sumOption)*100)/100.0;
    }

    @Override
    public String getRules(){
        return """
                Each player choose a number between [0, 20]. The player that put the maximum **unique** number wins the price divided by the sum of all the numbers. (if there is no unique number there is no winner)
                
                Round 1: 100$
                Round 2: 500$ + 1M
               """;
    }
}
