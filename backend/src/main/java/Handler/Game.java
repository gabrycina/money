package Handler;

import MiniGame.*;
import Player.*;
import java.net.Socket;
import java.util.*;
import java.util.stream.Collectors;

public class Game {
    private static Integer id=1272;
    private final String ID_GAME;
    private final List<Player> PLAYERS;
    private final List<MiniGame> MINI_GAMES;
    private final List<Integer> ROLE;
    private PlayerCreator playerCreator;
    private MiniGameCreator miniGameCreator;
    private int roleIndex = 0;

    public Game(){
        id++;
        this.ID_GAME = id.toString();
        this.PLAYERS = new ArrayList<>();
        this.MINI_GAMES = new ArrayList<>();

        this.ROLE = new ArrayList<>(Arrays.asList(0,1,2,3,4));
        Collections.shuffle(this.ROLE);

        List<Integer> miniGames = Arrays.asList(0,1,2,3);
        Collections.shuffle(miniGames);
        miniGames = Arrays.asList(miniGames.get(0),miniGames.get(1));
        this.assignMiniGames(miniGames);
    }

    private void assignMiniGames(List<Integer> miniGames) {
        for(int i:miniGames){
            if(miniGames.get(0)==3) Collections.swap(miniGames,0,1);
            switch (i) {
                case 0 -> this.miniGameCreator = new MaxCreator();
                case 1 -> this.miniGameCreator = new MinCreator();
                case 2 -> this.miniGameCreator = new ChoosePrizeCreator();
                case 3 -> this.miniGameCreator = new SplitCreator();
            }
            this.MINI_GAMES.add(this.miniGameCreator.create());
        }
    }

    public void assignRole (User user,Socket player) { //user --> player
        switch (this.ROLE.get(roleIndex++)) {
            case 0 -> this.playerCreator = new HackerCreator(user.getId(), user.getUsername(), user.getMoney(), player);
            case 1 -> this.playerCreator = new LudopaticCreator(user.getId(), user.getUsername(), user.getMoney(), player);
            case 2 -> this.playerCreator = new SpyCreator(user.getId(), user.getUsername(), user.getMoney(), player);
            case 3 -> this.playerCreator = new RobberCreator(user.getId(), user.getUsername(), user.getMoney(), player);
            case 4 -> this.playerCreator = new DetectiveCreator(user.getId(), user.getUsername(), user.getMoney(), player);
        }
        this.PLAYERS.add(this.playerCreator.create());

        Map<String, String> json = new HashMap<>();
        json.put("code", this.getId());
        json.put("players", this.PLAYERS.stream().map(Player::getUsername).toList().toString());
        this.reportToAll(json);

        if (roleIndex == 5) this.play();
    }

    public String getId(){
        return this.ID_GAME;
    }

    private void reportToAll(Map<String,String> json){
        for (Player player:this.PLAYERS)
            Json.writeJson(player.getSocket(),json);
    }

    private void play() {
        Map<String,String> resp = new HashMap<>();

        for(Player player:this.PLAYERS) {
            resp.put("playerRole", player.getRole());
            Json.writeJson(player.getSocket(),resp);
        }

        for(MiniGame miniGame:this.MINI_GAMES) {
            miniGame.play(this.PLAYERS);
            resp = new HashMap<>();
            resp.put("maxProfit",String.valueOf(miniGame.getProfit()));
            this.reportToAll(resp);
        }

        Player briefCaseWinner = this.PLAYERS.stream()
                .max(Comparator.comparing(Player::getToken))
                .orElse(this.PLAYERS.get(0));

        briefCaseWinner.addProfit(300); //briefCase prize

        resp = this.PLAYERS.stream()
                .collect(Collectors.toMap(
                        Player::getUsername,
                        p->String.valueOf(p.getProfit()))
                ); //leaderBoard

        resp.put("briefcase",briefCaseWinner.getUsername());
        this.reportToAll(resp);

        for(Player player:this.PLAYERS){
            player.save();
            //send player back to main menu
            Handler clientSock = new Handler(player.getSocket());
            new Thread(clientSock).start();
        }
    }
}
