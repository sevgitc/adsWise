# 🧱 Campus Advertisement Management System

This is a relational database system designed for managing advertisement postings on a college campus. The project involves the complete database lifecycle — from data modeling and normalization to SQL implementation and querying.

> 🔧 Developed using MySQL as part of a team project.  

---

## 📚 Project Scope

- 📌 ER modeling and EER diagram creation  
- 🔄 Mapping to relational schema  
- 📐 Normalization up to BCNF  
- 🏗️ SQL schema (CREATE, INSERT, DROP)  
- 🔍 Complex SQL queries (JOINs, aggregates, CASE, subqueries, views, updates)  
- 📈 View creation for reporting and business logic

---

## 🛠 Tech Stack

- **SQL** (MySQL)
- **ER Modeling Tools** (draw.io / Lucidchart / hand-drawn diagram)
- **Microsoft Word** (report writing)
- **Team collaboration** using versioned scripts and peer review

---

## 📂 File Structure
```
adsWise/
├── schema/
│   ├── 1_create_tables.sql
│   ├── 2_insert_data.sql
│   ├── 3_drop_tables.sql
│   └── 4_queries.sql
│
├── documentation/
│   └── Project_Report.pdf
│
├── eer_diagram.png
└── README.md
```


---

## 🔗 Key Files

- [`1_create_tables.sql`](schema/1_create_tables.sql): SQL DDL scripts for table creation  
- [`2_insert_data.sql`](schema/2_insert_data.sql): Sample data insertion scripts
- [`3_drop_tables.sql`](schema/3_drop_tables.sql): Sample data insertion scripts  
- [`4_queries.sql`](schema/4_queries.sql): Queries for insights & analysis    
- [`Project_Report.pdf`](documentation/Project_Report.pdf): Full project documentation  
- `eer_diagram.png`: Visual representation of the EER model

---

## 🧠 Sample Queries

Some example queries from the project:

```sql
-- Get quantity of advertisements per day
SELECT Post_Date, COUNT(*) AS NumberOfAnnouncements
FROM Advertisement 
GROUP BY Post_Date;

-- List users who posted in October
SELECT FirstName, LastName, Post_Date
FROM Person
JOIN Advertisement ON Person.MemberPhone = Advertisement.MemberPhone
WHERE MONTHNAME(Post_Date) = 'October';

```
---

## 🧾 Documentation

You can find detailed assumptions, relationship diagrams, normalization explanation, and domain constraints in  
📄 [`Project_Report.pdf`](documentation/Project_Report.pdf)
