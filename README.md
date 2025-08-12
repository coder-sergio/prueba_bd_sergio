# 📚 Library Management System

A simple and efficient library management system built with Node.js, Express, and Postgres.

## 🚀 Features

1. -Total paid by each client
"As a system administrator, I need to know how much each client has paid in total so I can track revenue and verify overall balances."
2. Outstanding invoices with client and associated transaction information
"As a financial manager, I need to identify invoices that have not yet been fully paid, along with the client name and corresponding transaction, to manage collections or follow-up."
3. List of transactions by platform
"As an analyst, I need to be able to see all transactions made from a specific platform (such as Nequi or Daviplata), including which client they belong to and which invoice they are paying."

## 🛠️ Technologies

- Backend: Node.js + Express
- Database: Postgres
- Frontend: HTML5, CSS3, JavaScript
- UI Framework: Bootstrap 5
- Data Parsing: CSV Parser

## 📁 Project Structure

```
library/
├── docs/                  # Documentation & DB scripts
├── app/                   # Frontend assets
│   ├── css/
│   └── js/
├── server/               # Backend logic
│   ├── db_connection.js
│   ├── index.js
│   ├── data/
│   └── seeders/
└── index.html           # Entry point
```

## ⚙️ Setup

1. Clone repository:
```bash
git clone https://github.com/username/library.git
cd library
```

2. Install dependencies:
```bash
npm install
npm i pg
npm i dotenv
npm i csv-parser
```

3. Configure environment:
```env
    database:"pd_sergio_bonilla_manglar",
    host:"localhost",
    port:5432,
    user:"sergio",
    password:"Qwe.123*"
```

4. Start server:
```bash
node server/index.js
```

## 💾 Database Seeding

Load initial data:
```bash
node server/seeders/run_seeders.js
```

## 📖 Usage

1. Open browser to `http://localhost:3000`


## 📝 License

GNU General Public License v3.0

## 👥 Contributing

1. Fork repository
2. Create feature branch
3. Commit changes
4. Push to branch



# Billing & Transactions Management API

## 📌 Overview
This project is a **Node.js + Express API** connected to a **PostgreSQL** database that manages clients, billings, and transactions.  
It includes **CRUD endpoints** for each entity and supports **advanced queries** for reporting.  
The database is seeded automatically from CSV files.

---

## 🗂 Database Structure
The system uses three related tables:

1. **`user`**  
   Stores client information.  
   - `id_user` (PK, auto-generated)  
   - `name`, `identification`, `adress`, `email`, `phone`  

2. **`billing`**  
   Stores billing records linked to users.  
   - `id_billing` (PK)  
   - `id_user` (FK → user)  
   - `billing_period`, `invoiced_amount`  

3. **`transaction`**  
   Stores payment transactions linked to billings.  
   - `id_transaction` (PK)  
   - `id_billing` (FK → billing)  
   - `date_hour_transaction`, `transaction_amount`, `state_transaction`, `type_transaction`, `plataform`, `amount_paid`  

---

## 🚀 Features
- **CRUD Operations**:
  - Create, Read, Update, Delete for Users, Billings, and Transactions.
- **Advanced Reports (Postman)**:
  1. **Total paid per client**  
  2. **Pending invoices with client & transaction details**  
  3. **Transactions by payment platform**  
- **CSV Seeder**:
  - Loads initial data from CSV files into the database.
  - Automatically handles duplicates and foreign keys.
- **Data Validation**:
  - Avoids inserting invalid IDs.
  - Prevents duplicate records using `ON CONFLICT`.

---
