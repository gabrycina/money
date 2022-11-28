package Player;

import java.net.Socket;

public class Hacker extends Player {

    public Hacker(String id, String username, double money,Socket player){
        super(id,username,money,player);
    }

    @Override
    public String getRole(){
        return "Hacker";
    }
    @Override
    public void useSuperPower(){

    }
    @Override
    public void save(){

    }
}
