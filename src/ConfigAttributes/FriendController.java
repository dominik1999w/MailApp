package ConfigAttributes;

import ConfigServer.Login;
import Database.Database;

import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/FriendController")
public class FriendController extends HttpServlet {
    public static boolean addFriend = false;
    public static boolean removeFriend = false;

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // open the add modal
        if (request.getParameter("addContact1") != null) {
            addFriend = true;
        }
        // perform action in add modal
        else if (request.getParameter("addContact2") != null) {
            String friendEmail = request.getParameter("friendEmail");
            String friendDescription = request.getParameter("friendDescription");
            if (isValidEmailAddress(friendEmail)) {
                Database.database.insertContact(Login.username, friendEmail, friendDescription);
                Database.database.getFriendEmails(Login.username);
            }
        }
        // open remove modal
        if (request.getParameter("removeContact1") != null) {
            removeFriend = true;
        }
        // perform action in remove modal
        else if (request.getParameter("removeContact2") != null) {
            String friendEmail = request.getParameter("friendChoiceBox");
            if (friendEmail != null) {
                Database.database.removeContact(Login.username, friendEmail);
                Database.database.getFriendEmails(Login.username);
            }
        }
        getServletContext().getRequestDispatcher("/HomePage.jsp").forward(request, response);
    }

    private static boolean isValidEmailAddress(String email) {
        boolean result = true;
        try {
            InternetAddress emailAddr = new InternetAddress(email);
            emailAddr.validate();
        } catch (AddressException ex) {
            result = false;
        }
        return result;
    }

}
