<%@ page import="java.sql.*" %>
<%@ include file="config.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String userName = (String) session.getAttribute("user_name");
    if (userName == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String firstLetter = userName.substring(0, 1).toUpperCase();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Browse Designs - Designora</title>
<style>
*{margin:0;padding:0;box-sizing:border-box}
body{font-family:system-ui,-apple-system,sans-serif;background:#0f172a;color:#fff}
a{text-decoration:none}
.header{background:linear-gradient(90deg,#1e293b,#1e3a52,#1e293b);border-bottom:1px solid rgba(71,85,105,.5);padding:1rem 2rem;position:sticky;top:0;z-index:999}
.header-content{max-width:1400px;margin:0 auto;display:flex;justify-content:space-between;align-items:center}
.logo{font-size:1.5rem;background:linear-gradient(90deg,#fbbf24,#fb7185);-webkit-background-clip:text;background-clip:text;-webkit-text-fill-color:transparent}
.nav-menu{display:flex;gap:2rem}
.nav-menu a{color:#9ca3af;transition:.3s}
.nav-menu a:hover{color:#fbbf24}
.user-info{display:flex;align-items:center;gap:1rem}
.avatar{width:40px;height:40px;border-radius:50%;background:linear-gradient(135deg,#f59e0b,#fb7185);display:flex;align-items:center;justify-content:center;font-size:1.2rem;border:2px solid rgba(251,191,36,.5)}
.container{max-width:1400px;margin:0 auto;padding:2rem}
.page-header{text-align:center;margin-bottom:3rem}
.page-header h1{font-size:2.5rem;margin-bottom:.5rem}
.gradient-text{background:linear-gradient(90deg,#fbbf24,#fb7185);-webkit-background-clip:text;background-clip:text;-webkit-text-fill-color:transparent}
.page-header p{color:#9ca3af}
.search-box{display:flex;gap:1rem;margin-bottom:2rem}
.search-input{flex:1;padding:1rem 1.5rem;background:rgba(30,41,59,.5);border:1px solid rgba(71,85,105,.5);border-radius:.5rem;color:#fff;font-size:1rem}
.search-input:focus{outline:none;border-color:#fbbf24}
.search-btn{padding:1rem 2rem;background:linear-gradient(90deg,#f59e0b,#fb7185);border:none;border-radius:.5rem;color:#fff;cursor:pointer;transition:.3s}
.search-btn:hover{box-shadow:0 10px 20px rgba(251,191,36,.3)}
.filters{display:flex;gap:1rem;margin-bottom:2rem;flex-wrap:wrap}
.filter-btn{padding:.75rem 1.5rem;background:rgba(30,41,59,.5);border:1px solid rgba(71,85,105,.5);border-radius:2rem;color:#9ca3af;cursor:pointer;transition:.3s;font-size:.9rem}
.filter-btn:hover,.filter-btn.active{background:rgba(251,191,36,.1);border-color:#fbbf24;color:#fbbf24}
.designs-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(300px,1fr));gap:2rem}
.design-card{background:rgba(30,41,59,.5);border:1px solid rgba(71,85,105,.5);border-radius:1rem;overflow:hidden;transition:.3s;cursor:pointer}
.design-card:hover{border-color:rgba(251,191,36,.5);transform:translateY(-5px);box-shadow:0 20px 40px rgba(0,0,0,.3)}
.design-image{height:350px;display:flex;align-items:center;justify-content:center;position:relative;background:#1e293b}
.design-image img{width:100%;height:100%;object-fit:cover}
.favorite{position:absolute;top:.75rem;right:.75rem;width:32px;height:32px;background:rgba(0,0,0,.55);backdrop-filter:blur(10px);border-radius:50%;display:flex;align-items:center;justify-content:center;cursor:pointer;transition:.3s;border:1px solid rgba(255,255,255,.2);font-size:.9rem}
.favorite:hover{transform:scale(1.08)}
.favorite.active{background:rgba(251,191,36,.18);color:#ff5a7a}
.design-info{padding:1.5rem}
.design-info h3{font-size:1.25rem;margin-bottom:.5rem;color:#fbbf24}
.designer-name{display:flex;align-items:center;gap:.5rem;color:#9ca3af;font-size:.9rem;margin-bottom:1rem}
.design-meta{display:flex;justify-content:space-between;align-items:center;margin-bottom:1rem}
.rating{color:#fbbf24}
.price{font-size:1.25rem;font-weight:700;background:linear-gradient(90deg,#fbbf24,#fb7185);-webkit-background-clip:text;background-clip:text;-webkit-text-fill-color:transparent}
.tags{display:flex;gap:.5rem;flex-wrap:wrap;margin-bottom:1rem}
.tag{padding:.25rem .75rem;background:rgba(71,85,105,.5);border-radius:1rem;font-size:.75rem;color:#9ca3af}
.btn{flex:1;padding:.875rem;background:linear-gradient(90deg,#f59e0b,#fb7185);border:none;border-radius:.5rem;color:#fff;font-weight:600;cursor:pointer;transition:.3s}
.btn:hover{box-shadow:0 10px 20px rgba(251,191,36,.3);transform:translateY(-2px)}
.no-results{display:none;text-align:center;color:#9ca3af;font-size:1.1rem;padding:2rem}
@media(max-width:768px){
.nav-menu{display:none}
.designs-grid{grid-template-columns:1fr}
.filters{justify-content:center}
.search-box{flex-direction:column}
}
</style>
</head>
<body>
<div class="header">
    <div class="header-content">
        <div class="logo">✨ Designora</div>
        <div class="nav-menu">
            <a href="home.jsp">Home</a>
            <a href="view-designs.jsp">Designs</a>
            <a href="user-dashboard.jsp">Dashboard</a>
        </div>
        <div class="user-info">
            <div class="avatar"><%= firstLetter %></div>
            <span><%= userName %></span>
        </div>
    </div>
</div>

<div class="container">
    <div class="page-header">
        <h1>Explore <span class="gradient-text">Premium Designs</span></h1>
        <p>Discover custom fashion designs from talented designers</p>
    </div>

    <div class="search-box">
        <input type="text" id="searchInput" class="search-input" placeholder="Search designs, designers, styles...">
        <button class="search-btn" onclick="filterDesigns()">🔍 Search</button>
    </div>

    <div class="filters">
        <button class="filter-btn active" data-category="all" onclick="setCategory(this,'all')">All</button>
        <button class="filter-btn" data-category="bridal" onclick="setCategory(this,'bridal')">Bridal</button>
        <button class="filter-btn" data-category="casual" onclick="setCategory(this,'casual')">Casual</button>
        <button class="filter-btn" data-category="party" onclick="setCategory(this,'party')">Party</button>
        <button class="filter-btn" data-category="ethnic" onclick="setCategory(this,'ethnic')">Ethnic</button>
        <button class="filter-btn" data-category="formal" onclick="setCategory(this,'formal')">Formal</button>
        <button class="filter-btn" data-category="bohemian" onclick="setCategory(this,'bohemian')">Bohemian</button>
        <button class="filter-btn" data-category="couture" onclick="setCategory(this,'couture')">Couture</button>
        <button class="filter-btn" data-category="contemporary" onclick="setCategory(this,'contemporary')">Contemporary</button>
    </div>

    <div class="designs-grid" id="designsGrid">
<%
PreparedStatement ps = null;
ResultSet rs = null;

try {
    ps = conn.prepareStatement("SELECT * FROM designs");
    rs = ps.executeQuery();

    while(rs.next()){
        String name = rs.getString("name");
        String designer = rs.getString("designer_name");
        String image = rs.getString("image_url");
        String category = rs.getString("category");
        String price = rs.getString("price");
%>
<div class="design-card" data-category="<%= category %>" data-search="<%= name %> <%= designer %> <%= category %>">
    <div class="design-image">
       <img src="<%= rs.getString("image_url") %>" width="200" alt="Design">
        <div class="favorite" onclick="toggleFavorite(event,this)">♡</div>
    </div>
    <div class="design-info">
        <h3><%= name %></h3>
        <div class="designer-name">👩‍🎨 <%= designer %></div>
        <div class="tags">
            <span class="tag"><%= category %></span>
        </div>
        <div class="design-meta">
            <span class="rating">⭐ 4.5</span>
            <span class="price">₹<%= price %></span>
        </div>
        <div style="display:flex; gap:10px;">
            <form action="cart-handler.jsp" method="post" onClick="event.stopPropagation();">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="design_id" value="<%= rs.getInt("design_id") %>">
                <button type="submit" class="btn">Add to Cart</button>
            </form>

            <form action="order-confirmation.jsp" method="post" onClick="event.stopPropagation();">
                <input type="hidden" name="buy_now" value="true">
                <input type="hidden" name="design_id" value="<%= rs.getInt("design_id") %>">
                <input type="hidden" name="price" value="<%= price %>">
                <button type="submit" class="btn">Buy Now</button>
            </form>
        </div>
    </div>
</div>
<%
    }
} catch(Exception e){ out.println("Error: "+e.getMessage()); }
finally { if(rs!=null) try{rs.close();}catch(Exception e){} if(ps!=null) try{ps.close();}catch(Exception e){} }
%>
    </div>
    <div class="no-results" id="noResults">No designs found.</div>
</div>

<script>
let selectedCategory = "all";
function toggleFavorite(event, el){event.stopPropagation(); el.classList.toggle("active"); el.innerHTML = el.classList.contains("active") ? "♥" : "♡";}
function setCategory(button, category){selectedCategory = category; document.querySelectorAll(".filter-btn").forEach(btn=>btn.classList.remove("active")); button.classList.add("active"); filterDesigns();}
function filterDesigns(){
    const searchText = document.getElementById("searchInput").value.toLowerCase().trim();
    const cards = document.querySelectorAll(".design-card");
    let visibleCount = 0;
    cards.forEach(card=>{
        const cardCategory = card.getAttribute("data-category").toLowerCase();
        const cardSearch = card.getAttribute("data-search").toLowerCase();
        const categoryMatch = selectedCategory === "all" || cardCategory.includes(selectedCategory);
        const searchMatch = searchText === "" || cardSearch.includes(searchText);
        if(categoryMatch && searchMatch){ card.style.display="block"; visibleCount++; } else card.style.display="none";
    });
    document.getElementById("noResults").style.display = visibleCount === 0 ? "block" : "none";
}
document.getElementById("searchInput").addEventListener("keyup", function(event){ filterDesigns(); if(event.key==="Enter") filterDesigns(); });
</script>
</body>
</html>