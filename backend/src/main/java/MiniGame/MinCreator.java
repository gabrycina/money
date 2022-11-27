package MiniGame;

public class MinCreator implements MiniGameCreator{
    public MinCreator(){

    }

    @Override
    public MiniGame create() {
        return new Min();
    }
}
