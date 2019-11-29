package ConfigAttributes;

import ConfigServer.Connection;
import Database.Database;
import Types.InfoType;

import javax.mail.Folder;
import javax.mail.Message;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.Arrays;
import java.util.Collections;
import java.util.Vector;

import static java.lang.Math.min;

@WebServlet("/FetchEmailController")
public class FetchEmailController extends HttpServlet {
    public static boolean showReceived = false;

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getParameter("showReceived") != null) {
            showReceived = true;
            getServletContext().getRequestDispatcher("/HomePage.jsp").forward(request, response);
        } else {
            try {
                int maxNumberEmails = Integer.parseInt(request.getParameter("maxNumberEmails"));
                Database.receivedList = new Vector<>();
                Folder emailFolder = Connection.storeIMAP.getFolder("[Gmail]/Important");
                emailFolder.open(Folder.READ_ONLY);
                Message[] mgs = emailFolder.getMessages();
                Collections.reverse(Arrays.asList(mgs));
                for (int i = 0; i < min(mgs.length, maxNumberEmails); i++) {
                    Message m = mgs[i];
                    getData(m, i);
                }
                emailFolder.close(false);
                getServletContext().getRequestDispatcher("/Inbox.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    private void getData(Message m, int i) throws Exception {
        String user = "";
        String subject = "";
        Timestamp date = null;
        if (m.getFrom() != null)
            user = m.getFrom()[0].toString();
        if (m.getSentDate() != null)
            date = new Timestamp(m.getSentDate().getTime());
        if (m.getSubject() != null)
            subject = m.getSubject();
        Database.receivedList.add(new InfoType(i + 1, date, user, subject, ""));
    }

}