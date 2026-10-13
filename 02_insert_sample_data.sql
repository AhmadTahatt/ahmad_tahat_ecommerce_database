  INSERT INTO users (full_name, email, phone, password_hash , role, is_active, created_at) VALUES
('Omar Haddad',   'omar.haddad@batstore.jo',  '0791000001', 'hash_omar_001',   'admin',    TRUE,  '2026-01-05 09:00:00'),
('Lina Khoury',   'lina.khoury@example.com',  '0792000002', 'hash_lina_002',   'customer', TRUE,  '2026-01-18 11:30:00'),
('Yousef Nasser', 'yousef.nasser@example.com','0793000003', 'hash_yousef_003', 'customer', TRUE,  '2026-02-02 14:15:00'),
('Rana Al-Masri', 'rana.masri@example.com',   '0794000004', 'hash_rana_004',   'customer', TRUE,  '2026-02-20 16:45:00'),
('Khaled Mansour','khaled.mansour@example.com','0795000005','hash_khaled_005', 'customer', TRUE,  '2026-03-10 10:20:00'),
('Dana Salameh',  'dana.salameh@example.com', '0796000006', 'hash_dana_006',   'customer', TRUE,  '2026-04-01 13:00:00'),
('Tariq Abu Zaid','tariq.abuzaid@example.com','0797000007', 'hash_tariq_007',  'customer', TRUE,  '2026-05-12 08:40:00'),
('Sara Qasem',    'sara.qasem@example.com',   '0798000008', 'hash_sara_008',   'customer', TRUE,  '2026-06-03 17:10:00');


  INSERT INTO categories (name, description) VALUES
('Computers',   'Laptops, monitors and tablets'),
('Phones',      'Smartphones, smart watches and phone cases'),
('Accessories', 'Keyboards, mice, chargers and cables'),
('Audio',       'Headphones, microphones and speakers'),
('Gaming',      'Controllers, gaming headsets and mouse pads');


  INSERT INTO products (category_id, name, description, price, stock_quantity, sku)
SELECT  c.id, p.name, p.description, p.price, p.stock_quantity, p.sku
FROM(VALUES
     ('Computers',   'Lenovo ThinkPad E14 Laptop',       '14" business laptop, 16GB RAM, 512GB SSD',  649.00, 15,  'CMP-001'),
  ('Computers',   'Dell P2422H 24" Monitor',          '24-inch Full HD IPS monitor',               169.00, 30,  'CMP-002'),
  ('Computers',   'HP Pavilion 15 Laptop',            '15.6" laptop, 16GB RAM, 512GB SSD',         549.00, 12,  'CMP-003'),
  ('Computers',   'Samsung Galaxy Tab S9 FE',         '10.9" tablet, 128GB',                       429.00, 0,   'CMP-004'),
  ('Phones',      'iPhone 15 128GB',                  'Apple smartphone, 128GB',                   899.00, 20,  'PHN-001'),
  ('Phones',      'Samsung Galaxy S24 256GB',         'Android smartphone, 256GB',                 799.00, 25,  'PHN-002'),
  ('Phones',      'Apple Watch SE',                   'Smart watch with GPS',                      249.00, 18,  'PHN-003'),
  ('Phones',      'Spigen Protective Case',           'Shockproof phone case',                      19.99, 100, 'PHN-004'),
  ('Accessories', 'Logitech K380 Keyboard',           'Compact Bluetooth keyboard',                 39.99, 60,  'ACC-001'),
  ('Accessories', 'Logitech MX Master 3S Mouse',      'Wireless ergonomic mouse',                   99.00, 35,  'ACC-002'),
  ('Accessories', 'Anker 65W USB-C Charger',          'Fast GaN wall charger',                      34.50, 80,  'ACC-003'),
  ('Accessories', 'USB-C to Lightning Cable 1m',      'Braided charging cable',                     12.99, 150, 'ACC-004'),
  ('Audio',       'Sony WH-1000XM5 Headphones',       'Wireless noise-cancelling headphones',      349.00, 14,  'AUD-001'),
  ('Audio',       'Blue Yeti USB Microphone',         'USB condenser microphone',                  129.00, 10,  'AUD-002'),
  ('Audio',       'JBL Flip 6 Speaker',               'Portable waterproof Bluetooth speaker',     119.00, 0,   'AUD-003'),
  ('Audio',       'Apple AirPods Pro 2',              'Wireless earbuds with noise cancellation',  249.00, 22,  'AUD-004'),
  ('Gaming',      'PlayStation DualSense Controller', 'Wireless controller for PS5',                69.99, 40,  'GAM-001'),
  ('Gaming',      'Razer BlackShark V2 Headset',      'Wired gaming headset',                       99.99, 28,  'GAM-002'),
  ('Gaming',      'SteelSeries QcK Mouse Pad',        'Large cloth gaming mouse pad',               19.99, 75,  'GAM-003'),
  ('Gaming',      'Xbox Wireless Controller',         'Wireless controller for Xbox and PC',        64.99, 33,  'GAM-004')
    
) AS p(category_name, name, description, price, stock_quantity, sku)
JOIN categories c on c.name = p.category_name;



INSERT INTO orders( user_id, status, total_amount, shipping_address, created_at)
SELECT u.id, o.status, o.total_amount, o.shipping_address, o.created_at::TIMESTAMP FROM (VALUES
  ('lina.khoury@example.com',    'delivered',  787.99, 'Abdoun, Amman, Jordan',            '2026-03-12 10:00:00'),
  ('yousef.nasser@example.com',  'delivered',  968.98, 'Sweifieh, Amman, Jordan',          '2026-04-05 12:30:00'),
  ('rana.masri@example.com',     'shipped',    409.48, 'Rabieh, Amman, Jordan',            '2026-05-20 09:15:00'),
  ('khaled.mansour@example.com', 'cancelled',  818.99, 'University Street, Irbid, Jordan', '2026-06-02 18:20:00'),
  ('lina.khoury@example.com',    'processing', 259.96, 'Abdoun, Amman, Jordan',            '2026-07-14 13:45:00'),
  ('dana.salameh@example.com',   'pending',    588.99, 'Al-Hussein Street, Zarqa, Jordan', '2026-08-08 20:10:00'),
  ('tariq.abuzaid@example.com',  'confirmed',  510.99, 'Aqaba Marina Road, Aqaba, Jordan', '2026-08-25 11:00:00'),
  ('yousef.nasser@example.com',  'delivered',  233.97, 'Sweifieh, Amman, Jordan',          '2026-09-03 15:25:00'),
  ('rana.masri@example.com',     'pending',    437.00, 'Rabieh, Amman, Jordan',            '2026-09-18 19:00:00'),
  ('khaled.mansour@example.com', 'delivered',  318.00, 'University Street, Irbid, Jordan', '2026-10-01 09:30:00')
  

)AS o(email, status, total_amount, shipping_Address, created_at) join users u on u.email=o.email;



INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT o.id, p.id, v.quantity, v.unit_price
FROM (VALUES
  -- Order 1 = 787.99
  ('2026-03-12 10:00:00', 'CMP-001', 1, 649.00),
  ('2026-03-12 10:00:00', 'ACC-001', 1, 39.99),
  ('2026-03-12 10:00:00', 'ACC-002', 1, 99.00),
  -- Order 2 = 968.98 (PHN-001 uses the old price 929.00)
  ('2026-04-05 12:30:00', 'PHN-001', 1, 929.00),
  ('2026-04-05 12:30:00', 'PHN-004', 2, 19.99),
  -- Order 3 = 409.48
  ('2026-05-20 09:15:00', 'AUD-001', 1, 349.00),
  ('2026-05-20 09:15:00', 'ACC-003', 1, 34.50),
  ('2026-05-20 09:15:00', 'ACC-004', 2, 12.99),
  -- Order 4 = 818.99
  ('2026-06-02 18:20:00', 'PHN-002', 1, 799.00),
  ('2026-06-02 18:20:00', 'PHN-004', 1, 19.99),
  -- Order 5 = 259.96
  ('2026-07-14 13:45:00', 'GAM-001', 2, 69.99),
  ('2026-07-14 13:45:00', 'GAM-002', 1, 99.99),
  ('2026-07-14 13:45:00', 'GAM-003', 1, 19.99),
  -- Order 6 = 588.99
  ('2026-08-08 20:10:00', 'CMP-003', 1, 549.00),
  ('2026-08-08 20:10:00', 'ACC-001', 1, 39.99),
  -- Order 7 = 510.99
  ('2026-08-25 11:00:00', 'PHN-003', 1, 249.00),
  ('2026-08-25 11:00:00', 'AUD-004', 1, 249.00),
  ('2026-08-25 11:00:00', 'ACC-004', 1, 12.99),
  -- Order 8 = 233.97
  ('2026-09-03 15:25:00', 'AUD-002', 1, 129.00),
  ('2026-09-03 15:25:00', 'GAM-004', 1, 64.99),
  ('2026-09-03 15:25:00', 'GAM-003', 2, 19.99),
  -- Order 9 = 437.00
  ('2026-09-18 19:00:00', 'CMP-002', 2, 169.00),
  ('2026-09-18 19:00:00', 'ACC-002', 1, 99.00),
  -- Order 10 = 318.00
  ('2026-10-01 09:30:00', 'AUD-004', 1, 249.00),
  ('2026-10-01 09:30:00', 'ACC-003', 2, 34.50)
) AS v(order_created_at, sku, quantity, unit_price)
JOIN orders   o ON o.created_at = v.order_created_at::timestamp
JOIN products p ON p.sku = v.sku;



INSERT INTO payments (order_id, payment_method, payment_status, amount, transaction_reference, paid_at)
SELECT o.id, v.payment_method, v.payment_status, v.amount, v.transaction_reference, v.paid_at::TIMESTAMP
FROM (VALUES
  ('2026-03-12 10:00:00', 'card',          'paid',     787.99, 'TXN-20260312-0001', '2026-03-12 10:05:00'),
  ('2026-04-05 12:30:00', 'bank_transfer', 'paid',     968.98, 'TXN-20260405-0002', '2026-04-06 09:00:00'),
  ('2026-05-20 09:15:00', 'wallet',        'paid',     409.48, 'TXN-20260520-0003', '2026-05-20 09:20:00'),
  ('2026-06-02 18:20:00', 'card',          'refunded', 818.99, 'TXN-20260602-0004', '2026-06-02 18:25:00'),
  ('2026-08-25 11:00:00', 'bank_transfer', 'pending',  510.99, 'TXN-20260825-0005', NULL),
  ('2026-09-03 15:25:00', 'cash',          'paid',     233.97, NULL,                '2026-09-06 12:00:00'),
  ('2026-09-18 19:00:00', 'card',          'failed',   437.00, 'TXN-20260918-0006', NULL),
  ('2026-10-01 09:30:00', 'wallet',        'paid',     318.00, 'TXN-20261001-0007', '2026-10-01 09:35:00')
  )AS v(order_created_at, payment_method, payment_status, amount, transaction_reference, paid_at)
JOIN orders o ON o.created_at = v.order_created_at::TIMESTAMP;