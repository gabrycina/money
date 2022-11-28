package Player;

import java.net.Socket;

public class Trader extends Player {
    public Trader(String id, String username, double money,Socket player){
        super(id,username,money,player);
    }

    @Override
    public String getRole(){
        return new String("Trader");
    }
    @Override
    public void useSuperPower(){

    }
    @Override
    public void save(){

    }
}
