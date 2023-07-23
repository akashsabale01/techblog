package com.tech.blog.dao;

import com.tech.blog.entities.Category;
import com.tech.blog.entities.Post;
import java.sql.*;
import java.util.ArrayList;

public class PostDao {

    Connection con;

    public PostDao(Connection con) {
        this.con = con;
    }

    public ArrayList<Category> getAllCategories() {

        ArrayList<Category> listOfAllCategories = new ArrayList<>();

        try {
            String query = "SELECT * FROM categories";

            Statement st = this.con.createStatement();

            ResultSet allCategoriesSet = st.executeQuery(query);

            while (allCategoriesSet.next()) {
                int cid = allCategoriesSet.getInt("cid");
                String categoryName = allCategoriesSet.getString("name");
                String categoryDescription = allCategoriesSet.getString("description");

                Category singleCategory = new Category(cid, categoryName, categoryDescription);
                listOfAllCategories.add(singleCategory);

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return listOfAllCategories;
    }

    public boolean savePost(Post p) {
        boolean isPostSaved = false;

        try {
            String query = "INSERT INTO posts(pTitle, pContent, pCode, pPic, catId, userId) VALUES(?,?,?,?,?,?)";

            PreparedStatement pstm = con.prepareStatement(query);
            pstm.setString(1, p.getpTitle());
            pstm.setString(2, p.getpContent());
            pstm.setString(3, p.getpCode());
            pstm.setString(4, p.getpPic());
            pstm.setInt(5, p.getCatId());
            pstm.setInt(6, p.getUserId());

            pstm.executeUpdate();
            isPostSaved = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return isPostSaved;
    }

}
