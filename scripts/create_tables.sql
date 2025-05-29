

--dimensions


CREATE TABLE country (
    id SERIAL PRIMARY KEY,
    country_name VARCHAR(50) UNIQUE NOT NULL
);


CREATE TABLE customer (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    age INTEGER NOT NULL,
    email VARCHAR(100) NOT NULL,
    country_id INTEGER REFERENCES country(id) NOT NULL,
    postal_code VARCHAR(30)
);


CREATE TABLE pet_type (
    id SERIAL PRIMARY KEY,
    pet_type_name VARCHAR(50) UNIQUE NOT NULL
);


CREATE TABLE pet_breed (
    id SERIAL PRIMARY KEY,
    pet_type_id INTEGER REFERENCES pet_type(id) NOT NULL,
    pet_breed_name VARCHAR(50) NOT NULL,
    UNIQUE (pet_type_id, pet_breed_name)
);


CREATE TABLE pet (
    id SERIAL PRIMARY KEY,
    pet_name VARCHAR(50) NOT NULL,
    customer_id INTEGER REFERENCES customer(id) NOT NULL,
    pet_breed_id INTEGER REFERENCES pet_breed(id) NOT NULL,
    UNIQUE (customer_id, pet_breed_id, pet_name)
);


CREATE TABLE seller (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    country_id INTEGER REFERENCES country(id) NOT NULL,
    postal_code VARCHAR(30)
);


CREATE TABLE city (
    id SERIAL PRIMARY KEY,
    country_id INTEGER REFERENCES country(id),
    city_name VARCHAR(50) NOT NULL,
    UNIQUE (country_id, city_name)
);


CREATE TABLE store_state (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL
);


CREATE TABLE store (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    location VARCHAR(50) NOT NULL,
    state VARCHAR(50),
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL,
    state_id INTEGER REFERENCES store_state(id),
    city_id INTEGER REFERENCES city(id) NOT NULL
);


CREATE TABLE supplier (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    contact VARCHAR NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    address VARCHAR(50) NOT NULL,
    city_id INTEGER REFERENCES city(id)
);


CREATE TABLE product_category (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL
);


CREATE TABLE product_brand (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL
);


CREATE TABLE product_color (
    id SERIAL PRIMARY KEY,
    name VARCHAR(30) UNIQUE NOT NULL
);


CREATE TABLE product_size (
    id SERIAL PRIMARY KEY,
    name VARCHAR(30) UNIQUE NOT NULL
);


CREATE TABLE product_material (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL
);


CREATE TABLE product (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    quantity INTEGER NOT NULL,
    weight NUMERIC(10, 2) NOT NULL,
    description TEXT NOT NULL,
    rating NUMERIC(3, 2) NOT NULL,
    reviews INTEGER NOT NULL,
    release_date DATE NOT NULL,
    expiry_date DATE NOT NULL,
    category_id INTEGER REFERENCES product_category(id) NOT NULL,
    brand_id INTEGER REFERENCES product_brand(id) NOT NULL,
    color_id INTEGER REFERENCES product_color(id) NOT NULL,
    size_id INTEGER REFERENCES product_size(id) NOT NULL,
    material_id INTEGER REFERENCES product_material(id) NOT NULL,
    supplier_id INTEGER REFERENCES supplier(id) NOT NULL
);


--facts


CREATE TABLE sale (
    id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    quantity INTEGER NOT NULL,
    total_price NUMERIC(10, 2) NOT NULL,
    customer_pet_id INTEGER REFERENCES pet(id) NOT NULL,
    seller_id INTEGER REFERENCES seller(id) NOT NULL,
    store_id INTEGER REFERENCES store(id) NOT NULL,
    product_id INTEGER REFERENCES product(id) NOT NULL
);