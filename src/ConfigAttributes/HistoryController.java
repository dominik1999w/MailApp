package ConfigAttributes;

import ConfigServer.Login;
import Database.Database;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;

@WebServlet("/HistoryController")
public class HistoryController extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Database.database.getHistory(Login.username);
        getServletContext().getRequestDispatcher("/History.jsp").forward(request, response);
    }

    public void uploadMail(String username, String receiver, String subject, String message) {
        String date = new SimpleDateFormat("MMM-dd-YYYY h:m:s a").format(Calendar.getInstance().getTime());
        Database.database.insertHistory(username, date, receiver, subject, message);
    }


}
