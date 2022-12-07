package MiniGame;

public class MaxCreator implements MiniGameCreator{
    @Override
    public MiniGame create() {
        return new Max();
    }
}
