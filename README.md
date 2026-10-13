# E-Commerce Database (Neon PostgreSQL)

## Student
- **Name:** Ahmad Tahat
- **University ID:** 20220336

## Project description
A relational database for a startup online store that sells tech devices and accessories (laptops, phones, headphones, keyboards, chargers, smart watches and gaming gear). The database keeps customers, categories, products, orders, order details and payments in one place, and uses constraints to prevent duplicate or invalid data.

## Tables

| Table | Purpose |
|---|---|
| `users` | Customer and admin accounts (unique email, role, active flag). |
| `categories` | Product categories (unique name). |
| `products` | Items for sale, with price, stock and a unique SKU. Each product belongs to one category. |
| `orders` | Orders placed by users, with status, total and shipping address. |
| `order_items` | The lines of an order: product, quantity and the unit price at the time of purchase. `subtotal` is a generated column (`quantity * unit_price`). |
| `payments` | The payment for an order: method, status, amount and transaction reference. |

## Relationships
- `users` → `orders` (one-to-many): one user can place many orders.
- `categories` → `products` (one-to-many): one category contains many products.
- `orders` → `order_items` (one-to-many): one order contains many items.
- `products` → `order_items` (one-to-many): one product can appear in many orders.
- `orders` → `payments` (one-to-one): each order has at most one payment (`payments.order_id` is `UNIQUE`).

`order_items` links orders and products (a many-to-many relationship) and stores the price at order time, so old invoices stay correct if a product price changes.

## Key constraints
- **UNIQUE:** `users.email`, `categories.name`, `products.sku`, `payments.transaction_reference`, `payments.order_id`, and the pair `(order_items.order_id, order_items.product_id)`.
- **CHECK:** price > 0, stock >= 0, quantity > 0, unit price > 0, payment amount > 0, total_amount >= 0, plus fixed lists for user role, order status, payment method and payment status.
- **NOT NULL / DEFAULT:** required fields, `is_active = TRUE`, `role = 'customer'`, `status = 'pending'`, and automatic `created_at` / `updated_at`.
- **FOREIGN KEY:** every foreign key references an existing row; deleting a category that still has products is blocked. Deleting an order also deletes its items and payment (`ON DELETE CASCADE`).

## How to run
Run the files in this order on a new, empty database (Neon SQL Editor):

1. `01_create_tables.sql` creates the 6 tables.
2. `02_insert_sample_data.sql` inserts the sample data.

Run each file once. The files do not depend on any manual changes.

## Sample data

| Table | Rows |
|---|---|
| users | 8 (1 admin, 7 customers, 1 customer with no orders) |
| categories | 5 |
| products | 20 (2 out of stock) |
| orders | 10 (all statuses, including a cancelled order) |
| order_items | 25 |
| payments | 8 (paid, pending, failed, refunded; all 4 payment methods; 2 orders unpaid) |

Every order's `total_amount` equals the sum of its items.

## Integrity tests
I ran 10 invalid statements and all of them were rejected by the database (screenshots are in `screenshots/`):

| # | Test | Constraint that blocked it |
|---|---|---|
| 1 | Duplicate email | UNIQUE (`users_email_key`) |
| 2 | Negative price | CHECK (`products_price_check`) |
| 3 | Negative stock | CHECK (`products_stock_quantity_check`) |
| 4 | Order for a missing user | FOREIGN KEY (`orders_user_id_fkey`) |
| 5 | Item for a missing order | FOREIGN KEY (`order_items_order_id_fkey`) |
| 6 | Quantity of zero | CHECK (`order_items_quantity_check`) |
| 7 | Same product twice in one order | Composite UNIQUE (`order_items_order_id_product_id_key`) |
| 8 | Invalid order status | CHECK (`orders_status_check`) |
| 9 | Negative payment amount | CHECK (`payments_amount_check`) |
| 10 | Deleting a category that has products | FOREIGN KEY (`products_category_id_fkey`) |

## Tools
- Neon (PostgreSQL) and its SQL Editor
- ERDPlus for the ERD

## Problems and solutions
- **Syntax errors in the table script:** a missing comma and an extra comma, a typo in `ON DELETE CASCADE`, and a misspelled column (`stocks_quantity`). I fixed them one by one by re-running the file on a clean database.
- **Uniqueness in `order_items`:** marking `order_id` and `product_id` as unique separately would allow only one item per order. I used one composite `UNIQUE (order_id, product_id)` instead.
- **Foreign keys in the sample data:** instead of typing ids by hand, I used `INSERT ... SELECT` with joins to look up ids by unique values (category name, user email, product SKU, order creation time). Text dates needed `::timestamp` so PostgreSQL accepted them.

## Security
No password or Neon connection string is included in this project or its files.

## Folder structure
```
ahmad_tahat_ecommerce_database/
├── README.md
├── 01_create_tables.sql
├── 02_insert_sample_data.sql
├── erd.png
└── screenshots/
```
