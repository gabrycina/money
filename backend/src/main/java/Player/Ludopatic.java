package Player;

import java.net.Socket;

public class Ludopatic extends Player {
    public Ludopatic(String id, String username, double money,Socket player){
        super(id,username,money,player);
    }

    @Override
    public String getRole(){
        return "Ludopatic";
    }
    @Override
    public void useSuperPower(){

    }
    @Override
    public void save(){

    }
}
