<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.sql.*" %>

<%  
    String username = request.getParameter("username");
    String message = "";
     String message1 = "";
    // Establish database connection
    String jdbcURL = "jdbc:mysql://localhost:3306/user";
    String dbUsername = "user1";
    String dbPassword = "12345678";

    Connection conn = null;
    PreparedStatement loginStmt = null;
    ResultSet loginResult = null;
    PreparedStatement teacherStmt = null;
    ResultSet teacherResult = null;
    PreparedStatement studentStmt = null;
    ResultSet studentResult = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcURL, dbUsername, dbPassword);

        // Check if the username exists in the login table
        String loginQuery = "SELECT * FROM login WHERE username = ?";
        loginStmt = conn.prepareStatement(loginQuery);
        loginStmt.setString(1, username);
        loginResult = loginStmt.executeQuery();

        if (loginResult.next()) {
            // Username exists, retrieve teacher information
            String teacherQuery = "SELECT * FROM teacher WHERE username = ?";
            teacherStmt = conn.prepareStatement(teacherQuery);
            teacherStmt.setString(1, username);
            teacherResult = teacherStmt.executeQuery();

            if (teacherResult.next()) {
                // Teacher record found
                String teachername = teacherResult.getString("teachername");
                String teacherid = teacherResult.getString("teacherid");
                String program = teacherResult.getString("program");

                // Set the retrieved values as attributes to be accessed in HTML
                request.setAttribute("teachername", teachername);
                request.setAttribute("teacherid", teacherid);
                request.setAttribute("program", program);

                String studentQuery = "SELECT * FROM student WHERE program = ?";
                studentStmt = conn.prepareStatement(studentQuery);
                studentStmt.setString(1, program);
                studentResult = studentStmt.executeQuery();

                // Create a list to store the student information
                List<Map<String, String>> studentList = new ArrayList<>();

                while (studentResult.next()) {

                    // Student record found
                    String studusername = studentResult.getString("username");
                   
                    String studname = studentResult.getString("studname");
                    String studid = studentResult.getString("studid");
                    String studprogram = studentResult.getString("program");
                    String totcredit = studentResult.getString("totcredit");
                    String gpa = studentResult.getString("gpa");
                    String cgpa = studentResult.getString("cgpa");

                    // Create a map to store the student details
                    Map<String, String> studentMap = new HashMap<>();
                    studentMap.put("studusername", studusername );
                    studentMap.put("studname", studname);
                    studentMap.put("studid", studid);
                    studentMap.put("program", studprogram);
                    studentMap.put("totcredit", totcredit);
                    studentMap.put("gpa", gpa);
                    studentMap.put("cgpa", cgpa);

                    // Add the student map to the student list
                    studentList.add(studentMap);
                }

                // Set the retrieved values as attributes to be accessed in HTML
                request.setAttribute("studentList", studentList);
            } else {
                message = "No teacher record found for the given username";
            }
        } else {
            message = "Invalid login credentials";
        }
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        message = "An error occurred while processing the request.";
    } finally {
        // Close the result sets, prepared statements, and connection in the reverse order of their creation
        if (studentResult != null) {
            try {
                studentResult.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (studentStmt != null) {
            try {
                studentStmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (teacherResult != null) {
            try {
                teacherResult.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (teacherStmt != null) {
            try {
                teacherStmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (loginResult != null) {
            try {
                loginResult.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (loginStmt != null) {
            try {
                loginStmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>

<!DOCTYPE html>
<html>

<head>
   
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
    <% if (!message.isEmpty()) { %>
    <p><%= message %></p>
    <% } else { %>
    <h1>Student Academic Record</h1>
    <h3>Teacher Name: <%= request.getAttribute("teachername") %></h3>
    <h3>Teacher ID: <%= request.getAttribute("teacherid") %></h3>
    <table border="1">
        <tr>
            <th>Student Name</th>
            <th>Student ID</th>
            <th>Study program</th>
            <th>Total credit</th>
            <th>gpa</th>
            <th>cgpa</th>
            
        </tr>
        <tr>
            <% if (request.getAttribute("studentList") != null) {
                List<Map<String, String>> studentList = (List<Map<String, String>>) request.getAttribute("studentList");
                for (Map<String, String> student : studentList) {
                     String studusername = student.get("studusername");
                    String studname = student.get("studname");
                    String studid = student.get("studid");
                    String program = student.get("program");
                    String totcredit = student.get("totcredit");
                    String gpa =student.get("gpa");
                    String cgpa = student.get("cgpa");
                 
                    
            %>
            <tr>
               
                <td><%= studname %></td>
                <td><%= studid %></td>
                <td><%= program %></td>
                <td><%= totcredit %></td>
                <td><%= gpa %></td>
                <td><%= cgpa %></td>
                <td><button class="btn btn-primary"><a href="update_record.jsp?username=<%= studusername %>">Modify</a></button></td>
                <td> <button class="btn btn-danger">Calculate</button></td>
            </tr>
            
            <% } %>
            
            <% } %>
        </tr>
    </table>
    <% } %>
   
</body>
</html>
