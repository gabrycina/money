package Player;

public class User {
    private final String id;
    private final String username;
    private double money;

    public User(String id, String username, double money){
        this.id = id;
        this.username = username;
        this.money = money;
    }

    public void addMoney(double money){
        this.money += money;
    }

    public String getId(){
        return this.id;
    }

    public String getUsername(){
        return this.username;
    }

    public double getMoney(){
        return this.money;
    }
}
