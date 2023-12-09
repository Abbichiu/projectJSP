<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>

<%
    String username = request.getParameter("username");
    String updatedCGPA = request.getParameter("cgpa");
    String updatedGPA = request.getParameter("gpa");
    String updatedGrade = request.getParameter("grade");
    String courseCode = request.getParameter("coursecode");
    String studID = request.getParameter("studid");
    String gradeInputId = request.getParameter("gradeInputId");
    List<Map<String, String>> courseList = (List<Map<String, String>>) request.getAttribute("courseList");
    
    // Establish database connection
    String jdbcURL = "jdbc:mysql://localhost:3306/user";
    String dbUsername = "user1";
    String dbPassword = "12345678";

    Connection conn = null;
    PreparedStatement updateStudentStmt = null;
    PreparedStatement updateCourseStmt = null;
    boolean success = false;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcURL, dbUsername, dbPassword);

        // Update the student's CGPA and GPA
        String updateStudentQuery = "UPDATE student SET cgpa = ?, gpa = ? WHERE username = ?";
        updateStudentStmt = conn.prepareStatement(updateStudentQuery);
        updateStudentStmt.setString(1, updatedCGPA);
        updateStudentStmt.setString(2, updatedGPA);
        updateStudentStmt.setString(3, username);
        int studentUpdateCount = updateStudentStmt.executeUpdate();

       
                if (studentUpdateCount > 0) {
                    success = true;
                }
               
            } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
    } finally {
        // Close the prepared statements and connection
        if (updateStudentStmt != null) {
            try {
                updateStudentStmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (updateCourseStmt != null) {
            try {
                updateCourseStmt.close();
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

    // Redirect to the update_record.jsp page with a success or failure message
    String message = "";
    if (success) {            
            request.setAttribute("message", message);
            message = "Successfully updated personal information";
            response.sendRedirect("update_record.jsp?username=" + username + "&message=" + message);
    } else {
         request.setAttribute("message", message);
            message = "Failed updated personal information";
            response.sendRedirect("update_record.jsp?username=" + username + "&message=" + message);
    }
    
    
%>