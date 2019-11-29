package Database;

import Types.FriendType;
import Types.InfoType;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import java.util.Vector;

public class Database {
    public static Database database;
    private String SERVER_ADDRESS;
    private String PORT;
    private String DATABASE_NAME;
    private String USER_NAME;
    private String PASSWORD;

    private java.sql.Connection connection;
    public static Vector<FriendType> friendList;
    public static Vector<InfoType> historyList;
    public static Vector<InfoType> receivedList;

    private void loadParameters() {
        Properties properties = new Properties();
        InputStream inputStream;

        try {
            File file = new File("/home/dominik/java/MailApp/src/Database/config.properties");
            inputStream = new FileInputStream(file);
            properties.load(inputStream);
        } catch (Exception e) {
            System.out.println("READING properties FAILED.");
        }

        SERVER_ADDRESS = properties.getProperty("SERVER_ADDRESS");
        PORT = properties.getProperty("PORT");
        DATABASE_NAME = properties.getProperty("DATABASE_NAME");
        USER_NAME = properties.getProperty("USER_NAME");
        PASSWORD = properties.getProperty("PASSWORD");
    }

    public Database() {
        loadParameters();
        try {
            connection = DriverManager
                    .getConnection("jdbc:postgresql://" + SERVER_ADDRESS + ':' + PORT + '/' + DATABASE_NAME, USER_NAME, PASSWORD);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void getFriendEmails(String username) {
        friendList = new Vector<>();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(
                    "SELECT * FROM contact where email_id = '" + username + "';"
            );
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Vector<String> tmp = new Vector<>();
                friendList.add(new FriendType(resultSet.getString("friend_email"),
                        resultSet.getString("description")));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public void getHistory(String username) {
        historyList = new Vector<>();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(
                    "SELECT * FROM history where email_id = '" + username + "' ORDER BY sent_date DESC;"
            );
            ResultSet resultSet = preparedStatement.executeQuery();
            int i = 0;
            while (resultSet.next()) {
                i++;
                historyList.add(new InfoType(i, resultSet.getTimestamp("sent_date"),
                        resultSet.getString("receiver"), resultSet.getString("subject"), resultSet.getString("message")));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public void insertContact(String username, String friendEmail, String description) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(
                    "INSERT INTO contact VALUES('" + username + "','" + friendEmail
                            + "','" + description + "');");
            preparedStatement.execute();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public void removeContact(String username, String friendEmail) {
        PreparedStatement preparedStatement = null;
        try {
            preparedStatement = connection.prepareStatement(
                    "DELETE FROM contact WHERE friend_email='" + friendEmail + "' " +
                            "AND email_id = '" + username + "';");
            preparedStatement.execute();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

    }

    public void insertHistory(String username, String date, String receiver, String subject, String message) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(
                    "INSERT INTO history VALUES('" + username + "','" + date
                            + "','" + receiver + "','" + subject + "','" + message + "');");
            preparedStatement.execute();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

}