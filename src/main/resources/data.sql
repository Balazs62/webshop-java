INSERT INTO products (id, name, description, baseprice) 
VALUES (1, 'Futócipő', 'Profi futócipő aszfaltra', 29900)
ON CONFLICT (id) DO NOTHING;

INSERT INTO products (id, name, description, baseprice) 
VALUES (2, 'Póló', 'Pamut sportpóló', 5900)
ON CONFLICT (id) DO NOTHING;



INSERT INTO product_variants (id, product_id, size, stock_quantity, color) 
VALUES (1, 1, 'S', 10, 'fekete') S
ON CONFLICT (id) DO NOTHING;

INSERT INTO product_variants (id, product_id, size, stock_quantity, color) 
VALUES (2, 1, 'M', 20, 'kék') 
ON CONFLICT (id) DO NOTHING;

INSERT INTO product_variants (id, product_id, size, stock_quantity, color) 
VALUES (3, 1, 'L', 5, 'zöld') 
ON CONFLICT (id) DO NOTHING;

INSERT INTO product_variants (id, product_id, size, stock_quantity, color)
VALUES (1, 2, 38, 10, 'fekete')
ON CONFLICT (id) DO NOTHING;