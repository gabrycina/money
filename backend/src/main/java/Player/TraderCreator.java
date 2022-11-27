package Player;

public class TraderCreator implements PlayerCreator {
    public TraderCreator(){

    }

    @Override
    public Player create() {
        return new Trader();
    }
}
