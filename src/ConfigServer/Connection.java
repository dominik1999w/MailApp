package ConfigServer;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Date;
import java.util.Properties;

public class Connection {
    private static Session session;
    public static Store storeIMAP;

    Connection(final String username, final String password) throws MessagingException {

        String host = "smtp.gmail.com";
        String port = "587";
        Properties properties = new Properties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", port);
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");

        Authenticator auth = new Authenticator() {
            public PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        };

        session = Session.getInstance(properties, auth);
        session.getTransport().connect();

        //create IMAP
        Properties propertiesIMAP = new Properties();
        propertiesIMAP.put("mail.store.protocol", "imaps");
        Session emailSession = Session.getDefaultInstance(propertiesIMAP);
        storeIMAP = emailSession.getStore("imaps");
        storeIMAP.connect("imap.googlemail.com", username, password);
    }

    public static void SendEmail(final String receiver, final String subject, final String content) throws MessagingException {
        Message msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(Login.username));
        InternetAddress[] toAddresses = {new InternetAddress(receiver)};
        msg.setRecipients(Message.RecipientType.TO, toAddresses);
        msg.setSubject(subject);
        msg.setSentDate(new Date());
        msg.setText(content);
        Transport.send(msg);
    }
}