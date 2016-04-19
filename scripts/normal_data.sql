-- DROP TABLE normal_car_makers;
CREATE TABLE IF NOT EXISTS normal_car_makers
(
  id SERIAL PRIMARY KEY,
  make_code varchar(125) NOT NULL,
  make_title varchar(125) NOT NULL
);

-- DROP TABLE normal_car_models;
CREATE TABLE IF NOT EXISTS normal_car_models
(
  id SERIAL PRIMARY KEY,
  model_code varchar(125) NOT NULL,
  model_title varchar(125) NOT NULL,
  normal_car_maker_id integer REFERENCES normal_car_makers
  -- normal_car_year_id integer REFERENCES normal_car_years;
);

-- DROP TABLE normal_car_years;
CREATE TABLE IF NOT EXISTS normal_car_years
(
  id SERIAL PRIMARY KEY,
  year integer NOT NULL,
  normal_car_model_id integer REFERENCES  normal_car_models
);

INSERT INTO normal_car_makers (make_code, make_title)
SELECT DISTINCT make_code, make_title
FROM car_models;

--
ALTER TABLE car_models ADD COLUMN car_makes_id integer;
UPDATE car_models SET car_makes_id = (SELECT id FROM normal_car_makers WHERE car_models.make_code = normal_car_makers.make_code AND car_models.make_title = normal_car_makers.make_title);

INSERT INTO normal_car_models (model_code, model_title, normal_car_maker_id)
SELECT DISTINCT model_code, model_title, car_makes_id
FROM car_models;

ALTER TABLE car_models DROP COLUMN car_makes_id;

--
ALTER TABLE car_models ADD COLUMN car_models_id integer;
UPDATE car_models SET car_models_id = (SELECT id from normal_car_models WHERE car_models.model_code = normal_car_models.model_code AND car_models.model_title = normal_car_models.model_title);

INSERT INTO normal_car_years (year, normal_car_model_id)
SELECT DISTINCT year, car_models_id
FROM car_models;

ALTER TABLE car_models DROP COLUMN car_models_id;

SELECT make_title FROM normal_car_makers;
SELECT model_title FROM normal_car_models INNER JOIN normal_car_makers ON normal_car_models.normal_car_maker_id = normal_car_makers.id WHERE make_code = 'VOLKS';

SELECT * FROM normal_car_years WHERE year BETWEEN 2010 AND 2015;



