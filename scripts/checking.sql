
--customer

SELECT COUNT(*) FROM (
    SELECT customer_country FROM mock_data
    UNION 
    SELECT seller_country FROM mock_data
    UNION
    SELECT store_country FROM mock_data
    UNION 
    SELECT supplier_country FROM mock_data
);


SELECT COUNT(*) FROM mock_data
WHERE 	customer_country IS NULL OR
		customer_first_name IS NULL OR 
		customer_last_name IS NULL OR
		customer_age IS NULL OR 
		customer_email IS NULL OR 
		customer_country IS NULL;


SELECT customer_email AS email, COUNT(*) FROM mock_data
GROUP BY email
HAVING COUNT(*) > 1;


--pet 


SELECT COUNT(*) FROM mock_data
WHERE   customer_pet_type IS NULL OR 
        customer_pet_name IS NULL OR 
        customer_pet_breed IS NULL;


SELECT customer_pet_type, COUNT(DISTINCT customer_pet_breed) FROM mock_data
GROUP BY customer_pet_type;


--seller


SELECT COUNT(*) FROM mock_data
WHERE 	seller_country IS NULL OR
		seller_first_name IS NULL OR 
		seller_last_name IS NULL OR
		seller_email IS NULL OR 
		seller_country IS NULL;


SELECT seller_email AS email, COUNT(*) FROM mock_data
GROUP BY email
HAVING COUNT(*) > 1;


--store


SELECT COUNT(*) FROM mock_data md 
WHERE   store_name IS NULL OR 
        store_location IS NULL OR 
        store_city  IS NULL OR 
        store_country IS NULL OR 
        store_phone IS NULL OR 
        store_email IS NULL;


SELECT store_email AS email, COUNT(*) FROM mock_data
GROUP BY email
HAVING COUNT(*) > 1;


SELECT store_name, COUNT(*) FROM mock_data
GROUP BY store_name
HAVING COUNT(*) > 1;


SELECT COUNT(DISTINCT store_state) FROM mock_data;


SELECT COUNT(*) FROM (
    SELECT store_city AS city, store_country AS country FROM mock_data 
    UNION 
    SELECT supplier_city AS city, supplier_country AS country FROM mock_data 
);


SELECT  COUNT(*) FROM (
    SELECT store_city AS city FROM mock_data 
    UNION
    SELECT supplier_city AS city FROM mock_data 
);


--supplier


SELECT COUNT(*) FROM mock_data 
WHERE   supplier_name IS NULL OR 
        supplier_contact IS NULL OR 
        supplier_email IS NULL OR 
        supplier_phone IS NULL OR 
        supplier_address IS NULL OR 
        supplier_city IS NULL OR 
        supplier_country IS NULL;


SELECT supplier_email, COUNT(*) FROM mock_data
GROUP BY supplier_email
HAVING COUNT(*) > 1;


--product


SELECT product_name, product_category, COUNT(*) FROM mock_data
GROUP BY product_name, product_category
HAVING  COUNT(*) > 1;


SELECT COUNT(DISTINCT product_category) FROM mock_data;


SELECT COUNT(DISTINCT product_brand) FROM mock_data;


SELECT COUNT(DISTINCT product_color) FROM mock_data;


SELECT COUNT(DISTINCT product_size) FROM mock_data;


SELECT COUNT(DISTINCT product_material) FROM mock_data;


SELECT COUNT(*) FROM mock_data
WHERE product_name IS NULL OR 
product_category IS NULL OR 
product_price IS NULL OR 
product_quantity IS NULL OR 
product_weight  IS NULL OR 
product_color  IS NULL OR 
product_size IS NULL OR 
product_brand  IS NULL OR 
product_material  IS NULL OR 
product_description IS NULL OR 
product_rating IS NULL OR 
product_reviews  IS NULL OR 
product_release_date IS NULL OR 
product_expiry_date IS NULL;


--sale


SELECT COUNT(*) FROM mock_data md 
WHERE   sale_date IS NULL OR 
        sale_quantity IS NULL OR 
        sale_total_price IS NULL;