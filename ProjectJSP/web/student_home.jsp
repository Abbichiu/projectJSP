<%@ page import="javax.servlet.http.*" %>
<!DOCTYPE html>
<html>
<head>
    </head>
    <style>
        
         @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300&display=swap');
    * {
       
        box-sizing: border-box;
        font-family: "Poppins", sans-serif;
    }
    
    body {
        display: flex;
        height: 100vh;
        background-color: aqua;
        background: url(home.jpg) no-repeat;
        background-size: cover;
        background-position: center;
    }
    
   
    </style>
<body>
     <%-- Retrieve the username from session --%>
    <% HttpSession sessionObj = request.getSession(); %>
    <% String username = (String) sessionObj.getAttribute("username"); %>
     <p>Welcome, <%= username %>! This is the home page.</p>
     <br>
    <header>
        <div class="navbar">
            <i class="fa-solid fa-bars"></i>
            <ul class="link">
                <div class="enroll">
                    <li>
                        <a href="enroll.html">Enrollment</a>
                    </li>
                </div>
                <div class="record">
                    <li>
                        <a href="student_record.jsp?username=<%= username%>">Student Academic Record</a>
                    </li>
                </div>
                <div class="personal">
                    <li>
                       <a href="personal.jsp?username=<%= username %>">Personal Information</a>
                    </li>
                </div>
                <div class="contact">
                    <li>
                        <a href="contactus.html">Contact Us</a>
                    </li>
                </div>
            </ul>
        </div>
    </header>

   
   
</body>
</html>