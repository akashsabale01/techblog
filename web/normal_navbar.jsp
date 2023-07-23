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
                <li class="nav-item">
                    <a class="nav-link" href="login_page.jsp"> <span class="fa fa-user-circle"> </span>  Login</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="register_page.jsp"> <span class="fa fa-user-plus"> </span>  Sign Up</a>
                </li>
            </ul>
            <form class="d-flex" role="search">
                <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                <button class="btn btn-outline-light" type="submit">Search</button>
            </form>
        </div>
    </div>
</nav>