package session;

import javax.ejb.Local;

@Local
public interface ShareLocationLocal {
    public void shareLocation(String phonenumber, String latitude, String longitude);
}
