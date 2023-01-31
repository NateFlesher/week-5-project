CREATE TABLE "Customer" (
  customer_id SERIAL,
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  phone VARCHAR(15),
  PRIMARY KEY (customer_id)
);

CREATE TABLE "Car" (
  car_id SERIAL,
  make VARCHAR(100),
  model VARCHAR(100),
  price NUMERIC(9,2),
  was_purchased BOOLEAN,
  customer_id INTEGER,
  PRIMARY KEY (car_id)
);

CREATE TABLE "Invoice" (
  invoice_id SERIAL,
  car_id INTEGER,
  salesperson_id INTEGER,
  date DATE,
  PRIMARY KEY (invoice_id)
);

CREATE TABLE "Salesperson" (
  salesperson_id SERIAL,
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  PRIMARY KEY (salesperson_id)
);

CREATE TABLE "Service_History" (
  service_id SERIAL,
  car_id INTEGER,
  date DATE,
  PRIMARY KEY (service_id)
);

CREATE TABLE "Service_Ticket" (
  ticket_id SERIAL,
  service_id INTEGER,
  cost NUMERIC(9,2),
  task VARCHAR(200),
  PRIMARY KEY (ticket_id)
);

CREATE TABLE "Mechanic" (
  mechanic_id SERIAL,
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  PRIMARY KEY (mechanic_id)
);

CREATE TABLE "Maintenance_History" (
  maint_id SERIAL,
  ticket_id INTEGER,
  mechanic_id INTEGER,
  PRIMARY KEY (maint_id),
  FOREIGN KEY (ticket_id) REFERENCES "Service_Ticket"(ticket_id),
  FOREIGN KEY (mechanic_id) REFERENCES "Mechanic"(mechanic_id)
);

INSERT INTO "Customer"(
	"first_name",
	"last_name",
	"phone"
) VALUES(
	'Roy',
	'Benson',
	'123456789'
);

SELECT *
FROM "Customer";

ALTER TABLE "Car"
ADD is_serviced BOOLEAN;

INSERT INTO "Car"(
	"make",
	"model",
	"is_serviced",
	"was_purchased",
	"customer_id"
) VALUES(
	'Nissan',
	'370z',
	TRUE,
	FALSE,
	1
	
);

INSERT INTO "Car"(
	"make",
	"model",
	"price",
	"was_purchased",
	"customer_id"
) VALUES(
	'Nissan',
	'Altima',
	25000,
	TRUE,
	TRUE,
	1
	
);

SELECT *
FROM "Car";



INSERT INTO "Salesperson"(
	"first_name",
	"last_name"
) VALUES(
	'Harry',
	'Jenson'
	
);

SELECT *
FROM "Salesperson";

INSERT INTO "Invoice"(
	"car_id",
	"salesperson_id",
	"date"
) VALUES(
	2,
	1,
	'2022/1/29'
	
);

SELECT *
FROM "Invoice";

INSERT INTO "Mechanic"(
	"first_name",
	"last_name"
) VALUES(
	'Larry',
	'Crenson'
	
);

SELECT *
FROM "Mechanic";

INSERT INTO "Service_History"(
	"car_id",
	"date"
) VALUES(
	2,
	'2023/1/29'
	
);

SELECT *
FROM "Service_History";

INSERT INTO "Service_Ticket"(
	"service_id",
	"cost",
	"task"
) VALUES(
	1,
	80,
	'Oil Change'
	
);

SELECT *
FROM "Service_Ticket";

INSERT INTO "Maintenance_History"(
	"ticket_id",
	"mechanic_id"
) VALUES(
	1,
	1
	
);

SELECT *
FROM "Maintenance_History"

CREATE OR REPLACE PROCEDURE is_car_serviced()
	LANGUAGE plpgsql
	AS $$
	BEGIN
		
		UPDATE "Car"
		SET is_serviced = true
		WHERE car_id IN(
			SELECT car_id
			FROM "Service_History");
		UPDATE "Car"
		SET is_serviced = false
		WHERE car_id NOT IN(
			SELECT car_id
			FROM "Service_History");
			COMMIT;
		END;
	$$
	
CALL is_car_serviced()

SELECT *
FROM "Car";