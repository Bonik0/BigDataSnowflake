
INSERT INTO country (country_name)
(
    SELECT customer_country FROM mock_data
    UNION 
    SELECT seller_country FROM mock_data
    UNION
    SELECT store_country FROM mock_data
    UNION 
    SELECT supplier_country FROM mock_data
);


INSERT INTO customer (first_name, last_name, age, email, country_id, postal_code)
SELECT 
        md.customer_first_name,
        md.customer_last_name,
        md.customer_age::INTEGER, 
        md.customer_email, 
        c.id,
        md.customer_postal_code
FROM mock_data md
JOIN country c ON c.country_name = md.customer_country;


INSERT INTO pet_type (pet_type_name)
SELECT DISTINCT customer_pet_type FROM mock_data;


INSERT into pet_breed (pet_type_id, pet_breed_name)
SELECT 
        DISTINCT pt.id, md.customer_pet_breed
FROM mock_data md
JOIN pet_type pt ON pt.pet_type_name = md.customer_pet_type;


INSERT INTO pet (pet_name, customer_id, pet_breed_id)
SELECT 
		md.customer_pet_name,
        c.id,
        pd.id
FROM mock_data md
JOIN customer c ON c.email = md.customer_email
JOIN pet_type pt ON pt.pet_type_name = md.customer_pet_type 
JOIN pet_breed pd ON md.customer_pet_breed = pd.pet_breed_name AND pt.id = pd.pet_type_id;


INSERT INTO seller (first_name, last_name, email, country_id, postal_code)
SELECT 
        md.seller_first_name,
        md.seller_last_name,
        md.seller_email, 
        c.id,
        md.seller_postal_code
FROM mock_data md
JOIN country c ON c.country_name = md.seller_country;


INSERT INTO city (country_id, city_name) 
SELECT 
    c.id,
    city.city
FROM (
    SELECT store_city AS city, store_country AS country FROM mock_data 
    UNION 
    SELECT supplier_city AS city, supplier_country AS country FROM mock_data 
) city
JOIN country c ON city.country = c.country_name;


INSERT INTO store_state (name)
SELECT DISTINCT store_state FROM mock_data
WHERE store_state IS NOT NULL;


INSERT INTO store (name, location, phone, email, state_id, city_id)
SELECT 
        md.store_name, 
        md.store_location,
        md.store_phone,
        md.store_email,
        ss.id,
        ci.id
FROM mock_data md
JOIN country c ON c.country_name = md.store_country
JOIN city ci ON ci.city_name = md.store_city AND ci.country_id = c.id
LEFT JOIN store_state ss ON ss.name = md.store_state;


INSERT INTO  supplier (name, contact, email, phone, address, city_id)
SELECT 
        md.supplier_name, 
        md.supplier_contact,
        md.supplier_email,
        md.supplier_phone,
        md.supplier_address,
        ci.id
FROM mock_data md
JOIN country c ON c.country_name = md.supplier_country
JOIN city ci ON ci.city_name = md.supplier_city AND ci.country_id = c.id;
 

INSERT INTO product_category (name)
SELECT DISTINCT product_category FROM mock_data;


INSERT INTO product_brand (name)
SELECT DISTINCT product_brand FROM mock_data;


INSERT INTO product_color (name)
SELECT DISTINCT product_color FROM mock_data;


INSERT INTO product_size (name)
SELECT DISTINCT product_size FROM mock_data;


INSERT INTO product_material (name)
SELECT DISTINCT product_material FROM mock_data;


INSERT INTO product (       
                    name,
                    price,
                    quantity,
                    weight,
                    description,
                    rating,
                    reviews,
                    release_date,
                    expiry_date,
                    category_id,
                    brand_id,
                    color_id,
                    size_id,
                    material_id,
                    supplier_id
    )
SELECT 
        md.product_name,
        md.product_price::NUMERIC(10, 2),
        md.product_quantity::INTEGER,
        md.product_weight::NUMERIC(10, 2),
        md.product_description,
        md.product_rating::NUMERIC(3, 2),
        md.product_reviews::INTEGER,
        md.product_release_date::DATE,
        md.product_expiry_date::DATE,
        pc.id,
        pb.id,
        pcl.id,
        ps.id,
        pm.id,
        s.id
FROM mock_data md
JOIN product_category pc ON pc.name = md.product_category
JOIN product_brand pb ON pb.name = md.product_brand
JOIN product_color pcl ON pcl.name = md.product_color
JOIN product_size ps ON ps.name = md.product_size
JOIN product_material pm ON pm.name = md.product_material
JOIN supplier s ON s.email = md.supplier_email;


INSERT INTO sale (
                    date,
                    quantity,
                    total_price,
                    customer_pet_id,
                    seller_id,
                    store_id,
                    product_id
    )       
SELECT 
        md.sale_date::DATE,
        md.sale_quantity::INTEGER,
        md.sale_total_price::numeric(10, 2),
        p.id,
        sell.id,
        st.id,
        prod.id
FROM mock_data md
JOIN customer cust ON cust.email = md.customer_email
JOIN pet_type pt ON pt.pet_type_name = md.customer_pet_type
JOIN pet_breed pb ON pb.pet_breed_name = md.customer_pet_breed AND pb.pet_type_id = pt.id
JOIN pet p ON p.customer_id = cust.id AND p.pet_breed_id = pb.id AND p.pet_name = md.customer_pet_name
JOIN seller sell ON sell.email = md.seller_email
JOIN store st ON st.email = md.store_email
JOIN supplier supp ON supp.email = md.supplier_email
JOIN product_category pc ON pc.name = md.product_category
JOIN product_brand pbr ON pbr.name = md.product_brand
JOIN product_color pcl ON pcl.name = md.product_color
JOIN product_size ps ON ps.name = md.product_size
JOIN product_material pm ON pm.name = md.product_material
JOIN product prod ON    prod.name = md.product_name AND 
                        prod.category_id = pc.id AND 
                        prod.brand_id = pbr.id AND 
                        prod.color_id = pcl.id AND 
                        prod.size_id = ps.id AND 
                        prod.material_id = pm.id AND 
                        prod.supplier_id = supp.id;