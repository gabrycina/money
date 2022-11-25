package Player;

public class RobberCreator implements PlayerCreator {
    public RobberCreator(){

    }

    @Override
    public Player create() {
        return new Robber();
    }
}
