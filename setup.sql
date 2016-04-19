CREATE USER denormal_user;
CREATE DATABASE denormal_cars OWNER denormal_user;
\i ./scripts/denormal_data.sql

CREATE USER normal_user;
CREATE DATABASE normal_cars OWNER normal_user;

