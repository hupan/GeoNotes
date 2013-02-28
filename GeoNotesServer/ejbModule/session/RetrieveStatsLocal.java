package session;

import javax.ejb.Local;

@Local
public interface RetrieveStatsLocal {
    public String getAllStats();
    public String getStatsByUsername(String username);
}
