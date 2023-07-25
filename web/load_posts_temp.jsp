<%@page import="com.tech.blog.entities.User" %>
<%@page import="com.tech.blog.dao.PostDao" %>
<%@page import="com.tech.blog.dao.LikeDao" %>
<%@page import="com.tech.blog.helper.ConnectionProvider" %>
<%@page import="java.util.ArrayList" %>
<%@page import="com.tech.blog.entities.Post" %>

<div class="row">

    <%
        PostDao d = new PostDao(ConnectionProvider.getConnection());
        ArrayList<Post> posts = null;

        // Get cid from ajax present on profile.jsp
        int cid = Integer.parseInt(request.getParameter("cid"));

        if(cid == 0){
            posts = d.getAllPosts();
        }else{
            // return posts of particular category
            posts = d.getPostByCatId(cid);
        }

        if(posts.size() == 0){
            out.println("<h3 class='display-5'>No Posts in this category...</h3>");
            return;
        }

        for(Post p: posts)
        {
    %>
    <div class="col-md-4 mb-3">
        <div class="card">
            <img src="blog_pics/<%= p.getpPic()%>" class="card-img-top" style="width: 100%; height: 30vh; object-fit: cover;" alt="blog photo">
            <div class="card-body">
                <p class="fw-bold"><%= p.getpTitle() %></p>
                <!--<p class="text-truncate"><%= p.getpContent() %></p>-->
                <p style="
                   overflow: hidden;
                   text-overflow: ellipsis;
                   display: -webkit-box;
                   -webkit-line-clamp: 2;
                   -webkit-box-orient: vertical;
                   white-space: pre-line;"><%= p.getpContent() %></p>
            </div>
            <div class="card-footer border-0 pt-0" style="background: white;">
                <a href="show_blog_page_temp.jsp?post_id=<%= p.getPid() %>" class="btn btn-outline-primary btn-sm mx-1">Read More...</a>
            </div>
        </div>
    </div>

    <%
        }
    %>

</div>