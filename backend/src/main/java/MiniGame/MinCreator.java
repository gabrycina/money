package MiniGame;

public class MinCreator implements MiniGameCreator{
    @Override
    public MiniGame create() {
        return new Min();
    }
}
