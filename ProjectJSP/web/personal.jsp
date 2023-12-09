<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>



    
<%  String username = request.getParameter("username");
    String message = "";

    // Establish database connection
    String jdbcURL = "jdbc:mysql://localhost:3306/user";
    String dbUsername = "user1";
    String dbPassword = "12345678";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection(jdbcURL, dbUsername, dbPassword);

        // Check if the username exists in the login table
        String loginQuery = "SELECT * FROM login WHERE username = ?";
        PreparedStatement loginStmt = conn.prepareStatement(loginQuery);
        loginStmt.setString(1, username);
        ResultSet loginResult = loginStmt.executeQuery();

        if (loginResult.next()) {
            // Username exists, retrieve personal information using a join operation
            String personalQuery = "SELECT * FROM personal INNER JOIN login ON personal.username = login.username WHERE personal.username = ?";
            PreparedStatement personalStmt = conn.prepareStatement(personalQuery);
            personalStmt.setString(1, username);
            ResultSet personalResult = personalStmt.executeQuery();

            if (personalResult.next()) {
                // Retrieve the personal information from the result set
                String fullname = personalResult.getString("fullname");
                String gender = personalResult.getString("gender");
                String studid = personalResult.getString("studid");
                String hkid = personalResult.getString("hkid");
                String email = personalResult.getString("email");
                String address = personalResult.getString("address");
                String birthdate = personalResult.getString("birthdate");
                String subject = personalResult.getString("subject");
                String phone = personalResult.getString("phone");

                // Set the retrieved values as attributes to be accessed in HTML
                request.setAttribute("fullname", fullname);
                request.setAttribute("gender", gender);
                request.setAttribute("studid", studid);
                request.setAttribute("hkid", hkid);
                request.setAttribute("email", email);
                request.setAttribute("address", address);
                request.setAttribute("birthdate", birthdate);
                request.setAttribute("subject", subject);
                request.setAttribute("phone", phone);
            } else {
                message = "No personal information found for the given username";
            }

            personalResult.close();
            personalStmt.close();
        } else {
            message = "Invalid login credentials";
        }

        loginResult.close();
        loginStmt.close();
        conn.close();
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Personal Information</title>
    <style>
        body {
            background-image: url('blue-color-background.jpg');
            font-family: sans-serif;
        }

        label {
            display: block;
            margin-top: 10px;
        }

        input[type="text"],
        input[type="email"],
        input[type="tel"],
        select {
            width: 80%;
            padding: 10px;
            margin-top: 5px;
        }

        input[type="reset"] {
            width: 80%;
            padding: 10px;
            margin-top: 10px;
            background-color: #BC544B;
            color: white;
            border: none;
        }

        input[type="submit"] {
            width: 80%;
            padding: 10px;
            margin-top: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
        }

    </style>
    <script>
        function enableEdit(inputId) {
            var input = document.getElementById(inputId);
            input.disabled = false;
              input.value = "";
        }
    </script>
</head>
<body>
    <h1>Personal Information</h1>
    <% if (!message.isEmpty()) { %>
        <p><%= message %></p>
    <% } else { %>
        <!-- Display the retrieved personal information -->
        <form method="POST" action="update_personal.jsp">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" value="<%= username %>" disabled>

            <label for="fullname">Full Name:</label>
            <input type="text" id="fullname" name="fullname" value="<%= request.getAttribute("fullname") %>" disabled>
            <input type="button" value="Modify" onclick="enableEdit('fullname')">

            <label for="gender">Gender:</label>
            <input type="text" id="gender" name="gender" value="<%= request.getAttribute("gender") %>" disabled>
            <input type="button"value="Modify" onclick="enableEdit('gender')">

            <label for="studentid">Student ID:</label>
            <input type="text" id="studid" name="studid" value="<%= request.getAttribute("studid") %>" disabled>
            <input type="button" value="Modify" onclick="enableEdit('studid')">

            <label for="hkid">HKID:</label>
            <input type="text" id="hkid" name="hkid" value="<%= request.getAttribute("hkid") %>" disabled>
            <input type="button" value="Modify" onclick="enableEdit('hkid')">

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" value="<%= request.getAttribute("email") %>" disabled>
            <input type="button" value="Modify" onclick="enableEdit('email')">

            <label for="address">Address:</label>
            <input type="text" id="address" name="address" value="<%= request.getAttribute("address") %>" disabled>
            <input type="button" value="Modify" onclick="enableEdit('address')">

            <label for="birthdate">Birth Date:</label>
            <input type="text" id="birthdate" name="birthdate" value="<%= request.getAttribute("birthdate") %>" disabled>
            <input type="button" value="Modify" onclick="enableEdit('birthdate')">

            <label for="subject">Subject/Programme:</label>
            <input type="text" id="subject" name="subject" value="<%= request.getAttribute("subject") %>" disabled>
            <input type="button" value="Modify" onclick="enableEdit('subject')">

            <label for="phone">Phone Number:</label>
            <input type="tel" id="phone" name="phone" value="<%= request.getAttribute("phone") %>" disabled>
            <input type="button" value="Modify" onclick="enableEdit('phone')">

            <input type="submit" value="Update">
        </form>
    <% } %>
</body>
</html>