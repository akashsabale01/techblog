package com.tech.blog.dao;

import com.tech.blog.entities.Category;
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

}
