package Player;

import java.net.Socket;

public class Robber extends Player {
    public Robber(String id, String username, double money,Socket player){
        super(id,username,money,player);
    }

    @Override
    public String getRole(){
        return new String("Robber");
    }
    @Override
    public void useSuperPower(){

    }
    @Override
    public void save(){

    }
}
