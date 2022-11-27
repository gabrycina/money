package Player;

public class DetectiveCreator implements PlayerCreator {
    public DetectiveCreator(){

    }

    @Override
    public Player create() {
        return new Detective();
    }
}
