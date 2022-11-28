package Handler;

import MiniGame.*;
import Player.*;
import java.net.Socket;
import java.util.*;

public class Game {
    private static Integer id=1272;
    private final String idGame;
    private List<Player> players;
    private List<MiniGame> miniGames;
    private List<Integer> role;
    private Timer timer;
    private PlayerCreator playerCreator;
    private MiniGameCreator miniGameCreator;

    public Game(){
        id++;
        this.idGame = id.toString();
        this.players = new ArrayList<>();
        this.miniGames = new ArrayList<>();

        this.role = new ArrayList<>(Arrays.asList(0,1,2,3,4));
        Collections.shuffle(this.role);

        List<Integer> miniGames = Arrays.asList(0,1,2,3,4);
        Collections.shuffle(miniGames);
        miniGames = Arrays.asList(miniGames.get(0),miniGames.get(1));
        this.assignMiniGames(miniGames);
    }

    public void assignRole (User user,Socket player) { //adesso user diventa player
        switch (this.role.get(0)) {
            case 0:
                this.playerCreator = new HackerCreator(user.getId(),user.getUsername(),user.getMoney(),player);
                break;
            case 1:
                this.playerCreator = new TraderCreator(user.getId(),user.getUsername(),user.getMoney(),player);
                break;
            case 2:
                this.playerCreator = new SpyCreator(user.getId(),user.getUsername(),user.getMoney(),player);
                break;
            case 3:
                this.playerCreator = new RobberCreator(user.getId(),user.getUsername(),user.getMoney(),player);
                break;
            case 4:
                this.playerCreator = new DetectiveCreator(user.getId(),user.getUsername(),user.getMoney(),player);
                break;
        }
        this.players.add(this.playerCreator.create());
        this.role.remove(0);
    }

    private void assignMiniGames(List<Integer> miniGames) {
        for(int i:miniGames){
            switch (i) {
                case 0:
                    this.miniGameCreator = new MaxCreator();
                    break;
                case 1:
                    this.miniGameCreator = new MinCreator();
                    break;
                case 2:
                    this.miniGameCreator = new ChoosePrizeCreator();
                    break;
                case 3:
                    this.miniGameCreator = new SplitCreator();
                    break;
            }
            this.miniGames.add(this.miniGameCreator.create());
        }
    }

    public String getId(){
        return this.idGame;
    }

    public void reportToAll(){
        Map<String, String> json = new HashMap<>();
        json.put("code",this.getId());
        List<String> users = players.stream().map(Player::getUsername).toList();
        json.put("players",users.toString());
        for (Player player: this.players){
            Json.writeJson(player.getSocket(),json);
        }
    }
}
