<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<style>
    body {
        background-image: url('blue-color-background.jpg');
    }
    
    .table {
        background-image: none;
    }
</style>

<body>
    <div class="container">
        <h1 class="mt-5">Welcome to Administration Page</h1><br>

        <div class="row">
            <div class="col-md-6">
                <h3>User Information</h3>
                <form method="post" action="update_admin.jsp">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>UserID</th>
                                <th>Full Name</th>
                                <th>Email</th>
                                <th>Role</th>
                                <th>Register Date</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%  
                                String username = request.getParameter("username");
                                String userid = request.getParameter("userid");
                                String fullname = request.getParameter("fullname");
                                String email = request.getParameter("email");
                                String role = request.getParameter("role");
                                String registerDate = request.getParameter("registerDate");

                                // Display the retrieved values
                            %>
                            <tr>
                                <td><input type="text" name="userid" value="<%= userid %>" readonly></td>
                                <td><input type="text" name="fullname" value="<%= fullname %>"></td>
                                <td><input type="email" name="email" value="<%= email %>"></td>
                                <td><input type="text" name="role" value="<%= role %>"></td>
                                <td><input type="text" name="registerDate" value="<%= registerDate %>" readonly></td>
                            </tr>
                            <%
                            // Establish database connection
                            String jdbcURL = "jdbc:mysql://localhost:3306/user";
                            String dbUsername = "user1";
                            String dbPassword = "12345678";

                            try {
                                Class.forName("com.mysql.jdbc.Driver");
                                Connection conn = DriverManager.getConnection(jdbcURL, dbUsername, dbPassword);

                                // Update the personal information in the database
                                String updateQuery = "UPDATE personal SET fullname = ?, email = ?, subject = ? WHERE username = ?";
                                PreparedStatement updateStmt = conn.prepareStatement(updateQuery);
                                updateStmt.setString(1, fullname);
                                updateStmt.setString(2, email);
                                updateStmt.setString(3, role);
                                updateStmt.setString(4, userid);
                                int rowsAffected = updateStmt.executeUpdate();

                                updateStmt.close();

                                if (rowsAffected > 0) {
                                    // Update successful
                                    String message = "Successfully updated personal information";
                                    request.setAttribute("message", message);
                                    request.getRequestDispatcher("admin_page.jsp?username=" + username).forward(request, response);
                                } else {
                                    // Update failed
                                    String message = "Failed to update personal information";
                                    request.setAttribute("message", message);
                                    request.getRequestDispatcher("admin_page.jsp?username=" + username).forward(request, response);
                                }

                                conn.close();
                            } catch (ClassNotFoundException | SQLException e) {
                                e.printStackTrace();
                                String message = "An error occurred while updating personal information";
                                request.setAttribute("message", message);
                                request.getRequestDispatcher("admin_page.jsp?username=" + username).forward(request, response);
                            }
                            %>
                        </tbody>
                    </table>
                    <input type="submit" value="Submit">
                </form>
            </div>
        </div>
    </div>
</body>

</html>