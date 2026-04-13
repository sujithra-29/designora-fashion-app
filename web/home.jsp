<%-- 
    Document   : home
    Created on : 1 Mar 2026, 7:54:34 pm
    Author     : SUJITHRA
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.regex.*, java.security.MessageDigest" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Designora - Premium Fashion Platform</title>
<style>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: system-ui, -apple-system, sans-serif;
  background: #0f172a;
  color: #fff;
  overflow-x: hidden;
}

a {
  text-decoration: none;
}

header {
  position: fixed;
  top: 0;
  width: 100%;
  background: linear-gradient(90deg, #1e293b, #1e3a52, #1e293b);
  backdrop-filter: blur(10px);
  border-bottom: 1px solid rgba(251, 191, 36, .2);
  z-index: 999;
  padding: 1rem 2rem;
}

.container {
  max-width: 1280px;
  margin: 0 auto;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.logo {
  display: flex;
  align-items: center;
  gap: .5rem;
  font-size: 1.5rem;
  background: linear-gradient(90deg, #fbbf24, #fb7185);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

nav {
  display: flex;
  gap: 2rem;
}

nav a {
  color: #d1d5db;
  transition: .3s;
}

nav a:hover {
  color: #fbbf24;
}

.auth-btns {
  display: flex;
  gap: 1rem;
}

.auth-btns button {
  padding: .5rem 1.5rem;
  border-radius: 2rem;
  border: none;
  cursor: pointer;
  transition: .3s;
}

.login {
  background: 0;
  color: #d1d5db;
  border: 1px solid transparent;
}

.login:hover {
  border-color: #fbbf24;
}

.signup {
  background: linear-gradient(90deg, #f59e0b, #fb7185);
  color: #fff;
}

.signup:hover {
  box-shadow: 0 10px 30px rgba(251, 191, 36, .3);
}

.hero {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, #1e293b 0%, #312e81 50%, #1e293b 100%);
  position: relative;
  margin-top: 70px;
}

.hero::before {
  content: '';
  position: absolute;
  width: 500px;
  height: 500px;
  background: radial-gradient(circle, rgba(251, 191, 36, .15), transparent);
  top: 10%;
  right: 10%;
  border-radius: 50%;
  animation: float 6s ease-in-out infinite;
}

@keyframes float {
  0%, 100% {
    transform: translateY(0);
  }
  50% {
    transform: translateY(-30px);
  }
}

.hero-content {
  position: relative;
  text-align: center;
  padding: 2rem;
  max-width: 900px;
  z-index: 1;
}

.badge {
  display: inline-flex;
  align-items: center;
  gap: .5rem;
  background: rgba(251, 191, 36, .1);
  border: 1px solid rgba(251, 191, 36, .3);
  padding: .5rem 1.5rem;
  border-radius: 2rem;
  margin-bottom: 2rem;
  color: #fbbf24;
  font-size: .9rem;
}

.hero h1 {
  font-size: clamp(2rem, 5vw, 4rem);
  margin-bottom: 1rem;
  line-height: 1.2;
}

.gradient-text {
  background: linear-gradient(90deg, #fbbf24, #fb7185, #ec4899);
  -webkit-background-clip: text;
  background-clip: text;
  -webkit-text-fill-color: transparent;
}

.hero p {
  font-size: 1.1rem;
  color: #d1d5db;
  margin-bottom: 2rem;
  line-height: 1.6;
}

.hero-btns {
  display: flex;
  gap: 1rem;
  justify-content: center;
  flex-wrap: wrap;
}

.hero-btns button {
  padding: 1rem 2rem;
  border-radius: 2rem;
  border: none;
  font-size: 1rem;
  cursor: pointer;
  transition: .3s;
  font-weight: 500;
}

.cta-primary {
  background: linear-gradient(90deg, #f59e0b, #fb7185);
  color: #fff;
}

.cta-primary:hover {
  box-shadow: 0 20px 40px rgba(251, 191, 36, .3);
  transform: translateY(-2px);
}

.cta-secondary {
  background: transparent;
  border: 2px solid rgba(251, 191, 36, .5);
  color: #fbbf24;
}

.cta-secondary:hover {
  background: rgba(251, 191, 36, .1);
}


@media (max-width: 768px) {
  nav {
    display: none;
  }
  .auth-btns {
    gap: .5rem;
  }
  .auth-btns button {
    padding: .4rem 1rem;
    font-size: .9rem;
  }
  .hero {
    margin-top: 60px;
    padding: 2rem 1rem;
  }
  .section {
    padding: 3rem 1rem;
  }
  .grid-3,
  .grid-4 {
    grid-template-columns: 1fr;
  }
}

/* Image Support */
.cat-card img,
.design-img img,
.designer-img img{
    position:absolute;
    inset:0;
    width:100%;
    height:100%;
    object-fit:cover;
}

.avatar img{
    width:100%;
    height:100%;
    object-fit:cover;
    border-radius:50%;
}

.cat-card h3,
.design-img div{
    position:relative;
    z-index:1;
}
.section {
  padding: 5rem 2rem;
}

.section h2 {
  font-size: clamp(2rem, 4vw, 3rem);
  text-align: center;
  margin-bottom: 3rem;
}

.grid {
  display: grid;
  gap: 1.5rem;
  max-width: 1280px;
  margin: 0 auto;
}

.grid-3 {
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
}

.grid-4 {
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
}

.card {
  border-radius: 1rem;
  overflow: hidden;
  cursor: pointer;
  transition: .3s;
}

.cat-card {
  height: 320px;
  display: flex;
  align-items: flex-end;
  padding: 2rem;
  position: relative;
  transition: .3s;
}

.cat-card:hover {
  transform: translateY(-5px);
}

.cat-card::before {
  content: '';
  position: absolute;
  inset: 0;
  opacity: .9;
  transition: .3s;
}

.cat-card:hover::before {
  opacity: 1;
}

.cat-card h3 {
  position: relative;
  font-size: 2rem;
  z-index: 1;
}

.design-card {
  background: rgba(30, 41, 59, .5);
  border: 1px solid rgba(71, 85, 105, .5);
  transition: .3s;
}

.design-card:hover {
  border-color: rgba(251, 191, 36, .5);
  transform: translateY(-5px);
  box-shadow: 0 20px 40px rgba(0, 0, 0, .3);
}

.design-img {
  height: 280px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 4rem;
  position: relative;
  overflow: hidden;
}

.design-img::before {
  content: '';
  position: absolute;
  inset: 0;
  opacity: .8;
}

.design-info {
  padding: 1.5rem;
}

.design-info h3 {
  margin-bottom: .5rem;
  color: #fbbf24;
}

.rating {
  display: flex;
  align-items: center;
  justify-content: space-between;
  color: #9ca3af;
  font-size: .9rem;
}

.designer-card {
  background: linear-gradient(135deg, rgba(51, 65, 85, .5), rgba(30, 41, 59, .5));
  border: 1px solid rgba(71, 85, 105, .5);
  border-radius: 1rem;
  overflow: hidden;
  transition: .3s;
}

.designer-card:hover {
  border-color: rgba(251, 191, 36, .5);
  box-shadow: 0 20px 40px rgba(251, 191, 36, .2);
  transform: translateY(-5px);
}

.designer-img {
  height: 300px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 6rem;
  position: relative;
  overflow: hidden;
}

.designer-img::before {
  content: '';
  position: absolute;
  inset: 0;
  opacity: .7;
}

.designer-info {
  padding: 1.5rem;
}

.designer-info h3 {
  font-size: 1.5rem;
  margin-bottom: .5rem;
}

.specialty {
  color: #fbbf24;
  font-size: .9rem;
  margin-bottom: 1rem;
}

.exp-rating {
  display: flex;
  justify-content: space-between;
  align-items: center;
  color: #9ca3af;
  font-size: .9rem;
}

.step-card {
  background: rgba(30, 41, 59, .5);
  border: 1px solid rgba(71, 85, 105, .5);
  border-radius: 1rem;
  padding: 2rem;
  position: relative;
  transition: .3s;
}

.step-card:hover {
  border-color: rgba(251, 191, 36, .5);
  transform: translateY(-5px);
}

.step-num {
  position: absolute;
  top: -1rem;
  left: -1rem;
  width: 3rem;
  height: 3rem;
  background: linear-gradient(135deg, #f59e0b, #fb7185);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.2rem;
  font-weight: 700;
  border: 4px solid #0f172a;
}

.icon-box {
  width: 4rem;
  height: 4rem;
  border-radius: 1rem;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 1.5rem;
  font-size: 2rem;
}

.step-card h3 {
  margin-bottom: .5rem;
}

.step-card p {
  color: #9ca3af;
  margin-top: .5rem;
  line-height: 1.5;
}

.testimonial-card {
  background: linear-gradient(135deg, rgba(51, 65, 85, .5), rgba(55, 65, 81, .5));
  border: 1px solid rgba(71, 85, 105, .5);
  border-radius: 1rem;
  padding: 2rem;
  transition: .3s;
}

.testimonial-card:hover {
  border-color: rgba(251, 191, 36, .5);
  transform: translateY(-5px);
}

.stars {
  display: flex;
  gap: .2rem;
  margin: 1rem 0;
  color: #fbbf24;
}

.quote {
  font-size: 3rem;
  color: rgba(251, 191, 36, .5);
  line-height: 1;
}

.testimonial-card p {
  color: #d1d5db;
  line-height: 1.6;
  margin: 1rem 0;
}

.author {
  display: flex;
  align-items: center;
  gap: 1rem;
  margin-top: 1.5rem;
}

.avatar {
  width: 3rem;
  height: 3rem;
  border-radius: 50%;
  background: linear-gradient(135deg, #f59e0b, #fb7185);
  border: 2px solid rgba(251, 191, 36, .5);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.2rem;
}

.author-name {
  font-weight: 500;
}

.author-role {
  color: #9ca3af;
  font-size: .9rem;
}

footer {
  background: #020617;
  border-top: 1px solid rgba(71, 85, 105, .5);
  padding: 3rem 2rem;
}

.footer-content {
  max-width: 1280px;
  margin: 0 auto;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 2rem;
}

.footer h4 {
  color: #fbbf24;
  margin-bottom: 1rem;
}

.footer-links a {
  color: #9ca3af;
  display: block;
  margin-bottom: .5rem;
  transition: .3s;
}

.footer-links a:hover {
  color: #fbbf24;
}

.social {
  display: flex;
  gap: 1rem;
  margin-top: 1rem;
}

.social a {
  width: 2.5rem;
  height: 2.5rem;
  background: #1e293b;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: .3s;
  font-size: 1.2rem;
}

.social a:hover {
  background: #f59e0b;
}

.copyright {
  text-align: center;
  margin-top: 2rem;
  padding-top: 2rem;
  border-top: 1px solid rgba(71, 85, 105, .5);
  color: #6b7280;
}


</style>
</head>
<body>
<header>
<div class="container">
<div class="logo">✨ Designora</div>
<nav><a href="#home">Home</a><a href="#categories">Categories</a><a href="#designs">Designs</a><a href="#about">About</a></nav>
<div class="auth-btns"><a href="login.jsp"><button class="login">Login</button></a><a href="register.jsp"><button class="signup">Sign Up</button></a></div>
</div>
</header>

    <section class="hero" id="home">
<div class="hero-content">
<div class="badge">✨ Premium Fashion Platform</div>
<h1>Discover & Design Your<br><span class="gradient-text">Dream Outfit</span></h1>
<p>Connect with world-class DESIGNERS and bring your fashion vision to life. Browse thousands of custom designs or create your own masterpiece.</p>
<div class="hero-btns"><a href="register.jsp"><button class="cta-primary">Get Started →</button></a><a href="#designs"><button class="cta-secondary">Explore Designs</button></a></div>
</div>
</section>

    <section class="section" style="background:#0f172a" id="categories">
<h2>Explore <span class="gradient-text">Categories</span></h2>
<div class="grid grid-3">
<div class="cat-card">
<img src="https://www.wed2b.com/media/catalog/product/p/e/perdita-aline-wedding-dress-aaliyah-quinn-back.jpg" alt="Bridal">
<h3>Bridal</h3>
</div>

<div class="cat-card">
<img src="https://media.landmarkshops.in/cdn-cgi/image/h=831,w=615,q=85,fit=cover/max-new/1000014653749-Beige-BEIGE-1000014653749_01-2100.jpg" alt="Casual">
<h3>Casual</h3>
</div>

<div class="cat-card">
<img src="https://th.bing.com/th/id/OIP.Skwsl4qUSt5lRpXEsEDZ_gHaJ4?w=208&h=277&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3" alt="Ethnic">
<h3>Ethnic</h3>
</div>

<div class="cat-card">
<img src="data:image/webp;base64,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" alt="Formal">
<h3>Formal</h3>
</div>
</div>
</section>

<section class="section" style="background:linear-gradient(180deg,#0f172a,#1e293b)" id="designs">
<h2>Featured <span class="gradient-text">Designs</span></h2>

<div class="grid grid-3">

<div class="design-card">
<div class="design-img">
<img src="https://th.bing.com/th/id/OIP.VaP9EA1c9LJbmfkhYVxE7gHaHa?w=208&h=208&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3" alt="Luxury Evening Gown">
</div>
<div class="design-info">
<h3>Luxury Evening Gown</h3>
<div class="rating">
<span>by Sophia Laurent</span>
<span>⭐ 4.9</span>
</div>
</div>
</div>

<div class="design-card">
<div class="design-img">
<img src="data:image/webp;base64,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" alt="Elegant Cocktail Dress">
</div>
<div class="design-info">
<h3>Elegant Cocktail Dress</h3>
<div class="rating">
<span>by Isabella Chen</span>
<span>⭐ 5.0</span>
</div>
</div>
</div>

<div class="design-card">
<div class="design-img">
<img src="https://th.bing.com/th/id/OIP.-CYU4u1uytwRlLobGicYmwHaLH?w=204&h=306&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3" alt="Modern Evening Wear">
</div>
<div class="design-info">
<h3>Modern Evening Wear</h3>
<div class="rating">
<span>by Aria Monroe</span>
<span>⭐ 4.9</span>
</div>
</div>
</div>

<div class="design-card">
<div class="design-img">
<img src="https://th.bing.com/th/id/OIP.nPEHV1DASXvkidQ7LAuJ9QHaRf?w=148&h=349&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3" alt="Party Outfit">
</div>
<div class="design-info">
<h3>Party Outfit</h3>
<div class="rating">
<span>by Sophia Laurent</span>
<span>⭐ 4.9</span>
</div>
</div>
</div>

</div>
</section>

<section class="section" style="background:linear-gradient(180deg,#1e293b,#0f172a)" id = "works">
<h2>How It <span class="gradient-text">Works</span></h2>
<div class="grid grid-4">
<div class="step-card"><div class="step-num">1</div><div class="icon-box" style="background:linear-gradient(135deg,#3b82f6,#06b6d4)">🔍</div><h3>Browse Designs</h3><p>Explore thousands of custom designs from talented DESIGNERS worldwide</p></div>
<div class="step-card"><div class="step-num">2</div><div class="icon-box" style="background:linear-gradient(135deg,#a855f7,#ec4899)">👤</div><h3>Select Designer</h3><p>Choose the perfect designer based on their portfolio and expertise</p></div>
<div class="step-card"><div class="step-num">3</div><div class="icon-box" style="background:linear-gradient(135deg,#f59e0b,#f97316)">🎨</div><h3>Customize</h3><p>Work closely with your designer to customize every detail</p></div>
<div class="step-card"><div class="step-num">4</div><div class="icon-box" style="background:linear-gradient(135deg,#10b981,#059669)">✓</div><h3>Confirm</h3><p>Review, approve, and receive your dream outfit at your doorstep</p></div>
</div>
</section>

<section class="section" style="background:#0f172a">
<h2>What Our <span class="gradient-text">Clients Say</span></h2>
<div class="grid grid-3">
<div class="testimonial-card"><div class="quote">"</div><div class="stars">⭐⭐⭐⭐⭐</div><p>Designora made my dream wedding dress a reality! Working with Isabella was an absolute pleasure. Every detail was perfect.</p><div class="author"><div class="avatar">E</div><div><div class="author-name">Emma Rodriguez</div><div class="author-role">Bride</div></div></div></div>
<div class="testimonial-card"><div class="quote">"</div><div class="stars">⭐⭐⭐⭐⭐</div><p>The quality and attention to detail exceeded all my expectations. Sophia Laurent created a stunning evening outfit that turned heads.</p><div class="author"><div class="avatar">M</div><div><div class="author-name">Michael Chen</div><div class="author-role">Fashion Enthusiast</div></div></div></div>
<div class="testimonial-card"><div class="quote">"</div><div class="stars">⭐⭐⭐⭐⭐</div><p>As someone who values both style and professionalism, Designora connected me with the perfect designer. The results are exceptional.</p><div class="author"><div class="avatar">P</div><div><div class="author-name">Priya Sharma</div><div class="author-role">Corporate Executive</div></div></div></div>
</div>
</section>

    <footer id="about">
<div class="footer-content">
<div><div class="logo" style="margin-bottom:1rem">✨ Designora</div><p style="color:#9ca3af;margin-bottom:1rem">Your premier destination for custom fashion design. Connecting talented DESIGNERS with fashion enthusiasts worldwide.</p><div class="social"><a href="#">📘</a><a href="#">📷</a><a href="#">🐦</a><a href="#">💼</a></div></div>
<div class="footer-links"><h4>Quick Links</h4><a href="#about">About Us</a><a href="#categories">Categories</a><a href="#designs">Designs</a><a href="#works">How It Works</a></div>
<div class="footer-links"><h4>Support</h4><a href="#">Contact Us</a><a href="#">FAQs</a><a href="#">Privacy Policy</a><a href="#">Terms of Service</a></div>
</div>
<div class="copyright">© 2026 Designora. All rights reserved. Crafted with passion for fashion enthusiasts.</div>
</footer>
</body>
</html>
