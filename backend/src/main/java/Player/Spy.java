package Player;

import java.net.Socket;

public class Spy extends Player {
    public Spy(String id, String username, double money,Socket player){
        super(id,username,money,player);
    }

    @Override
    public String getRole(){
        return "Spy";
    }
    @Override
    public void useSuperPower(){

    }
    @Override
    public void save(){

    }
}
