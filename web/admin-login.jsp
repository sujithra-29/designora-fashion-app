<%-- 
    Document   : admin-login
    Created on : 15 Mar 2026, 6:40:06 pm
    Author     : SUJITHRA
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - Designora</title>
    <style>
        *{margin:0;padding:0;box-sizing:border-box}
        body{
            font-family:system-ui,-apple-system,sans-serif;
            background:linear-gradient(135deg,#0f172a,#1e293b,#312e81);
            color:#fff;
            min-height:100vh;
            display:flex;
            align-items:center;
            justify-content:center;
            padding:2rem
        }
        a{text-decoration:none}
        .form-container{
            background:rgba(30,41,59,.8);
            border:1px solid rgba(71,85,105,.5);
            border-radius:1.5rem;
            padding:3rem;
            max-width:450px;
            width:100%;
            backdrop-filter:blur(10px)
        }
        .logo{
            text-align:center;
            font-size:2rem;
            background:linear-gradient(90deg,#fbbf24,#fb7185);
            -webkit-background-clip:text;
            background-clip:text;
            -webkit-text-fill-color:transparent;
            margin-bottom:2rem
        }
        .form-container h2{
            font-size:2rem;
            margin-bottom:.5rem;
            text-align:center
        }
        .subtitle{
            text-align:center;
            color:#9ca3af;
            margin-bottom:2rem
        }
        .form-group{margin-bottom:1.5rem}
        .form-group label{
            display:block;
            color:#d1d5db;
            margin-bottom:.5rem;
            font-size:.9rem
        }
        .form-group input{
            width:100%;
            padding:.875rem 1rem;
            background:rgba(15,23,42,.6);
            border:1px solid rgba(71,85,105,.5);
            border-radius:.5rem;
            color:#fff;
            font-size:1rem;
            transition:.3s
        }
        .form-group input:focus{
            outline:none;
            border-color:#fbbf24;
            box-shadow:0 0 0 3px rgba(251,191,36,.1)
        }
        .form-group input::placeholder{color:#6b7280}
        .btn{
            width:100%;
            padding:1rem;
            background:linear-gradient(90deg,#f59e0b,#fb7185);
            border:none;
            border-radius:.5rem;
            color:#fff;
            font-size:1rem;
            font-weight:600;
            cursor:pointer;
            transition:.3s;
            margin-top:1rem
        }
        .btn:hover{
            box-shadow:0 10px 30px rgba(251,191,36,.3);
            transform:translateY(-2px)
        }
        .back-link{
            text-align:center;
            margin-bottom:2rem
        }
        .back-link a{
            color:#9ca3af;
            font-size:.9rem;
            transition:.3s;
            display:inline-flex;
            align-items:center;
            gap:.5rem
        }
        .back-link a:hover{color:#fbbf24}
        .user-link{
            text-align:center;
            margin-top:1.5rem
        }
        .user-link a{
            color:#93c5fd;
            font-size:.95rem;
            font-weight:600
        }
        .user-link a:hover{
            color:#fbbf24
        }
        .message-box{
            margin-bottom:1rem;
            padding:.85rem 1rem;
            border-radius:.5rem;
            font-size:.9rem
        }
        .error-box{
            background:rgba(239,68,68,.15);
            border:1px solid rgba(239,68,68,.4);
            color:#fecaca
        }
        .success-box{
            background:rgba(34,197,94,.15);
            border:1px solid rgba(34,197,94,.4);
            color:#bbf7d0
        }
        @media(max-width:640px){
            .form-container{padding:2rem}
        }
    </style>
</head>
<body>
    <div class="form-container">
        <div class="back-link"><a href="login.jsp">← Back to User Login</a></div>
        <div class="logo">✨ Designora</div>
        <h2>Admin Login</h2>
        <p class="subtitle">Login as administrator</p>

        <%
            String error = (String) session.getAttribute("error");
            String success = (String) session.getAttribute("success");

            if (error != null) {
        %>
            <div class="message-box error-box"><%= error %></div>
        <%
                session.removeAttribute("error");
            }

            if (success != null) {
        %>
            <div class="message-box success-box"><%= success %></div>
        <%
                session.removeAttribute("success");
            }
        %>

        <form action="admin-login-handler.jsp" method="POST" autocomplete="off">
            <div class="form-group">
                <label>Admin Email</label>
                <input type="email" name="email" id="email" placeholder="admin@email.com" required>
            </div>

            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" id="password" placeholder="Enter admin password" required>
            </div>

            <button type="submit" class="btn">Admin Login</button>
        </form>

        <div class="user-link">
            <a href="login.jsp">Go to User Login</a>
        </div>
    </div>
</body>
</html>