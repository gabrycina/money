package MiniGame;

public class MaxCreator implements MiniGameCreator{
    public MaxCreator(){

    }

    @Override
    public MiniGame create() {
        return new Max();
    }
}
