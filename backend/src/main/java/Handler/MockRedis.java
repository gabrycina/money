package Handler;

import java.util.HashMap;
import java.util.Map;

public class MockRedis {
    private final Map<String,Game> data;
    private static MockRedis db;

    private MockRedis() {
        this.data = new HashMap<>();
    }

    public static MockRedis getDb() {
        if (db==null) db = new MockRedis();
        return db;
    }

    public void putGame(String id, Game game){
        this.data.put(id,game);
    }

    public Game getGame(String s){
        return this.data.get(s);
    }
}
