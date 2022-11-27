package Player;

public class SpyCreator implements PlayerCreator {
    public SpyCreator(){

    }

    @Override
    public Player create() {
        return new Spy();
    }
}
