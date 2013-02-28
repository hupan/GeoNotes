package session;

import javax.ejb.Local;

@Local
public interface LoginLocal {
    public int login(String username, String passwd);
    public boolean register(String username, String passwd);
}
