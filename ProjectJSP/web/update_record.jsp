<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>

<%  
    String username = request.getParameter("username");
    String message = "" ;
    

    // Establish database connection
    String jdbcURL = "jdbc:mysql://localhost:3306/user";
    String dbUsername = "user1";
    String dbPassword = "12345678";

    Connection conn = null;
    PreparedStatement loginStmt = null;
    ResultSet loginResult = null;
    PreparedStatement studentStmt = null;
    ResultSet studentResult = null;
    PreparedStatement courseStmt = null;
    ResultSet courseResult = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcURL, dbUsername, dbPassword);

        // Check if the username exists in the login table
        String loginQuery = "SELECT * FROM login WHERE username = ?";
        loginStmt = conn.prepareStatement(loginQuery);
        loginStmt.setString(1, username);
        loginResult = loginStmt.executeQuery();

        if (loginResult.next()) {
            // Username exists, retrieve student information using a join operation
            String studentQuery = "SELECT * FROM student INNER JOIN login ON student.username = login.username WHERE student.username = ?";
            studentStmt = conn.prepareStatement(studentQuery);
            studentStmt.setString(1, username);
            studentResult = studentStmt.executeQuery();

            if (studentResult.next()) {
                // Student record found
                String studname = studentResult.getString("studname");
                String studid = studentResult.getString("studid");
                String program = studentResult.getString("program");
                String totcredit = studentResult.getString("totcredit");
                String gpa = studentResult.getString("gpa");
                String cgpa = studentResult.getString("cgpa");

                // Set the retrieved values as attributes to be accessed in HTML
                request.setAttribute("studname", studname);
                request.setAttribute("studid", studid);
                request.setAttribute("program", program);
                request.setAttribute("totcredit", totcredit);
                request.setAttribute("gpa", gpa);
                request.setAttribute("cgpa", cgpa);

                String courseQuery = "SELECT * FROM studentcourse WHERE studid = ?";
                courseStmt = conn.prepareStatement(courseQuery);
                courseStmt.setString(1, studid);
                courseResult = courseStmt.executeQuery();
                // Create a list to store the course information
                List<Map<String, String>> courseList = new ArrayList<>();

                while (courseResult.next()) {
                    // Course record found
                    String coursecode = courseResult.getString("coursecode");
                    String coursename = courseResult.getString("coursename");
                    String enroll = courseResult.getString("enroll");
                    String termcode = courseResult.getString("termcode");
                    String credit = courseResult.getString("credit");
                    String grade = courseResult.getString("grade");
                   

                    // Create a map to store the course details
                    Map<String, String> courseMap = new HashMap<>();
                    courseMap.put("coursecode", coursecode);
                    courseMap.put("coursename", coursename);
                    courseMap.put("enroll", enroll);
                    courseMap.put("termcode", termcode);
                    courseMap.put("credit", credit);
                    courseMap.put("grade", grade);
                    
                    // Add the course map to the course list
                    courseList.add(courseMap);
                }
                // Set the retrieved values as attributes to be accessed in HTML
                request.setAttribute("courseList", courseList);
            } else {
                message = "No student record found for the given username";
            }
        } else {
            message = "Invalid login credentials";
        }
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        message = "An error occurred while processing the request.";
    } finally {
        // Close the result sets, prepared statements, and connection in the reverse order of their creation
        if (courseResult != null) {
            try {
                courseResult.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (courseStmt != null) {
            try {
                courseStmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
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
    <title>Update Record</title>
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
    <h1>Update Record</h1>
     <p><%= message %></p>
    <form  id="updateForm" action="update_record_action.jsp" method="POST">
    <!-- Student Information -->
    <label for="fullname">Full Name:</label>
    <input type="text" id="fullname" name="fullname" value="<%= request.getAttribute("studname") %>" disabled>
   
    <input type="hidden" name="username" value="<%= request.getParameter("username") %>">
    <label for="studid">Student ID:</label>
    <input type="text" id="studid" name="studid" value="<%= request.getAttribute("studid") %>"  disabled>
    

    <label for="program">Program:</label>
    <input type="text" id="program" name="program" value="<%= request.getAttribute("program") %>" disabled>
    

    <label for="totcredit">Total Credits:</label>
    <input type="text" id="totcredit" name="totcredit" value="<%= request.getAttribute("totcredit") %>" disabled>
    

    <label for="gpa">GPA:</label>
    <input type="text" id="gpa" name="gpa" value="<%= request.getAttribute("gpa") %>" disabled>
    <button type="button" onclick="enableEdit('gpa')">Modify</button>

    <label for="cgpa">CGPA:</label>
    <input type="text" id="cgpa" name="cgpa" value="<%= request.getAttribute("cgpa") %>" disabled>
    <button type="button" onclick="enableEdit('cgpa')">Modify</button>

    <!-- Student Course Information -->

<%
List<Map<String, String>> courseList = (List<Map<String, String>>) request.getAttribute("courseList");
if (courseList != null) {
    for (int i = 0; i < courseList.size(); i++) {
        Map<String, String> course = courseList.get(i);
        String coursecode = course.get("coursecode");
        String coursename = course.get("coursename");
        String enroll = course.get("enroll");
        String termcode = course.get("termcode");
        String credit = course.get("credit");
        String grade = course.get("grade");
        String gradeInputId = "grade_" + i; // Generate unique ID for each grade input field
%>
<label for="coursecode">Course Code:</label>
<input type="text" id="coursecode" name="coursecode" value="<%= coursecode %>" disabled>

<label for="coursename">Course Name:</label>
<input type="text" id="coursename" name="coursename" value="<%= coursename %>" disabled>

<label for="<%= gradeInputId %>">Grade:</label>
<input type="text" id="<%= gradeInputId %>" name="grade" value="<%= grade %>" disabled>




<br>
<br>
<%
    }
}
%>


    <!-- Add more input fields for other attributes -->

    <input type="submit" value="Update">
</form>
   <%-- Display the message if it is not empty --%>

 



 
   
</body>
</html>