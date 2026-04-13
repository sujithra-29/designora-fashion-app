<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Register - Designora</title>
<style>
*{margin:0;padding:0;box-sizing:border-box}
body{font-family:system-ui,-apple-system,sans-serif;background:linear-gradient(135deg,#0f172a,#1e293b,#312e81);color:#fff;min-height:100vh;display:flex;align-items:center;justify-content:center;padding:2rem}
a{text-decoration:none}
.logo{text-align:center;font-size:2rem;background:linear-gradient(90deg,#fbbf24,#fb7185);-webkit-background-clip:text;background-clip:text;-webkit-text-fill-color:transparent;margin-bottom:2rem}
.form-container{background:rgba(30,41,59,.8);border:1px solid rgba(71,85,105,.5);border-radius:1.5rem;padding:3rem;max-width:450px;width:100%;backdrop-filter:blur(10px)}
.form-container h2{font-size:2rem;margin-bottom:.5rem;text-align:center}
.subtitle{text-align:center;color:#9ca3af;margin-bottom:2rem}
.form-group{margin-bottom:1.5rem}
.form-group label{display:block;color:#d1d5db;margin-bottom:.5rem;font-size:.9rem}
.form-group input,.form-group select{width:100%;padding:.875rem 1rem;background:rgba(15,23,42,.6);border:1px solid rgba(71,85,105,.5);border-radius:.5rem;color:#fff;font-size:1rem;transition:.3s}
.form-group input:focus,.form-group select:focus{outline:none;border-color:#fbbf24;box-shadow:0 0 0 3px rgba(251,191,36,.1)}
.form-group input::placeholder{color:#6b7280}
.form-group select{cursor:pointer}
.form-group select option{background:#1e293b;color:#fff}
.btn{width:100%;padding:1rem;background:linear-gradient(90deg,#f59e0b,#fb7185);border:none;border-radius:.5rem;color:#fff;font-size:1rem;font-weight:600;cursor:pointer;transition:.3s;margin-top:1rem}
.btn:hover{box-shadow:0 10px 30px rgba(251,191,36,.3);transform:translateY(-2px)}
.divider{display:flex;align-items:center;margin:2rem 0;color:#6b7280;font-size:.9rem}
.divider::before,.divider::after{content:'';flex:1;height:1px;background:rgba(71,85,105,.5)}
.divider::before{margin-right:1rem}
.divider::after{margin-left:1rem}
.social-btns{display:flex;gap:1rem;margin-bottom:2rem}
.social-btn{flex:1;padding:.875rem;background:rgba(15,23,42,.6);border:1px solid rgba(71,85,105,.5);border-radius:.5rem;color:#d1d5db;font-size:.9rem;cursor:pointer;transition:.3s;display:flex;align-items:center;justify-content:center;gap:.5rem}
.social-btn:hover{border-color:#fbbf24;background:rgba(251,191,36,.1)}
.login-link{text-align:center;margin-top:2rem;color:#9ca3af}
.login-link a{color:#fbbf24;font-weight:600;transition:.3s}
.login-link a:hover{color:#fb7185}
.role-selector{display:flex;gap:1rem;margin-bottom:2rem}
.role-option{flex:1;padding:1rem;background:rgba(15,23,42,.6);border:2px solid rgba(71,85,105,.5);border-radius:.5rem;text-align:center;cursor:pointer;transition:.3s}
.role-option:hover{border-color:#fbbf24}
.role-option.active{border-color:#fbbf24;background:rgba(251,191,36,.1)}
.role-icon{font-size:2rem;margin-bottom:.5rem}
.back-link{text-align:center;margin-bottom:2rem}
.back-link a{color:#9ca3af;font-size:.9rem;transition:.3s;display:inline-flex;align-items:center;gap:.5rem}
.back-link a:hover{color:#fbbf24}
.checkbox-group{display:flex;align-items:start;gap:.5rem;margin-top:1.5rem}
.checkbox-group input{width:auto;margin-top:.25rem}
.checkbox-group label{font-size:.85rem;color:#9ca3af}
.message-box{margin-bottom:1rem;padding:.85rem 1rem;border-radius:.5rem;font-size:.9rem}
.error-box{background:rgba(239,68,68,.15);border:1px solid rgba(239,68,68,.4);color:#fecaca}
.success-box{background:rgba(34,197,94,.15);border:1px solid rgba(34,197,94,.4);color:#bbf7d0}
@media(max-width:640px){.form-container{padding:2rem}}
</style>
</head>
<body>
<div class="form-container">
    <div class="back-link"><a href="home.jsp">← Back to Home</a></div>
    <div class="logo">✨ Designora</div>
    <h2>Create Account</h2>
    <p class="subtitle">Join our premium fashion platform</p>

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

    <div class="role-selector">
        <div class="role-option active" onclick="selectRole(this, 'user')">
            <div class="role-icon">👤</div>
            <div>Customer</div>
        </div>
        <div class="role-option" onclick="selectRole(this, 'designer')">
            <div class="role-icon">👨‍🎨</div>
            <div>Designer</div>
        </div>
    </div>

    <form action="register-handler.jsp" method="POST" autocomplete="off">
<input type="hidden" name="role" id="roleInput" value="user">
        <div class="form-group">
            <label>Full Name</label>
            <input type="text" id="name" name="full_name"
                   placeholder="Name"
                   pattern="[A-Za-z ]{3,40}"
                   title="Name should contain only letters and spaces"
                   required>
        </div>

        <div class="form-group">
            <label>Email Address</label>
            <input type="email" id="email" name="email"
                   placeholder="your@email.com"
                   required>
        </div>

        <div class="form-group">
            <label>Phone Number</label>
            <input type="tel" id="phone" name="phone"
                   placeholder="9876543210"
                   pattern="[0-9]{10}"
                   required>
        </div>

        <div class="form-group">
            <label>Password</label>
            <input type="password" id="password" name="password"
                   placeholder="Create strong password"
                   required>
        </div>

        <div class="form-group">
            <label>Confirm Password</label>
            <input type="password" id="confirmPassword" name="confirm_password"
                   placeholder="Re-enter password"
                   required>
        </div>

        <div class="checkbox-group">
            <input type="checkbox" id="terms" required>
            <label for="terms">I agree to the Terms of Service and Privacy Policy</label>
        </div>

        <button type="submit" class="btn">Create Account</button>
    </form>

    <div class="divider">OR</div>

    <div class="social-btns">
        <button type="button" class="social-btn">📘 Google</button>
        <button type="button" class="social-btn">🐦 Twitter</button>
    </div>

    <div class="login-link">Already have an account? <a href="login.jsp">Login</a></div>
</div>

<script>
function selectRole(element, role) {
    document.querySelectorAll('.role-option').forEach(el => el.classList.remove('active'));
    element.classList.add('active');
    document.getElementById('roleInput').value = role;
}

document.querySelector("form").addEventListener("submit", function(e) {
    let name = document.getElementById("name").value.trim();
    let email = document.getElementById("email").value.trim();
    let phone = document.getElementById("phone").value.trim();
    let password = document.getElementById("password").value;
    let confirmPassword = document.getElementById("confirmPassword").value;

    let namePattern = /^[A-Za-z ]{3,40}$/;
let emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
let phonePattern = /^[0-9]{10}$/;
let passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$/;
    if (!namePattern.test(name)) {
        e.preventDefault();
        alert("Enter a valid name (letters and spaces only).");
        return;
    }

    if (!emailPattern.test(email)) {
        e.preventDefault();
        alert("Enter a valid email address.");
        return;
    }

    if (!phonePattern.test(phone)) {
        e.preventDefault();
        alert("Phone number must be 10 digits.");
        return;
    }

    if (!passwordPattern.test(password)) {
        e.preventDefault();
        alert("Password must contain at least 8 characters, one uppercase letter, one lowercase letter, and one number.");
        return;
    }

    if (password !== confirmPassword) {
        e.preventDefault();
        alert("Passwords do not match.");
    }
});
</script>
</body>
</html>