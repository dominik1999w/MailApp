package Types;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class InfoType {
    private Integer index;
    private String date;
    private String user;
    private String subject;
    private String message;

    public InfoType(Integer index, Timestamp date, String user, String subject, String message) {
        this.index = index;
        this.date = date == null ? null : new SimpleDateFormat("MMM-dd-YYYY h:mm a").format(date);
        this.user = user;
        this.subject = subject;
        this.message = message;
    }

    public Integer getIndex() {
        return index;
    }

    public String getDate() {
        return date;
    }

    public String getUser() {
        return user;
    }

    public String getSubject() {
        return subject;
    }

    public String getMessage() {
        return message;
    }


}
