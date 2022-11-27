package Handler;

import java.util.HashMap;
import java.util.Map;

public class MockRedis {
    private Map<String,Game> data;
    private static MockRedis db;

    private MockRedis() {
        this.data = new HashMap<>();
    }

    public static MockRedis getDb() {
        if (db==null) db = new MockRedis();
        return db;
    }

    public String putGame(Game game){
        Integer s = game.hashCode();
        this.data.put(s.toString(),game);
        return s.toString();
    }

    public Game getGame(String s){
        return this.data.get(s);
    }
}
