package MiniGame;

public class SplitCreator implements MiniGameCreator{
    @Override
    public MiniGame create() {
        return new Split();
    }
}
