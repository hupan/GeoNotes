package session;

import javax.ejb.Local;

@Local
public interface AddStatLocal {
    public void addStat(String username, String routeid, String timespent);
    
}
