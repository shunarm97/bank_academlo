
-- EL TRABAJO ESTAS HASTA EL FINAL 

create TABLE "clients" (
  "id" serial PRIMARY KEY,
  "first_name" varchar,
  "last_name" varchar,
  "email" varchar,
  "telephone" integer
);

CREATE TABLE "accounts" (
  "id" serial PRIMARY KEY,
  "account_no" integer UNIQUE,
  "client_id" integer,
  "balance" money,
  "type" integer
);

CREATE TABLE "account_types" (
  "id" serial PRIMARY KEY,
  "name" varchar,
  "description" varchar
);

CREATE TABLE "transactions" (
  "id" serial PRIMARY KEY,
  "account_ori" integer,
  "account_des" integer,
  "amount" money,
  "transaction_type" integer,
  "trans_date" timestamp
);

CREATE TABLE "transactions_types" (
  "id" serial PRIMARY KEY,
  "name" varchar,
  "description" varchar
);

ALTER TABLE "transactions" ADD FOREIGN KEY ("account_ori") REFERENCES "accounts" ("id");

ALTER TABLE "transactions" ADD FOREIGN KEY ("account_des") REFERENCES "accounts" ("id");

ALTER TABLE "accounts" ADD FOREIGN KEY ("client_id") REFERENCES "clients" ("id");

ALTER TABLE "accounts" ADD FOREIGN KEY ("type") REFERENCES "account_types" ("id");

ALTER TABLE "transactions" ADD FOREIGN KEY ("transaction_type") REFERENCES "transactions_types" ("id");

-- Agregar clientes sobre la DB
insert into clients(id, first_name, last_name, email) values(default, 'Hector', 'Hernandez', 'hector1990@gmail.com');
insert into clients(id, first_name, last_name, email) values(default, 'Diana', 'Hernandez', 'diana90@gmail.com');
insert into clients(id, first_name, last_name, email) values(default, 'Sandra', 'Rodriguez', 'sandra12@gmail.com');
insert into clients(id, first_name, last_name, email) values(default, 'Rodrigo', 'Torres', 'rtorres01@gmail.com');
insert into clients(id, first_name, last_name, email) values(default, 'Andrea', 'Salinas', 'andrea1992@gmail.com');

-- Agregar un tipo de cuenta
insert into account_types (id, name, description) values(default, 'ahorro', 'Cuenta de Ahorro para el banco Academlo, destinada para jovenes universitarios');
insert into account_types (id, name, description) values(default, 'credito basico', 'Cuenta de credito para personas sin historial crediticio');
insert into account_types (id, name, description) values(default, 'credito plus', 'Cuenta de credito para personas con buen historial crediticio');
insert into account_types (id, name, description) values(default, 'debito basico', 'Cuenta de debito con pocos beneficios');

-- Agregar una cuenta y asignarla sobre un cliente (existente)
insert into accounts (id, account_no, client_id, balance, type) values(default, 197996785, 1, 500.00, 2);
insert into accounts (id, account_no, client_id, balance, type) values(default, 187996786, 2, 0.00, 1);
insert into accounts (id, account_no, client_id, balance, type) values(default, 187996795, 2, 10000.00, 3);
insert into accounts (id, account_no, client_id, balance, type) values(default, 197996925, 2, 5000.00, 4);
insert into accounts (id, account_no, client_id, balance, type) values(default, 187996815, 3, 500.00, 2);
insert into accounts (id, account_no, client_id, balance, type) values(default, 197996805, 3, 0.00, 1);
insert into accounts (id, account_no, client_id, balance, type) values(default, 187996895, null, 0.00, 1);
insert into accounts (id, account_no, client_id, balance, type) values(default, 197996905, null, 0.00, 1);

-- Tipos de transacciones
insert into transactions_types(id, name, description) values(default, 'Pago de credito', 'Pago de credito para los clientes (basico y plus)');
insert into transactions_types(id, name, description) values(default, 'Ahorro', 'Deposito a cuenta de ahorro');
insert into transactions_types(id, name, description) values(default, 'Transferencia', 'Transferencia interbancaria');
insert into transactions_types(id, name, description) values(default, 'Pago de servicios', 'Pago de servicio desde una cuenta de ahorro o debito');

-- Transacciones hacía cuentas
insert into transactions (id, account_ori, account_des, amount, transaction_type, trans_date) values(default, 5, 2, 500, 2, NOW());
insert into transactions (id, account_ori, account_des, amount, transaction_type, trans_date) values(default, 5, 2, 700, 2, NOW());
insert into transactions (id, account_ori, account_des, amount, transaction_type, trans_date) values(default, 5, 6, 1000, 3, NOW());
insert into transactions (id, account_ori, account_des, amount, transaction_type, trans_date) values(default, 5, 6, 500, 3, NOW());



-- TAREA REALIZADA

-- 1.  Seleccionar todos los registros de usuarios con las siguientes columnas (id, first_name, last_name, email) y obtener las cuentas sin importar si tiene o no cuentas creadas en el banco y mostrar las columnas de (account_no y balance). 
create view v_clients_accounts as select clients.id as id_cliente, clients.first_name as nombre, clients.last_name as apellido , clients.email as email, accounts.account_no as cuenta, accounts.balance as saldo  from clients left join accounts on clients.id = accounts.client_id ;
select * from v_clients_accounts 

-- 2.  Seleccionar todas las cuentas y el tipo de cuenta al que corresponde el registro de cuenta. Deberás de agregar las columnas con respecto a la siguiente tabla:
create view v_accounts_types as select accounts.account_no as cuenta , accounts.client_id as id_cliente, account_types.name as tipo_cuenta from accounts left join account_types on accounts.type = account_types.id ;
select * from v_accounts_types

--3.  Selecciona todas las transacciones realizadas, su monto y el tipo de transacción para que el resultado sea similar a la siguiente tabla: 
create view v_transactions_detail as select transactions.id as transaccion, transactions.amount as monto, transactions_types.name as tipo_de_transaccion from transactions left join transactions_types on transactions.transaction_type = transactions_types.id ;
select  * from v_transactions_detail 

-- 4.  Selecciona todas las transacciones realizadas, su monto y todos los tipos de transacciones que coincidan con la transacción realizar para que el resultado sea similar al de la siguiente tabla:
create view v_transations_types_detail as select transactions.id as transaccion, transactions.amount as monto, transactions_types.name as tipo_de_transaccion from transactions_types left join transactions on transactions_types.id = transactions.transaction_type ;
select * from v_transations_types_detail 
