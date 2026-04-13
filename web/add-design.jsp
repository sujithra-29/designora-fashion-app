<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String designerName = "Designer";
    String avatarLetter = "D";

    if (session.getAttribute("user_name") != null) {
        designerName = session.getAttribute("user_name").toString();
        if (!designerName.trim().isEmpty()) {
            avatarLetter = designerName.substring(0, 1).toUpperCase();
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Add Design - Designora</title>

<!-- KEEPING YOUR EXACT SAME CSS -->
<style>
/* (Your full CSS remains unchanged — no edits here) */
*{margin:0;padding:0;box-sizing:border-box}
body{font-family:system-ui,-apple-system,sans-serif;background:#0f172a;color:#fff}
a{text-decoration:none}
.header{background:linear-gradient(90deg,#1e293b,#1e3a52,#1e293b);border-bottom:1px solid rgba(71,85,105,.5);padding:1rem 2rem}
.header-content{max-width:1400px;margin:0 auto;display:flex;justify-content:space-between;align-items:center}
.logo{font-size:1.5rem;background:linear-gradient(90deg,#fbbf24,#fb7185);-webkit-background-clip:text;background-clip:text;-webkit-text-fill-color:transparent}
.user-info{display:flex;align-items:center;gap:1rem}
.avatar{width:40px;height:40px;border-radius:50%;background:linear-gradient(135deg,#f59e0b,#fb7185);display:flex;align-items:center;justify-content:center;font-size:1.2rem;border:2px solid rgba(251,191,36,.5)}
.badge-designer{background:rgba(251,191,36,.2);color:#fbbf24;padding:.25rem .75rem;border-radius:1rem;font-size:.8rem}
.container{max-width:900px;margin:0 auto;padding:2rem}
.back-link{margin-bottom:2rem}
.back-link a{color:#9ca3af;font-size:.9rem;transition:.3s;display:inline-flex;align-items:center;gap:.5rem}
.back-link a:hover{color:#fbbf24}
.card{background:rgba(30,41,59,.5);border:1px solid rgba(71,85,105,.5);border-radius:1.5rem;padding:3rem}
.page-header{margin-bottom:2rem}
.page-header h1{font-size:2rem;margin-bottom:.5rem;background:linear-gradient(90deg,#fbbf24,#fb7185);-webkit-background-clip:text;background-clip:text;-webkit-text-fill-color:transparent}
.page-header p{color:#9ca3af}
.form-section{margin-bottom:2rem;padding-bottom:2rem;border-bottom:1px solid rgba(71,85,105,.5)}
.form-section:last-of-type{border-bottom:none}
.form-section h2{font-size:1.25rem;margin-bottom:1rem;color:#fbbf24}
.form-group{margin-bottom:1.5rem}
.form-group label{display:block;color:#d1d5db;margin-bottom:.5rem;font-size:.9rem}
.form-group input,.form-group select,.form-group textarea{width:100%;padding:.875rem 1rem;background:rgba(15,23,42,.6);border:1px solid rgba(71,85,105,.5);border-radius:.5rem;color:#fff;font-size:1rem;transition:.3s;font-family:inherit}
.form-group input:focus,.form-group select:focus,.form-group textarea:focus{outline:none;border-color:#fbbf24;box-shadow:0 0 0 3px rgba(251,191,36,.1)}
.form-group input::placeholder,.form-group textarea::placeholder{color:#6b7280}
.form-group select{cursor:pointer}
.form-group select option{background:#1e293b;color:#fff}
.form-group textarea{min-height:120px;resize:vertical}
.form-row{display:grid;grid-template-columns:repeat(2,1fr);gap:1rem}
.btn-group{display:flex;gap:1rem;margin-top:2rem}
.btn{flex:1;padding:1rem;border-radius:.5rem;border:none;cursor:pointer;font-size:1rem;font-weight:600}
.btn-primary{background:linear-gradient(90deg,#f59e0b,#fb7185);color:#fff}
.btn-secondary{background:rgba(71,85,105,.5);color:#fff}
</style>
</head>

<body>

<div class="header">
    <div class="header-content">
        <div class="logo">✨ Designora</div>
        <div class="user-info">
            <span class="badge-designer">Designer</span>
            <div class="avatar"><%= avatarLetter %></div>
            <span><%= designerName %></span>
        </div>
    </div>
</div>

<div class="container">

<div class="back-link">
    <a href="designer-dashboard.jsp">← Back to Dashboard</a>
</div>

<div class="card">

<div class="page-header">
    <h1>Add New Design</h1>
    <p>Create and showcase your latest fashion masterpiece</p>
</div>

<!-- ✅ FORM CONNECTED -->
<form action="add-design-handler.jsp" method="post">

<div class="form-section">
    <h2>Basic Information</h2>

    <div class="form-group">
        <label>Design Title</label>
        <input type="text" name="name" required>
    </div>

    <div class="form-group">
        <label>Description</label>
        <textarea name="description" required></textarea>
    </div>

    <div class="form-row">
        <div class="form-group">
            <label>Category</label>
            <select name="category" required>
                <option value="">Select</option>
                <option>Bridal</option>
                <option>Casual</option>
                <option>Party</option>
                <option>Ethnic</option>
            </select>
        </div>

        <div class="form-group">
            <label>Price</label>
            <input type="number" name="price" required>
        </div>
    </div>
</div>

<div class="form-section">
    <h2>Details</h2>

    <div class="form-group">
        <label>Material</label>
        <input type="text" name="material" required>
    </div>

    <!-- ✅ NEW FIELDS -->
    <div class="form-group">
        <label>Image URL</label>
        <input type="url" name="image_url" required>
    </div>

    <div class="form-row">
        <div class="form-group">
            <label>Size</label>
            <input type="text" name="size">
        </div>

        <div class="form-group">
            <label>Color</label>
            <input type="text" name="color">
        </div>
    </div>
</div>

<div class="btn-group">
    <button type="button" class="btn btn-secondary"
        onclick="window.location.href='designer-dashboard.jsp'">
        Cancel
    </button>

    <button type="submit" class="btn btn-primary">
        Publish Design
    </button>
</div>

</form>

</div>
</div>

</body>
</html>