<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="java.util.*" %>
<%@ page import="models.User" %>
<%@ page import="models.dao.SettingDAO" %>
<%@ page import="controllers.WebManager" %>
<%@ page import="models.SettingType" %>
<%@ page import="models.Setting" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Homepage</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/js/all.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
            background-image: url('../Images/background.jpg'); /* Path to your HD image */
            background-size: cover; /* Ensures the image covers the entire background */
            background-position: center center; /* Centers the image */
            background-attachment: fixed; /* Keeps the background fixed when scrolling */
            background-repeat: no-repeat; /* Prevents the image from repeating */
        }

        @media (min-width: 1200px) {
            body {
                background-image: url('../Images/background.jpg'); /* High-res image for large screens */
            }
        }

        header {
            background-color: white;
            box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
            padding: 10px 20px;
        }

        .nav-container {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .logo img {
            height: 40px;
        }

        .dropdown {
            position: relative;
            display: inline-block;
            margin: 0 10px;
        }

        .dropbtn {
            background-color: transparent;
            border: none;
            font-size: 16px;
            cursor: pointer;
            padding: 12px 20px;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            background-color: white;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            min-width: 200px;
            z-index: 1;
        }

        .dropdown:hover .dropdown-content {
            display: block;
        }

        .dropdown-content a {
            color: black;
            display: block;
            text-decoration: none;
            padding: 12px 16px;
        }

        .dropdown-content a:hover {
            background-color: #f8f9fa;
        }

        .search-box {
            display: flex;
            border: 2px solid #ccc;
            border-radius: 25px;
            overflow: hidden;
        }

        .search-box input {
            border: none;
            padding: 10px 15px;
            width: 250px;
            font-size: 14px;
            color: #333;
        }

        .search-box button {
            border: none;
            background-color: #007bff;
            color: white;
            padding: 10px 15px;
            cursor: pointer;
            font-size: 14px;
            border-radius: 5px;
        }
        .search-box button:hover {
            background-color: #0056b3;
        }

        .login-btn {
            background-color: #007bff;
            color: white;
            padding: 8px 16px;
            text-decoration: none;
            border-radius: 5px;
        }
        .user-dropdown {
            position: relative;
            display: inline-block;
        }

        .user-icon {
            display: flex;
            align-items: center;
            cursor: pointer;
            padding: 8px 12px;
            border-radius: 4px;
            transition: background-color 0.2s;
        }

        .user-icon:hover {
            background-color: #f8f9fa;
        }

        .user-icon i {
            font-size: 24px;
            margin-right: 8px;
            color: #666;
        }

        .user-dropdown-content {
            display: none;
            position: absolute;
            right: 0;
            background-color: white;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            min-width: 160px;
            z-index: 1000;
            border-radius: 4px;
            overflow: hidden;
        }

        .user-dropdown-content.show {
            display: block;
        }

        .user-dropdown-content a {
            color: #333;
            padding: 12px 16px;
            display: block;
            text-decoration: none;
            transition: background-color 0.2s;
        }

        .user-dropdown-content a:hover {
            background-color: #f8f9fa;
        }

        .user-dropdown-content a:last-child {
            color: #dc3545;
        }

        /* Card Styles */
        .card-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
            padding: 20px;
        }

        .card {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0px 6px 18px rgba(0, 0, 0, 0.15);
        }
        .card h3 {
            font-size: 20px;
            margin-bottom: 15px;
            font-weight: 600;
            color: #333;
        }

        .card p {
            font-size: 14px;
            color: #555;
            max-height: 40px; /* Set a maximum height */
            overflow: hidden; /* Hide any overflow */
            text-overflow: ellipsis; /* Display ellipsis (...) for overflowed text */
            line-height: 1.5;
        }


        .card a {
            font-size: 16px;
            color: #007bff;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }
        .card a:hover {
            color: #0056b3;
        }
        .section-title {
            font-size: 28px;
            font-weight: 700;
            margin: 30px 0;
            color: #333;
            text-align: center;
        }

        #searchResults {
            position: absolute;
            width: 300px;
            background: white;
            border: 1px solid #ccc;
            display: none;
            max-height: 200px;
            overflow-y: auto;
        }
        .result-item {
            padding: 8px;
            border-bottom: 1px solid #ddd;
            cursor: pointer;
        }
        .result-item:hover {
            background: #f1f1f1;
        }
    </style>
</head>
<body>

<header>
    <div class="nav-container">
        <!-- Logo -->
        <div class="logo">
            <a href="/home">
                <img src="../Images/logo.png" alt="Website Logo">
            </a>
        </div>
        <%
            SettingDAO settingDAO = WebManager.getInstance().getSettingDAO();
            List<Setting> categories = settingDAO.findAllByType(SettingType.Category);
        %>

        <!-- Dropdowns -->
        <div class="dropdown">
            <button class="dropbtn">Categories</button>
            <div class="dropdown-content">
                <% for (Setting category : categories) { %>
                <a href="#"><%= category.getTitle() %></a>
                <% } %>
            </div>
        </div>

        <!-- Search Bar -->
        <div class="search-container">
            <div class="search-box">
                <input type="text" id="searchInput" placeholder="Search for subjects..." oninput="debounceSearch()">
                <button type="submit"><i class="fas fa-search"></i></button>
            </div>
            <div id="searchResults"></div>
        </div>

        <%
            User user = (User) session.getAttribute("user"); // Retrieve user from session
        %>

        <!-- User Login/Profile Dropdown -->
        <div class="user-dropdown">
            <% if (user == null) { %>
            <a href="login" class="login-btn">Login</a>
            <% } else { %>
            <!-- Dropdown -->
            <div class="dropdown">
                <button class="dropbtn">
                    <i class="fas fa-user-circle"></i>
                    <span><%= user.getUsername() %></span>
                </button>
                <div class="dropdown-content">
                    <a href="profile"><i class="fas fa-user me-2"></i>Profile</a>

                    <% if(user.getRoleId() != 3){ %>
                    <a href="admin"><i class="fas fa-user me-2"></i>Web Settings</a>
                    <% } %>

                    <a href="#" onclick="logout()"><i class="fas fa-sign-out-alt me-2"></i>Logout</a>
                </div>
            </div>
            <% } %>
        </div>
    </div>

    <script>
        function logout() {
            // Make an AJAX request to logout the user
            fetch('/logout', {
                method: 'GET', // or POST if your servlet requires POST
                credentials: 'same-origin',  // To ensure the session cookie is sent with the request
            })
                .then(response => {
                    console.log(response);

                    // Redirect to the login page after successful logout
                    if (response.ok) {
                        window.location.href = 'login'; // Redirect to the login page (or homepage)
                    } else {
                        alert('Error logging out. Please try again.');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Error logging out. Please try again.');
                });
        }


        let debounceTimer;

        function debounceSearch() {
            clearTimeout(debounceTimer);
            debounceTimer = setTimeout(searchSubjects, 300); // Wait 300ms after typing stops
        }

        function searchSubjects() {

            let query = $("#searchInput").val();
            if (query.length < 2) {
                $("#searchResults").hide();
                return;
            }

            console.log($("#searchInput").val());

            $.ajax({
                url: "/searchSubjects",
                type: "GET",
                data: { query: query },
                dataType: "json",
                success: function (data) {
                    let html = "";
                    data.forEach(subject => {
                        html += `<div class="result-item" onclick="selectSubject('${subject.subjectName}')">
                                    <strong>${subject.subjectName}</strong> - ${subject.code}
                                </div>`;
                    });
                    $("#searchResults").html(html).show();
                },
                error: function () {
                    $("#searchResults").hide();
                }
            });
        }

        function selectSubject(name) {
            $("#searchInput").val(name);
            $("#searchResults").hide();
        }

        $(document).on("click", function(event) {
            if (!$(event.target).closest("#searchInput, #searchResults").length) {
                $("#searchResults").hide();
            }
        });
    </script>
</header>

<!-- Random Courses Section -->
<div class="section-title">My Classes</div>
<div class="card-container" id="course-container">
    <!-- Cards will be loaded here dynamically -->
</div>

<script>
    $(document).ready(function () {
        $.ajax({
            url: 'getSubjects',  // Call HomeServlet
            method: 'GET',
            dataType: 'json',
            success: function (data) {
                console.log(data);

                let container = $('#course-container');
                container.empty(); // Clear existing content

                $.each(data, function (index, subject) {
                    let card = `
                            <div class="card">
                                <h3>${subject.subjectName}</h3>
                                <h5>Code: ${subject.code}</h5>
                                <p>${subject.description}</p>
                                <a href="#">Learn More</a>
                            </div>
                        `;
                    container.append(card);
                });
            },
            error: function () {
                alert('Failed to load courses.');
            }
        });
    });
</script>

</body>
</html>
