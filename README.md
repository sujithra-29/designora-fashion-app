# ✨ Designora – Fashion Design Ordering System

A full-stack web-based fashion design ordering system built using 
JSP, Java Servlets, JDBC, and Apache Derby. Users can explore premium 
fashion designs, add items to cart, and place orders through a seamless 
e-commerce workflow with role-based access for Users, Designers, and Admins.

---

## 🚀 Features

### 👤 User Module
- Registration, login, and session-based authentication
- Browse, search, and filter fashion designs by category
- View detailed design information
- Add to cart and place single or multiple orders
- View order history and status

### 👨‍🎨 Designer Module
- Designer login and dashboard
- View and track received orders
- Update order progress and status

### 🛠️ Admin Module
- Admin authentication
- Monitor and manage users, designs, and orders

---

## 🛒 Order Flow
Login → Browse Designs → Add to Cart / Buy Now → 
Order Confirmation → Place Order → Stored in Database → User Dashboard

---

## 🖥️ Technologies Used

| Layer | Technology |
|---|---|
| Frontend | HTML, CSS, JavaScript, JSP |
| Backend | Java, JSP, JDBC |
| Database | Apache Derby |
| Server | GlassFish (NetBeans) |

---

## 🗄️ Database Schema

### Users
| Field | Description |
|---|---|
| user_id | Primary Key |
| full_name | User's full name |
| email | Login email |
| phone | Contact number |
| password | Account password |
| role | user / designer / admin |
| is_active | Account status |

### Designs
| Field | Description |
|---|---|
| design_id | Primary Key |
| name | Design name |
| designer_name | Creator name |
| image_url | Design image |
| category | Design category |
| material | Fabric/material |
| size | Available size |
| color | Design color |
| price | Price |

### Cart
| Field | Description |
|---|---|
| cart_id | Primary Key |
| user_id | FK → Users |
| design_id | FK → Designs |
| quantity | Number of items |

### Orders
| Field | Description |
|---|---|
| order_id | Primary Key |
| user_id | FK → Users |
| design_id | FK → Designs |
| quantity | Items ordered |
| price | Total price |
| order_date | Date of order |
| status | Order status |

---

## 📂 Project Structure
Designora/
├── login.jsp
├── register.jsp
├── user-dashboard.jsp
├── view-designs.jsp
├── view-cart.jsp
├── order-confirmation.jsp
├── place-order.jsp
├── cart-handler.jsp
├── update-order-status.jsp
├── admin-dashboard.jsp
├── designer-dashboard.jsp
├── config.jsp
└── logout.jsp

## ⚙️ Setup Instructions

### 1. Clone Repository
git clone https://github.com/sujithra-29/designora-fashion-app

### 2. Configure Database
- Database Name: designora
- Username: app
- Password: app
- Update connection details in config.jsp

### 3. Run Application
1. Open project in NetBeans
2. Configure GlassFish Server
3. Deploy the project
4. Open: http://localhost:8080/Designora

---

## 💡 Key Concepts Implemented
- CRUD Operations
- JDBC Database Connectivity
- SQL Joins and Queries
- Session Management
- Dynamic JSP Rendering
- Role-Based Authentication (User / Designer / Admin)
- Real-world E-commerce Order Workflow

---

## 🔐 Security Features
- Session-based authentication
- Role-based login and page access control
- Input validation
- Restricted access to protected pages

---

## 🚀 Future Enhancements
- Online payment integration
- Email order confirmation
- Wishlist functionality
- Advanced product recommendations
- Secure password encryption (BCrypt)

---

## 👩‍💻 Author
**Sujithra S**  
BCA Student | Stella Maris College, Chennai  
