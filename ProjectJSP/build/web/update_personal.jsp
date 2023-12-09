<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
  <%-- Retrieve the username from session --%>
    <% HttpSession sessionObj = request.getSession(); %>
    <% String username = (String) sessionObj.getAttribute("username"); %>
    
<%
     // Establish database connection
    
    
    String fullname = request.getParameter("fullname");
    String gender = request.getParameter("gender");
    String studid = request.getParameter("studid");
    String hkid = request.getParameter("hkid");
    String email = request.getParameter("email");
    String address = request.getParameter("address");
    String birthdate = request.getParameter("birthdate");
    String subject = request.getParameter("subject");
    String phone = request.getParameter("phone");

    // Establish database connection
    String jdbcURL = "jdbc:mysql://localhost:3306/user";
    String dbUsername = "user1";
    String dbPassword = "12345678";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection(jdbcURL, dbUsername, dbPassword);

        // Update the personal information in the database
        String updateQuery = "UPDATE personal SET fullname = ?, gender = ?, studid = ?, hkid = ?, email = ?, address = ?, birthdate = ?, subject = ?, phone = ? WHERE username = ?";
        PreparedStatement updateStmt = conn.prepareStatement(updateQuery);
        updateStmt.setString(1, fullname);
        updateStmt.setString(2, gender);
        updateStmt.setString(3, studid);
        updateStmt.setString(4, hkid);
        updateStmt.setString(5, email);
        updateStmt.setString(6, address);
        updateStmt.setString(7, birthdate);
        updateStmt.setString(8, subject);
        updateStmt.setString(9, phone);
        updateStmt.setString(10, username);
        int rowsAffected = updateStmt.executeUpdate();

        updateStmt.close();
        conn.close();

        if (rowsAffected > 0) {
            // Update successful
            response.sendRedirect("personal.jsp?username=" + username);
        } else {
            // Update failed
            String message = "Failed to update personal information";
            request.setAttribute("message", message);
            request.getRequestDispatcher("personal.jsp?username=" + username).forward(request, response);
        }
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        String message = "An error occurred while updating personal information";
        request.setAttribute("message", message);
        request.getRequestDispatcher("personal.jsp?username=" + username).forward(request, response);
    }
%>


   