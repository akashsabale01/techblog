package com.tech.blog.dao;

import com.tech.blog.entities.User;
import java.sql.*;

public class UserDao {

    private Connection con;

    public UserDao(Connection con) {
        this.con = con;
    }

    // Method to insert user to database
    public boolean saveUser(User user) {
        boolean isQueryExecutedSuccessfully = false;

        try {

            // get user from client & save to DB
            String query = "INSERT INTO user(name, email, password, gender, about) VALUES(?,?,?,?,?)";

            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getGender());
            pstmt.setString(5, user.getAbout());

            pstmt.executeUpdate();
            isQueryExecutedSuccessfully = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return isQueryExecutedSuccessfully;
    }

    // Get user by username and password
    public User getUserByEmailAndPassword(String email, String password) {

        User user = null;

        try {

            String query = "SELECT * FROM user WHERE email=? AND password=?";

            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setString(1, email);
            pstmt.setString(2, password);

            ResultSet resultSetOfQuery = pstmt.executeQuery();

            if (resultSetOfQuery.next()) {
                user = new User();

                // get data from DB
                String name = resultSetOfQuery.getString("name");

                // set to user object
                user.setName(name);

                user.setId(Integer.parseInt(resultSetOfQuery.getString("id")));
                user.setEmail(resultSetOfQuery.getString("email"));
                user.setPassword(resultSetOfQuery.getString("password"));
                user.setGender(resultSetOfQuery.getString("gender"));
                user.setAbout(resultSetOfQuery.getString("about"));
                user.setDateTime(resultSetOfQuery.getTimestamp("regdate"));
                user.setProfile(resultSetOfQuery.getString("profile"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public boolean updateUser(User user) {
        boolean isUserDataUpdated = false;
        try {

            String query = "UPDATE user SET name=?, email=?, password=?, about=?, profile=? WHERE id=?";

            PreparedStatement pstm = con.prepareStatement(query);
            pstm.setString(1, user.getName());
            pstm.setString(2, user.getEmail());
            pstm.setString(3, user.getPassword());
            pstm.setString(4, user.getAbout());
            pstm.setString(5, user.getProfile());
            pstm.setInt(6, user.getId());

            pstm.executeUpdate();
            isUserDataUpdated = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return isUserDataUpdated;
    }

    public User getUserByUserId(int userId) {
        User user = null;

        try {
            String query = "SELECT * FROM user WHERE id=?";

            PreparedStatement pstm = this.con.prepareStatement(query);
            pstm.setInt(1, userId);

            ResultSet resSet = pstm.executeQuery();

            if (resSet.next()) {
                user = new User();

                // get data from DB
                String name = resSet.getString("name");

                // set to user object
                user.setName(name);

                user.setId(Integer.parseInt(resSet.getString("id")));
                user.setEmail(resSet.getString("email"));
                user.setPassword(resSet.getString("password"));
                user.setGender(resSet.getString("gender"));
                user.setAbout(resSet.getString("about"));
                user.setDateTime(resSet.getTimestamp("regdate"));
                user.setProfile(resSet.getString("profile"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }
}
