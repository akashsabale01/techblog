<%@page import="com.tech.blog.entities.User" %>
<%@page import="com.tech.blog.entities.Message" %>
<%@page import="com.tech.blog.entities.Category" %>
<%@page import="com.tech.blog.dao.PostDao" %>
<%@page import="com.tech.blog.dao.UserDao" %>
<%@page import="com.tech.blog.dao.LikeDao" %>
<%@page import="com.tech.blog.entities.Post" %>
<%@page import="com.tech.blog.helper.ConnectionProvider" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.text.DateFormat" %>
<%@page errorPage="error_page.jsp"%>


<%
    // get post id from current page url
    int postId = Integer.parseInt(request.getParameter("post_id"));

    PostDao d = new PostDao(ConnectionProvider.getConnection());
    Post p = d.getPostByPostId(postId);

%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>TechBlog | <%= p.getpTitle()%></title>

        <!--CSS-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="css/mystyles.css" rel="stylesheet" type="text/css"/>

        <style>
            .banner-background{
                clip-path: polygon(50% 0%, 80% 0, 100% 0, 100% 93%, 73% 100%, 49% 95%, 24% 100%, 0 94%, 0 0, 20% 0);
            }
            .post-title{
                /*font-weight: 400;*/
                font-size: 35px;
            }

            .post-content{
                font-size: 20px;
            }

            .post-date{
                /*font-style: italic;*/
            }

            .post-user-info{
                font-size: 20px;
            }

        </style>
    </head>
    <body>

        <!--Navbar-->
        <%@include file="normal_navbar.jsp" %>

        <%
            Message m = (Message)session.getAttribute("msg");
            if(m != null)
            {
        %>
        <div class="alert <%= m.getCssClass()%> alert-dismissible fade show rounded-0" role="alert">
            <%= m.getContent()%>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <%
            session.removeAttribute("msg");
            }
        %>

        <!--Main Body-->

        <div class="container">
            <div class="row my-4">
                <div class="col-md-10 mx-auto">
                    <div class="card shadow-sm">
                        <div class="card-header border-0 p-0" style="background: white;">
                            <img src="blog_pics/<%= p.getpPic()%>" class="card-img-top mb-4" style="width: 100%; height: 60vh; object-fit: cover;" alt="blog photo">

                            <h4 class="post-title text-center fw-bold mb-3"><%= p.getpTitle() %></h4>

                            <div class="row text-center">
                                <%
                                    UserDao ud = new UserDao(ConnectionProvider.getConnection());
                                    User postOfwhichuser = ud.getUserByUserId(p.getUserId());
                                %>
                                <div class="d-flex flex-col justify-content-center align-items-center">
                                    <img class="img-thumbnail rounded-circle me-2" src="pics/<%= postOfwhichuser.getProfile()%>"
                                         style="width: 55px; height: 55px; object-fit: cover; margin-left: -22px; background: linear-gradient(90deg, #00C9FF 0%, #92FE9D 100%);"
                                         alt="profile photo"/>
                                    <div class="post-user-info fw-medium me-2 mb-0">
                                        <a class="text-primary" style="text-decoration: none">
                                            <%= postOfwhichuser.getName() %>
                                        </a>
                                        <p class="post-date mb-0 text-start" style="font-size: 14px; font-weight: bold; text-align: start;">
                                            <%= DateFormat.getDateInstance().format(p.getpDate())%>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card-body">
                            <p class="post-content"><%= p.getpContent() %></p>
                            <br/>
                            <div class="post-code text-bg-light p-3 rounded">
                                <pre ><%= p.getpCode()%></pre>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!--Footer-->
        <%@include file="normal_footer.jsp" %>


        <!--JS-->
        <script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js" integrity="sha512-AA1Bzp5Q0K1KanKKmvN/4d3IRKVlv9PYgwFPvm32nPO6QS8yH1HO7LbgB1pgiOxPtfeg5zEn2ba64MUcqJx6CA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="js/myjs.js" type="text/javascript"></script>

        <!--Loading Posts using ajax-->
        <script>
            function getPosts(catId, activeEleRef) {
                $("#loader").show();
                $("#post-container").hide();

                //                $(".c-link").removeClass("active");
                $(".c-link").removeClass('primary-background text-light');

                $.ajax({
                    url: "load_posts.jsp",
                    data: {cid: catId},
                    success: function (data, textStatus, jqXHR) {
                        $("#loader").hide();
                        $("#post-container").html(data);
                        $("#loader").hide();
                        $("#post-container").show();
                        //                        $(activeEleRef).addClass('active');
                        $(activeEleRef).addClass('primary-background text-light');
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log(textStatus);
                    }
                });
            }
            $(document).ready(function () {
                let allPostRef = $(".c-link")[0];
                getPosts(0, allPostRef);
            });
        </script>
    </body>
</html>
