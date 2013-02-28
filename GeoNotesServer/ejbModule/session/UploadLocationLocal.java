package session;

import javax.ejb.Local;

@Local
public interface UploadLocationLocal {
    public boolean upload(String placename, String description, String latitude, String longitude);
}
