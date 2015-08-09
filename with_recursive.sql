WITH RECURSIVE
  all_prices (id, parent_id, price) AS (
    SELECT p.id, p.parent_id, p.price
    FROM products p
    WHERE p.price is not NULL
    UNION ALL
    SELECT p.id, p.parent_id, pp.price
    FROM products p
    JOIN all_prices pp ON pp.id = p.parent_id 
    WHERE p.price is NULL
)
SELECT * FROM all_prices ORDER BY id;
