package ConfigServer;

import Database.Database;

import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/Login")
public class Login extends HttpServlet {
    public static boolean valid = true;
    public static String username = "";

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        username = request.getParameter("email");
        String password = request.getParameter("pwd");
        valid = true;
        try {
            new Connection(username, password);
        } catch (MessagingException authentication) {
            valid = false;
        }

        Database.database = new Database();
        Database.database.getFriendEmails(username);

        if (valid) {
            getServletContext().getRequestDispatcher("/HomePage.jsp").forward(request, response);
        } else {
            getServletContext().getRequestDispatcher("/LoginForm.jsp").forward(request, response);
        }
    }
}
