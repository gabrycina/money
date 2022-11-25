package Player;

public class HackerCreator implements PlayerCreator {
    public HackerCreator(){

    }

    @Override
    public Player create() {
        return new Hacker();
    }
}
