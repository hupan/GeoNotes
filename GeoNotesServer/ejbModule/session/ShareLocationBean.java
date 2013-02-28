package session;

import java.io.IOException;
import javax.ejb.Stateless;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebResult;
import javax.jws.WebService;
import javax.jws.soap.SOAPBinding;
import javax.jws.soap.SOAPBinding.Style;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpMethod;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.GetMethod;
import org.marre.SmsSender;

@Stateless(mappedName="ShareLocationBean")
@WebService(serviceName = "ShareLocationService")
@SOAPBinding(style = Style.RPC)
public class ShareLocationBean implements ShareLocationLocal {

    @Override
    @WebMethod(operationName = "shareLocation")
    public void shareLocation(@WebParam(name="phonenumber")String phonenumber, @WebParam(name="latitude")String latitude,
            @WebParam(name="longitude")String longitude) {
        // TODO Auto-generated method stub
        String longurl = "http://www.pandahoo.com:8080/GeoNotesWeb/ext.jsp?latitude=" + latitude +"&longitude=" + longitude;
        String message = this.getShorterURL(longurl);
        SmsSender smsSender = null;
        try {
            smsSender = SmsSender.getClickatellSender("hupan100", "eZWcDTNPAFBcUa", "3412851");

            String reciever = phonenumber;
            if(smsSender!=null){
                smsSender.connect();
                smsSender.sendTextSms(message, reciever);
                smsSender.disconnect();
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
    
    @WebMethod(operationName = "getShorterURL")
    @WebResult(name = "shortURL")
    public String getShorterURL(@WebParam(name="URL")String url) {
        HttpClient httpclient = new HttpClient();
        
        // Prepare a request object
        HttpMethod method = new GetMethod("http://tinyurl.com/api-create.php"); 
        method.setQueryString(new NameValuePair[]{new NameValuePair("url",url)});
        
        String tinyUrl = new String("");
        try {
            httpclient.executeMethod(method);
            tinyUrl = method.getResponseBodyAsString();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        method.releaseConnection();
        return tinyUrl;
    }
    
}
