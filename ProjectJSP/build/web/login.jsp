<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Login Page</title>
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
     <div class="box1">
        <form method="POST" action="login.jsp">
            <h1>Login Page</h1>
            <div class="box2">
                <div class="inputbox">
                    <input type="text" id="username" name="username" placeholder="Username" pattern="[A-Za-z][0-9]{7}">
                    
                    <i class='bx bxs-user-rectangle'></i>
                </div>
                <div class="inputbox">
                    <input type="password" id="password" name="password" placeholder="Password" pattern="[0-9]{8}">
                    <i class='bx bx-lock'></i>
                </div>
            </div>
            <div class="loginpage btn">
                <button type="submit" class="btn1">Login</button>
                <a href="#" style="color: aliceblue;" class="link1">
                    <p>Forgot password?</p>
                </a>
                <a href="signup.jsp" style="color: aliceblue;" class="link2">
                    <p>Sign up</p>
                </a>
            </div>
        </form>
    </div>
</body>
</html>

<%
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String username = request.getParameter("username");
        session.setAttribute("username", username);
        String password = request.getParameter("password");
        String message = "";

        // Establish database connection
        String jdbcURL = "jdbc:mysql://localhost:3306/user";
        String dbUsername = "user1";
        String dbPassword = "12345678";

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcURL, dbUsername, dbPassword);

            String query = "SELECT * FROM login WHERE username = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String fetchedPassword = rs.getString("password");
                if (fetchedPassword.equals(password)) {
                    // Check the starting character of the username
                    char firstChar = username.charAt(0);

                    if (firstChar == 'S') {
                        // Redirect to student_home.jsp
                        response.sendRedirect("student_home.jsp");
                    } else if (firstChar == 'T') {
                        // Redirect to teacher_home.jsp
                        response.sendRedirect("teacher_home.jsp");
                    } else if (firstChar == 'A') {
                        // Redirect to admin_home.jsp
                        response.sendRedirect("admin_home.jsp");
                    } else {
                        message = "Invalid username or password";
                    }
                } else {
                    message = "Invalid username or password";
                }
            } else {
                message = "Invalid username or password";
            }

            rs.close();
            stmt.close();
            conn.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

        out.println("<h2>" + message + "</h2>");
    }
%>