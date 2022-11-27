package MiniGame;

public class ChoosePrizeCreator implements MiniGameCreator{
    public ChoosePrizeCreator(){

    }

    @Override
    public MiniGame create() {
        return new ChoosePrize();
    }
}
