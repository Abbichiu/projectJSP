<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String message = "";

    // Establish database connection
    String jdbcURL = "jdbc:mysql://localhost:3306/user";
    String dbUsername = "user1";
    String dbPassword = "12345678";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection(jdbcURL, dbUsername, dbPassword);

        String query = "INSERT INTO login (username, password) VALUES (?, ?)";
        PreparedStatement stmt = conn.prepareStatement(query);
   
        if (username == null ||username.trim().isEmpty()) {
            message += "Username is blank.<br>";
        }
        if (password == null || password.length() == 0) {
            message += "Password is blank.<br>";
        }

        if (message.length() == 0) {
            stmt.setString(1, username);
            stmt.setString(2, password);
            stmt.executeUpdate();

            message = "Username: " + username + " Sign up Successful.";
            response.sendRedirect("login.jsp");
            
        } else {
            message = "Insert Error<br>" + message;
        }

        stmt.close();
        conn.close();
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        message = "An error occurred. Please try again later.";
    }
%>

<%= message %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv=x -ua-compatible content=i e=edge>
    <meta name=" viewport" content="width-device-width,initial-scale = 1.0">
     <title>Sign up Page</title>
</head>
<style>
    @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300&display=swap');
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: "Poppins", sans-serif;
}

body {
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    background-color: aqua;
    background: url(login.jpg) no-repeat;
    background-size: cover;
}

.box1 {
    position: absolute;
    width: 420px;
    background: blue;
    color: white;
}

.box1 h1 {
    font-size: 36px;
    text-align: center;
}

.box1 .inputbox {
    position: relative;
    width: 100%;
    height: 50px;
    margin: 30px 0;
}

.inputbox input {
    width: 100%;
    height: 100%;
    background: transparent;
    border: none;
    outline: none;
    border: 2px solid rgba(255, 255, 255, .2);
    border-radius: 40px;
}

.inputbox input::placeholder {
    color: #fff;
}

.inputbox i {
    position: absolute;
    right: 20px;
    top: 50%;
    transform: translate(-50%);
    font-size: 20px;
}

.box1 .btn1 {
    width: 100%;
    height: 45px;
    background: #fff;
    border: none;
    outline: none;
    border-radius: 40px;
    box-shadow: 0 0 10pxrbga(0, 0, 0, 1);
    cursor: pointer;
    font-size: 16px;
    color: #333;
    font-weight: 600;
}

.box1 .link1 {
    font-size: 14.5px;
    text-align: center;
    margin-top: 20px;
    text-decoration: none;
}

.box1 .link2 {
    font-size: 14.5px;
    text-align: center;
    margin-bottom: 20px;
    text-decoration: none;
}

.link2 p:hover {
    text-decoration: underline;
}

.link1 p:hover {
    text-decoration: underline;
}

.btn2 {
    width: 25%;
    height: 45px;
    background: #fff;
    border: none;
    outline: none;
    border-radius: 40px;
    box-shadow: 0 0 10pxrbga(0, 0, 0, 1);
    cursor: pointer;
    font-size: 16px;
    color: #333;
    font-weight: 600;
}
    
</style>
<body>
    <div class="box1 ">
          <form method = "post" action = "signup.jsp">
            <h1>Sign Up Page</h1>
            <div class=" box2 ">
                <div class=" inputbox ">
                    <input type="text" id="username" name="username" placeholder="username" pattern="[A-Za-z][0-9]{7}">
                    <i class='bx bxs-user-rectangle'></i>
                </div>
                <div class=" inputbox ">
                    <input type="password" id=" password" name="password" placeholder="password" pattern="[0-9]{8}">
                    <i class='bx bx-lock'></i>
                </div>
            </div>
            <div class=" loginpage btn ">
                <button type=" submit " class=" btn1 ">Submit</button>

                <a href="login.jsp" style="color: aliceblue; " class="link1 ">
                    <p>Back</p>
                </a>


                <br>
                <button type=" reset " class=" btn2 ">
                    Reset
                </button>
            </div>
