<%@page import="com.tech.blog.entities.User" %>
<%@page import="com.tech.blog.entities.Message" %>
<%@page errorPage="error_page.jsp" %>

<%
    // Check whether user is logged in
    User user= (User)session.getAttribute("currentUser");

    if(user == null){
        // user not logged in, redirect user to login page
        response.sendRedirect("login_page.jsp");
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Techblog | Profile</title>

        <!--CSS-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="css/mystyles.css" rel="stylesheet" type="text/css"/>

        <style>
            .banner-background{
                clip-path: polygon(50% 0%, 80% 0, 100% 0, 100% 93%, 73% 100%, 49% 95%, 24% 100%, 0 94%, 0 0, 20% 0);
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark primary-background">
            <div class="container-fluid">
                <a class="navbar-brand" href="index.jsp"> <span class="fa fa-asterisk" ></span>  TechBlog</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page" href="index.jsp"> <span class="fa fa-home" ></span> Home</a>
                        </li>

                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <span class="fa fa-check-square"></span> Categories
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="#">Programming</a></li>
                                <li><a class="dropdown-item" href="#">Project Implementation</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="#">Data structures</a></li>
                            </ul>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#"> <span class="fa fa-address-card"></span>  Contact</a>
                        </li>
                    </ul>

                    <ul class="navbar-nav mr-right">
                        <li class="nav-item">
                            <a class="nav-link" type="button" data-bs-toggle="modal" data-bs-target="#profile-modal"> <span class="fa fa-user-circle"> </span>  <%= user.getName()%></a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link"  href="LogoutServlet">Logout <span class="fa fa-sign-out"> </span></a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>


        <%
        Message m = (Message)session.getAttribute("msg");
        if(m != null){
        %>
        <div class="alert <%= m.getCssClass()%> alert-dismissible fade show rounded-0" role="alert">
            <%= m.getContent()%>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <%
            session.removeAttribute("msg");
            }
        %>

        <div class="container text-center mt-4">
            <h1 class="display-3">This is Profile Page</h1>
        </div>


        <!--Profile Modal-->

        <!-- Modal -->
        <div class="modal fade" id="profile-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header primary-background text-white">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">Profile</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="container text-center">
                            <img class="img-fluid rounded-circle w-25" src="pics/<%= user.getProfile()%>" alt="<%= user.getName()%> profile photo"/>

                            <h1 class="modal-title fs-5" id="exampleModalLabel"><%= user.getName()%></h1>
                            <!--Details-->
                            <div id="profile-details" class="table-responsive container-sm ">
                                <table class="table text-start mt-2 table-sm align-middle">
                                    <tbody>
                                        <tr>
                                            <th scope="row">ID: </th>
                                            <td><%= user.getId()%></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Email: </th>
                                            <td><%= user.getEmail()%></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Gender: </th>
                                            <td><%= user.getGender().toUpperCase()%></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">About: </th>
                                            <td><%= user.getAbout()%></td>
                                        </tr>
                                        <tr >
                                            <th class="border-bottom-0" scope="row">Register on: </th>
                                            <td class="border-bottom-0"><%= user.getDateTime().toString()%></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>

                            <!--Profile Edit-->
                            <div id="profile-edit" style="display:none">
                                <h4 class="mt-1 mb-2">Please Edit Carefully</h4>
                                <!--enctype="multipart/form-data" means form contains image-->
                                <form action="EditServlet" method="post" enctype="multipart/form-data">
                                    <table class="table text-start table-sm align-middle table-borderless">
                                        <tr>
                                            <td scope="row">ID: </td>
                                            <td><%= user.getId()%></td>
                                        </tr>
                                        <tr>
                                            <td scope="row">Email: </td>
                                            <td><input class="form-control form-control-sm" type="email" name="user_email" value="<%= user.getEmail()%>" /></td>
                                        </tr>
                                        <tr>
                                            <td scope="row">Name: </td>
                                            <td><input class="form-control form-control-sm" type="text" name="user_name" value="<%= user.getName()%>" /></td>
                                        </tr>
                                        <tr>
                                            <td scope="row">Password: </td>
                                            <td><input class="form-control form-control-sm" type="password" name="user_password" value="<%= user.getPassword()%>" /></td>
                                        </tr>
                                        <tr>
                                            <td scope="row">Gender: </td>
                                            <td><%= user.getGender().toUpperCase()%></td>
                                        </tr>
                                        <tr>
                                            <td scope="row">About: </td>
                                            <td>
                                                <textarea rows="2" class="form-control form-control-sm" name="user_about"><%= user.getAbout()%></textarea>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="border-bottom-0" scope="row">New Profile: </td>
                                            <td class="border-bottom-0">
                                                <input type="file" name="image" class="form-control form-control-sm"/>
                                            </td>
                                        </tr>
                                    </table>
                                    <div class="container text-center">
                                        <button type="submit" class="btn btn-outline-primary">Save</button>
                                    </div>
                                </form>
                            </div>

                        </div>
                    </div>
                    <div class="modal-footer">
                        <!--<button id="edit-profile-btn" type="button" class="btn primary-background text-white"><span id="edit-btn-icon" class="fa fa-edit"></span> Edit</button>-->
                        <button id="edit-profile-btn" type="button" class="btn primary-background text-white">Edit</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>


        <!--JS-->
        <script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
        <script src="js/myjs.js" type="text/javascript"></script>

        <script>
            $(document).ready(function () {
                let isInEditMode = false;

                $("#edit-profile-btn").click(function () {

                    // Toggle Logic

                    if (isInEditMode == false) {
                        $("#profile-details").hide();
                        $("#profile-edit").show();
                        isInEditMode = true;
                        $(this).text("Back");
//                        $(this).find('span').addClass("fa-reply");
//                        $(this).find('span').toggleClass('fa-edit fa-reply');
//                        $("#edit-btn-icon").removeClass("fa-edit").addClass("fa-reply");
                    } else {
                        // not in edit mode
                        $("#profile-details").show();
                        $("#profile-edit").hide();
                        isInEditMode = false;
                        $(this).text("Edit");
//                        $(this).find('span').toggleClass('fa-reply fa-edit ');
//                        $(this).find('span').addClass("fa-edit");

                    }

                });
            });

        </script>
    </body>
</html>
