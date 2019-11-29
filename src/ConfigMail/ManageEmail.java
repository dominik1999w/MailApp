package ConfigMail;

import ConfigAttributes.HistoryController;
import ConfigServer.Connection;
import ConfigServer.Login;

import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/ManageEmail")
public class ManageEmail extends HttpServlet {
    public static boolean EmailSent = false;

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String receiver = request.getParameter("receiver");
        String content = request.getParameter("content");
        String subject = request.getParameter("subject");

        new HistoryController().uploadMail(Login.username, receiver, subject, content);
        try {
            Connection.SendEmail(receiver, subject, content);
            EmailSent = true;
        } catch (MessagingException e) {
            System.out.println(e.getMessage());
        }

        getServletContext().getRequestDispatcher("/HomePage.jsp").forward(request, response);

    }
}
