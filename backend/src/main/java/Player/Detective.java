package Player;

import java.net.Socket;

public class Detective extends Player {

    public Detective(String id, String username, double money,Socket player) {
        super(id,username,money,player);
    }

    @Override
    public String getRole(){
        return new String("Detective");
    }
    @Override
    public void useSuperPower(){

    }
    @Override
    public void save(){

    }
}
