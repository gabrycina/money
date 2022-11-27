package MiniGame;

public class SplitCreator implements MiniGameCreator{
    public SplitCreator(){

    }

    @Override
    public MiniGame create() {
        return new Split();
    }
}
