<%@page import="com.tech.blog.entities.User" %>
<%@page import="com.tech.blog.entities.Message" %>
<%@page import="com.tech.blog.entities.Category" %>
<%@page import="com.tech.blog.dao.PostDao" %>
<%@page import="com.tech.blog.helper.ConnectionProvider" %>
<%@page import="java.util.ArrayList" %>
<%@page errorPage="error_page.jsp" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>TechBlog | Home</title>

        <!--CSS-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <!--        <link rel="preconnect" href="https://fonts.googleapis.com">
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                <link href="https://fonts.googleapis.com/css2?family=Lato:wght@300;400;700;900&family=Playfair+Display:ital,wght@0,400;0,500;0,600;0,700;0,800;1,400;1,500;1,600;1,700;1,800&display=swap" rel="stylesheet">-->

        <style>
            .banner-background{
                clip-path: polygon(50% 0%, 80% 0, 100% 0, 100% 93%, 73% 100%, 49% 95%, 24% 100%, 0 94%, 0 0, 20% 0);
            }
            /*            body{
                            font-family: 'Lato', sans-serif;
                        }
                        .heading{
                            font-family: 'Playfair Display', serif;
                        }*/
        </style>

        <link href="css/mystyles.css" rel="stylesheet" type="text/css"/>

    </head>
    <body>

        <!--Navbar-->
        <%@include file="normal_navbar.jsp" %>

        <!--Banner-->

        <div class="container-fluid p-0 m-0">
            <div class="primary-background banner-background text-white p-5" >
                <div class="container">
                    <h3 class="display-4 fw-bold heading fst-italic" >Welcome to TechBlog</h3>
                    <p>
                        TechBlog is tech blogging website, where our hero page provides a captivating platform for you to explore the dynamic world of technology. With cutting-edge content ranging from articles and tutorials to thought-provoking opinion pieces, our expert contributors bring you the latest news, insights, and trends in the ever-evolving tech landscape.
                    </p>
                    <p>
                        Whether you're seeking guidance on the latest gadgets, exploring career paths in tech, or seeking inspiration for your next innovative project, our hero page is your gateway to connect, learn, and grow.
                    </p>

                    <a href="register_page.jsp" type="button" class="btn btn-outline-light me-2"> <span class="fa fa-external-link-square"> </span> Start! Its FREE</a>
                    <a href="login_page.jsp" type="button" class="btn btn-outline-light"> <span class="fa fa-user-circle fa-spin"> </span> Login</a>
                </div>
            </div>
        </div>

        <!--Cards-->
        <div class="container mt-4">
            <div class="row">
                <div class="col-md-12">
                    <h3 class="display-4 fw-medium mb-5 text-center heading" style="text-decoration: underline; text-decoration-color: #2196f3;" >All Posts</h3>

                    <!--Loader-->
                    <div class="container text-center" id="loader">
                        <i class="fa fa-refresh fa-spin fa-4x"></i>
                        <h3 class="mt-3">Loading Posts...</h3>
                    </div>

                    <!--Post-->
                    <div class="container-fluid" id="post-container"></div>
                </div>
            </div>
        </div>

        <!--Footer-->
        <%@include file="normal_footer.jsp" %>

        <!--JS-->
        <script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
        <script src="js/myjs.js" type="text/javascript"></script>

        <!--Loading Posts using ajax-->
        <script>
            function getPosts(catId) {
                $("#loader").show();
                $("#post-container").hide();

                $.ajax({
                    url: "load_posts.jsp",
                    data: {cid: catId},
                    success: function (data, textStatus, jqXHR) {
//                        console.log(data);
                        $("#loader").hide();
                        $("#post-container").html(data);
                        $("#loader").hide();
                        $("#post-container").show();
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log(textStatus);
                    }
                });
            }
            $(document).ready(function () {
                getPosts(0);
            });
        </script>

    </body>
</html>
