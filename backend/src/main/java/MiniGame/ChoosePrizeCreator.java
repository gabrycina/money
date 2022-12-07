package MiniGame;

public class ChoosePrizeCreator implements MiniGameCreator{
    @Override
    public MiniGame create() {
        return new ChoosePrize();
    }
}
