<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>TechBlog | Register Page</title>

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

        <!--Navbar-->
        <%@include file="normal_navbar.jsp" %>

        <main class="primary-background pt-4 mb-4 banner-background" style="padding-bottom: 80px">
            <div class="container">
                <div class="col-md-4 offset-md-4">
                    <div class="card">
                        <div class="card-header text-center primary-background text-white">
                            <span class="fa fa-user-plus fa-2x"></span>
                            <br/>
                            Register
                        </div>
                        <div class="card-body">
                            <form id="register-form" action="RegisterServlet" method="post">
                                <div class="mb-3">
                                    <label for="user_name" class="form-label">User Name</label>
                                    <input name="user_name" type="text" class="form-control" id="user_name">
                                </div>

                                <div class="mb-3">
                                    <label for="user_email" class="form-label">Email address</label>
                                    <input name="user_email" type="email" class="form-control" id="user_email">
                                </div>

                                <div class="mb-3">
                                    <label for="user_password" class="form-label">Password</label>
                                    <input name="user_password" type="password" class="form-control" id="user_password">
                                </div>

                                <div class="mb-3">
                                    <label for="gender" class="me-3" >Select Gender</label>
                                    <input type="radio" name="gender" value="male"> Male
                                    <input type="radio" class="ms-2" name="gender" value="female"> Female
                                </div>

                                <div class="mb-3">
                                    <label for="about" class="me-3" >About</label>
                                    <textarea name="about" class="form-control" id="about" rows="5" placeholder="Enter something about yourself..." ></textarea>
                                </div>

                                <div class="mb-3 form-check">
                                    <input name="check" type="checkbox" class="form-check-input" id="exampleCheck1">
                                    <label class="form-check-label" for="exampleCheck1">Agree terms and conditions</label>
                                </div>
                                <div id="loader" class="container text-center" style="display:none">
                                    <span class="fa fa-refresh fa-spin fa-3x"></span>
                                    <h4>Please wait...</h4>
                                </div>
                                <button id="submit-btn" type="submit" class="btn primary-background text-white">Register</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <!--JS-->
        <script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js" integrity="sha512-AA1Bzp5Q0K1KanKKmvN/4d3IRKVlv9PYgwFPvm32nPO6QS8yH1HO7LbgB1pgiOxPtfeg5zEn2ba64MUcqJx6CA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="js/myjs.js" type="text/javascript"></script>

        <script>
            $(document).ready(function () {
                console.log("loaded...")

                $('#register-form').on('submit', function (event) {
                    event.preventDefault();

                    let form = new FormData(this);

                    $('#submit-btn').hide();
                    $('#loader').show();

                    // Send form data to RegisterServlet
                    $.ajax({
                        url: "RegisterServlet",
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            console.log(data);
                            $('#submit-btn').show();
                            $('#loader').hide();

                            if (data.trim() === "Saved Data in DB Successfully") {
                                swal("Registered Successfully... We are going redirect to Login page")
                                        .then((value) => {
                                            window.location = "login_page.jsp";
                                        });
                            } else {
                                swal(data);
                            }

                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.log(jqXHR);
                            $('#submit-btn').show();
                            $('#loader').hide();

                            swal("Something went wrong... Try again");
                        },
                        processData: false,
                        contentType: false
                    });
                });
            });

        </script>

    </body>
</html>
