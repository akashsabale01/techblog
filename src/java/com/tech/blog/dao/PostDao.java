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

    public ArrayList<Post> getAllPosts() {
        ArrayList<Post> allPosts = new ArrayList<>();

        try {

            String query = "SELECT * FROM posts ORDER BY pid DESC";

            PreparedStatement pstm = con.prepareStatement(query);

            ResultSet postsSet = pstm.executeQuery();

            while (postsSet.next()) {
                // get data from postsSet
                int pid = postsSet.getInt("pid");
                String pTitle = postsSet.getString("pTitle");
                String pContent = postsSet.getString("pContent");
                String pCode = postsSet.getString("pCode");
                String pPic = postsSet.getString("pPic");
                Timestamp pDate = postsSet.getTimestamp("pDate");
                int catId = postsSet.getInt("catId");
                int userId = postsSet.getInt("userId");

                Post pPost = new Post(pid, pTitle, pContent, pCode, pPic, pDate, catId, userId);

                allPosts.add(pPost);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return allPosts;
    }

    public ArrayList<Post> getPostByCatId(int catId) {
        ArrayList<Post> postOfSameCategory = new ArrayList<>();

        try {

            String query = "SELECT * FROM posts WHERE catId=?";

            PreparedStatement pstm = con.prepareStatement(query);
            pstm.setInt(1, catId);

            ResultSet postsSetOfSameCategory = pstm.executeQuery();

            while (postsSetOfSameCategory.next()) {
                // get data from postsSetOfSameCategory
                int pid = postsSetOfSameCategory.getInt("pid");
                String pTitle = postsSetOfSameCategory.getString("pTitle");
                String pContent = postsSetOfSameCategory.getString("pContent");
                String pCode = postsSetOfSameCategory.getString("pCode");
                String pPic = postsSetOfSameCategory.getString("pPic");
                Timestamp pDate = postsSetOfSameCategory.getTimestamp("pDate");
                int userId = postsSetOfSameCategory.getInt("userId");

                Post pPostOfSameCatId = new Post(pid, pTitle, pContent, pCode, pPic, pDate, catId, userId);

                postOfSameCategory.add(pPostOfSameCatId);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return postOfSameCategory;
    }

    public Post getPostByPostId(int postId) {
        Post postGivenByDb = null;

        try {
            String query = "SELECT * FROM posts WHERE pid=?";
            PreparedStatement pstm = this.con.prepareStatement(query);
            pstm.setInt(1, postId);
            ResultSet resSet = pstm.executeQuery();

            while (resSet.next()) {
                // get data
                int pid = resSet.getInt("pid");
                String pTitle = resSet.getString("pTitle");
                String pContent = resSet.getString("pContent");
                String pCode = resSet.getString("pCode");
                String pPic = resSet.getString("pPic");
                Timestamp pDate = resSet.getTimestamp("pDate");
                int catId = resSet.getInt("catId");
                int userId = resSet.getInt("userId");

                postGivenByDb = new Post(pid, pTitle, pContent, pCode, pPic, pDate, catId, userId);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return postGivenByDb;
    }
}
