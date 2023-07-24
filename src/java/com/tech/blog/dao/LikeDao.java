package com.tech.blog.dao;

import java.sql.*;

public class LikeDao {

    Connection con;

    public LikeDao(Connection con) {
        this.con = con;
    }

    public boolean insertLike(int pid, int uid) {
        boolean isLiked = false;
        try {

            String query = "INSERT INTO liketable(pid,uid) VALUE(?,?)";

            PreparedStatement pstm = this.con.prepareStatement(query);
            pstm.setInt(1, pid);
            pstm.setInt(2, uid);

            pstm.executeUpdate();
            isLiked = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return isLiked;
    }

    public int getCountOfLikeOnPost(int pid) {
        int likeCount = 0;

        try {
            String query = "SELECT COUNT(lid) FROM liketable WHERE pid=?";

            PreparedStatement pstm = this.con.prepareStatement(query);
            pstm.setInt(1, pid);

            ResultSet resSet = pstm.executeQuery();

            if (resSet.next()) {
                likeCount = resSet.getInt("COUNT(lid)");
            }

        } catch (Exception e) {
        }

        return likeCount;
    }

    public boolean isLikedByUser(int pid, int uid) {
        boolean isLiked = false;

        try {

            String query = "SELECT * FROM liketable WHERE uid=? AND pid=?";

            PreparedStatement pstm = this.con.prepareStatement(query);
            pstm.setInt(1, uid);
            pstm.setInt(2, pid);

            ResultSet resSet = pstm.executeQuery();
            if (resSet.next()) {
                isLiked = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return isLiked;
    }

    public boolean deleteLike(int pid, int uid) {
        boolean isLikeDeleted = false;

        try {

            String query = "DELETE FROM liketable WHERE uid=? AND pid=?";

            PreparedStatement pstm = this.con.prepareStatement(query);
            pstm.setInt(1, uid);
            pstm.setInt(2, pid);

            pstm.executeUpdate();

            isLikeDeleted = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return isLikeDeleted;
    }

}
