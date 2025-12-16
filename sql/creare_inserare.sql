--Crearea unei secvențe ce va fi utilizată în inserarea înregistrărilor în tabele (punctul 11)

CREATE SEQUENCE CLIENT_SEQ START WITH 1;
CREATE SEQUENCE ORAS_SEQ START WITH 1;
CREATE SEQUENCE SALA_SEQ START WITH 1;
CREATE SEQUENCE ECHIPAMENT_SEQ START WITH 1;
CREATE SEQUENCE CURS_SEQ START WITH 1;
CREATE SEQUENCE ANTRENOR_SEQ START WITH 1;
CREATE SEQUENCE PROGRAMARE_SEQ START WITH 1;
CREATE SEQUENCE COMPONENTA_SEQ START WITH 1;
CREATE SEQUENCE TIP_ABONAMENT_SEQ START WITH 1;
CREATE SEQUENCE ISTORIC_SEQ START WITH 1;
CREATE SEQUENCE FEEDBACK_SEQ START WITH 1;
CREATE SEQUENCE SESIUNE_SEQ START WITH 1;

SELECT SEQUENCE_NAME FROM USER_SEQUENCES;







--Crearea tabelelor si inserarea datlor

CREATE TABLE CLIENT (
  id_client INT DEFAULT CLIENT_SEQ.NEXTVAL PRIMARY KEY,
  nume VARCHAR(50),
  varsta INT
);


INSERT INTO CLIENT (nume, varsta) VALUES ('Popescu Andrei', 28);

INSERT INTO CLIENT (nume, varsta) VALUES ('Ionescu Maria', 35);

INSERT INTO CLIENT (nume, varsta) VALUES ('Vasilescu Elena', 24);

INSERT INTO CLIENT (nume, varsta) VALUES ('Georgescu Mihai', 30);

INSERT INTO CLIENT (nume, varsta) VALUES ('Dumitru Ana', 40);

INSERT INTO CLIENT (nume, varsta) VALUES ('Radu Cristian', 22);

INSERT INTO CLIENT (nume, varsta) VALUES ('Ilie Gabriela', 31);

INSERT INTO CLIENT (nume, varsta) VALUES ('Mihailescu Tudor', 27);

INSERT INTO CLIENT (nume, varsta) VALUES ('Toma Irina', 33);

INSERT INTO CLIENT (nume, varsta) VALUES ('Preda Sorin', 29);


SELECT *
FROM CLIENT
ORDER BY id_client;





CREATE TABLE ORAS(
  id_oras INT DEFAULT ORAS_SEQ.NEXTVAL PRIMARY KEY,
  nume_oras VARCHAR(50),
  judet VARCHAR(50),
  populatie INT
);


INSERT INTO ORAS (nume_oras, judet, populatie) VALUES ('Bucuresti', 'Ilfov', 1800000);

INSERT INTO ORAS (nume_oras, judet, populatie) VALUES ('Cluj-Napoca', 'Cluj', 300000);

INSERT INTO ORAS (nume_oras, judet, populatie) VALUES ('Iasi', 'Iasi', 290000);

INSERT INTO ORAS (nume_oras, judet, populatie) VALUES ('Timisoara', 'Timis', 320000);

INSERT INTO ORAS (nume_oras, judet, populatie) VALUES ('Constanta', 'Constanta', 280000);


SELECT *
FROM ORAS
ORDER BY id_oras;





CREATE TABLE SALA(
  id_sala INT DEFAULT SALA_SEQ.NEXTVAL PRIMARY KEY,
  id_oras INT,
  nume_sala VARCHAR(50),
  adresa VARCHAR(100),
  capacitate INT,
  FOREIGN KEY (id_oras) REFERENCES ORAS(id_oras)
);


INSERT INTO SALA (id_oras, nume_sala, adresa, capacitate) VALUES (1, 'Fitness Arena',
                                                                  'Strada Muncii 23', 120);

INSERT INTO SALA (id_oras, nume_sala, adresa, capacitate) VALUES (2, 'Body Shape',
                                                                  'Bd. Eroilor 10', 100);

INSERT INTO SALA (id_oras, nume_sala, adresa, capacitate) VALUES (3, 'FitLife',
                                                                  'Str. Libertatii 45', 90);

INSERT INTO SALA (id_oras, nume_sala, adresa, capacitate) VALUES (4, 'GymPro',
                                                                  'Str. Independentei 15', 110);

INSERT INTO SALA (id_oras, nume_sala, adresa, capacitate) VALUES (5, 'ActiveZone',
                                                                  'Bd. Tomis 200', 85);


SELECT *
FROM SALA
ORDER BY id_sala;





CREATE TABLE ECHIPAMENT(
  id_echipament INT DEFAULT ECHIPAMENT_SEQ.NEXTVAL PRIMARY KEY,
  id_sala INT,
  stare VARCHAR(30),
  denumire VARCHAR(50),
  FOREIGN KEY (id_sala) REFERENCES SALA(id_sala)
);


INSERT INTO ECHIPAMENT (id_sala, stare, denumire) VALUES (1, 'Buna', 'Banda alergare');

INSERT INTO ECHIPAMENT (id_sala, stare, denumire) VALUES (1, 'Avariat', 'Bicicleta stationara');

INSERT INTO ECHIPAMENT (id_sala, stare, denumire) VALUES (2, 'Buna', 'Aparat spate');

INSERT INTO ECHIPAMENT (id_sala, stare, denumire) VALUES (3, 'Buna', 'Bara haltere');

INSERT INTO ECHIPAMENT (id_sala, stare, denumire) VALUES (4, 'Buna', 'Banca abdomene');

INSERT INTO ECHIPAMENT (id_sala, stare, denumire) VALUES (5, 'Avariat', 'Gantere');


SELECT *
FROM ECHIPAMENT
ORDER BY id_echipament;





CREATE TABLE CURS(
  id_curs INT DEFAULT CURS_SEQ.NEXTVAL PRIMARY KEY,
  id_sala INT,
  nivel_dificultate VARCHAR(20),
  denumire VARCHAR(50),
  FOREIGN KEY (id_sala) REFERENCES SALA(id_sala)
);


INSERT INTO CURS (id_sala, nivel_dificultate, denumire) VALUES (1, 'Incepator', 'Zumba');

INSERT INTO CURS (id_sala, nivel_dificultate, denumire) VALUES (2, 'Intermediar', 'Pilates');

INSERT INTO CURS (id_sala, nivel_dificultate, denumire) VALUES (3, 'Avansat', 'Pilates');

INSERT INTO CURS (id_sala, nivel_dificultate, denumire) VALUES (4, 'Avansat', 'Zumba');

INSERT INTO CURS (id_sala, nivel_dificultate, denumire) VALUES (5, 'Incepator', 'Functional Training');


SELECT *
FROM CURS
ORDER BY id_curs;





CREATE TABLE ANTRENOR(
  id_antrenor INT DEFAULT ANTRENOR_SEQ.NEXTVAL PRIMARY KEY,
  nume VARCHAR(50),
  email VARCHAR(50),
  tip VARCHAR(20)
);


INSERT INTO ANTRENOR (nume, email, tip) VALUES ('Popescu Andrei', 'andrei.p@example.com', 'Curs');

INSERT INTO ANTRENOR (nume, email, tip) VALUES ('Ionescu Maria', 'maria.i@example.com', 'Curs');

INSERT INTO ANTRENOR (nume, email, tip) VALUES ('Vasilescu George', 'george.v@example.com', 'Curs');

INSERT INTO ANTRENOR (nume, email, tip) VALUES ('Stanescu Ioana', 'ioana.s@example.com', 'Curs');

INSERT INTO ANTRENOR (nume, email, tip) VALUES ('Dumitrescu Mihai', 'mihai.d@example.com', 'Curs');

INSERT INTO ANTRENOR (nume, email, tip) VALUES ('Ciobanu Matei', 'matei.c@gmail.com', 'Personal');

INSERT INTO ANTRENOR (nume, email, tip) VALUES ('Pavelescu Angela', 'pavang@gmail.com', 'Personal');

INSERT INTO ANTRENOR (nume, email, tip) VALUES ('Chelaru Adrian', 'adrianchelaru@gmail.com', 'Personal');

INSERT INTO ANTRENOR (nume, email, tip) VALUES ('Anghelescu Ioana', 'anghelescutrainer@gmail.com', 'Personal');

INSERT INTO ANTRENOR (nume, email, tip) VALUES ('Serbanescu Mihai', 'mihaiserbanescu@gmail.com', 'Personal');


SELECT *
FROM ANTRENOR
ORDER BY id_antrenor;





CREATE TABLE TIP_ABONAMENT(
  id_tip_abonament INT DEFAULT TIP_ABONAMENT_SEQ.NEXTVAL PRIMARY KEY,
  pret INT,
  facilitati VARCHAR(100)
);


INSERT INTO TIP_ABONAMENT (pret, facilitati) VALUES (200, 'Acces general + Pilates');

INSERT INTO TIP_ABONAMENT (pret, facilitati) VALUES (250, 'Acces general + Zumba + Functional');

INSERT INTO TIP_ABONAMENT (pret, facilitati) VALUES (300, 'Acces general + Personal Trainer');

INSERT INTO TIP_ABONAMENT (pret, facilitati) VALUES (100, 'Acces limitat');

INSERT INTO TIP_ABONAMENT (pret, facilitati) VALUES (150, 'Acces limitat + Pilates');


SELECT *
FROM TIP_ABONAMENT
ORDER BY id_tip_abonament;






CREATE TABLE ANTRENOR_CURS (
  id_antrenor INT PRIMARY KEY,
  ani_experienta INT,
  FOREIGN KEY (id_antrenor) REFERENCES ANTRENOR(id_antrenor)
);


INSERT INTO ANTRENOR_CURS (id_antrenor, ani_experienta) VALUES (16, 5);

INSERT INTO ANTRENOR_CURS (id_antrenor, ani_experienta) VALUES (17, 8);

INSERT INTO ANTRENOR_CURS (id_antrenor, ani_experienta) VALUES (18, 3);

INSERT INTO ANTRENOR_CURS (id_antrenor, ani_experienta) VALUES (19, 10);

INSERT INTO ANTRENOR_CURS (id_antrenor, ani_experienta) VALUES (20, 2);


SELECT *
FROM ANTRENOR_CURS
ORDER BY id_antrenor;






CREATE TABLE ANTRENOR_PERSONAL (
  id_antrenor INT PRIMARY KEY,
  specializare_musculatura VARCHAR(50),
  FOREIGN KEY (id_antrenor) REFERENCES ANTRENOR(id_antrenor)
);


INSERT INTO ANTRENOR_PERSONAL (id_antrenor, specializare_musculatura) VALUES (21, 'Upper-body');

INSERT INTO ANTRENOR_PERSONAL (id_antrenor, specializare_musculatura) VALUES (22, 'Lower-body');

INSERT INTO ANTRENOR_PERSONAL (id_antrenor, specializare_musculatura) VALUES (23, 'Lower-body');

INSERT INTO ANTRENOR_PERSONAL (id_antrenor, specializare_musculatura) VALUES (24, 'Full-body');

INSERT INTO ANTRENOR_PERSONAL (id_antrenor, specializare_musculatura) VALUES (25, 'Full-body');


SELECT *
FROM ANTRENOR_PERSONAL
ORDER BY id_antrenor;





CREATE TABLE PROGRAMARE_CURS (
  id_programare INT PRIMARY KEY,
  id_antrenor INT,
  id_curs INT,
  data DATE,
  ora_programare VARCHAR2(5),
  FOREIGN KEY (id_antrenor) REFERENCES ANTRENOR(id_antrenor),
  FOREIGN KEY (id_curs) REFERENCES CURS(id_curs)
);


INSERT INTO PROGRAMARE_CURS (id_programare, id_antrenor, id_curs, data, ora_programare)
VALUES (1, 16, 1, DATE '2025-06-01', '10:00');

INSERT INTO PROGRAMARE_CURS (id_programare, id_antrenor, id_curs, data, ora_programare)
VALUES (2, 16, 2, DATE '2025-06-02', '12:00');

INSERT INTO PROGRAMARE_CURS (id_programare, id_antrenor, id_curs, data, ora_programare)
VALUES (3, 17, 3, DATE '2025-06-03', '14:00');

INSERT INTO PROGRAMARE_CURS (id_programare, id_antrenor, id_curs, data, ora_programare)
VALUES (4, 17, 4, DATE '2025-06-04', '16:00');

INSERT INTO PROGRAMARE_CURS (id_programare, id_antrenor, id_curs, data, ora_programare)
VALUES (5, 18, 5, DATE '2025-06-05', '18:00');

INSERT INTO PROGRAMARE_CURS (id_programare, id_antrenor, id_curs, data, ora_programare)
VALUES (6, 18, 1, DATE '2025-06-06', '10:00');

INSERT INTO PROGRAMARE_CURS (id_programare, id_antrenor, id_curs, data, ora_programare)
VALUES (7, 19, 2, DATE '2025-06-07', '12:00');

INSERT INTO PROGRAMARE_CURS (id_programare, id_antrenor, id_curs, data, ora_programare)
VALUES (8, 19, 3, DATE '2025-06-08', '14:00');

INSERT INTO PROGRAMARE_CURS (id_programare, id_antrenor, id_curs, data, ora_programare)
VALUES (9, 20, 4, DATE '2025-06-09', '16:00');

INSERT INTO PROGRAMARE_CURS (id_programare, id_antrenor, id_curs, data, ora_programare)
VALUES (10, 20, 5, DATE '2025-06-10', '18:00');


SELECT *
FROM PROGRAMARE_CURS
ORDER BY id_programare;






CREATE TABLE COMPONENTA_CLASA(
  id_componenta INT DEFAULT COMPONENTA_SEQ.NEXTVAL PRIMARY KEY,
  id_client INT,
  id_programare INT,
  prezenta_efectiva NUMBER(1),
  data_confirmare DATE,
  FOREIGN KEY (id_client) REFERENCES CLIENT(id_client),
  FOREIGN KEY (id_programare) REFERENCES PROGRAMARE_CURS(id_programare)
);


INSERT INTO COMPONENTA_CLASA (id_client, id_programare, prezenta_efectiva, data_confirmare)
VALUES (1, 2, '1', TO_DATE('2025-06-01', 'YYYY-MM-DD'));

INSERT INTO COMPONENTA_CLASA (id_client, id_programare, prezenta_efectiva, data_confirmare)
VALUES (2, 3, '0', TO_DATE('2025-06-01', 'YYYY-MM-DD'));

INSERT INTO COMPONENTA_CLASA (id_client, id_programare, prezenta_efectiva, data_confirmare)
VALUES (3, 4, '1', TO_DATE('2025-06-03', 'YYYY-MM-DD'));

INSERT INTO COMPONENTA_CLASA (id_client, id_programare, prezenta_efectiva, data_confirmare)
VALUES (4, 1, '1', TO_DATE('2025-06-01', 'YYYY-MM-DD'));

INSERT INTO COMPONENTA_CLASA (id_client, id_programare, prezenta_efectiva, data_confirmare)
VALUES (5, 5, '0', TO_DATE('2025-06-03', 'YYYY-MM-DD'));

INSERT INTO COMPONENTA_CLASA (id_client, id_programare, prezenta_efectiva, data_confirmare)
VALUES (1, 6, '1', TO_DATE('2025-06-01', 'YYYY-MM-DD'));

INSERT INTO COMPONENTA_CLASA (id_client, id_programare, prezenta_efectiva, data_confirmare)
VALUES (2, 7, '0', TO_DATE('2025-06-03', 'YYYY-MM-DD'));

INSERT INTO COMPONENTA_CLASA (id_client, id_programare, prezenta_efectiva, data_confirmare)
VALUES (3, 8, '1', TO_DATE('2025-06-05', 'YYYY-MM-DD'));

INSERT INTO COMPONENTA_CLASA (id_client, id_programare, prezenta_efectiva, data_confirmare)
VALUES (4, 9, '1', TO_DATE('2025-06-06', 'YYYY-MM-DD'));

INSERT INTO COMPONENTA_CLASA (id_client, id_programare, prezenta_efectiva, data_confirmare)
VALUES (5, 10, '0', TO_DATE('2025-06-08', 'YYYY-MM-DD'));


SELECT *
FROM COMPONENTA_CLASA
ORDER BY id_componenta;





CREATE TABLE ISTORIC(
  id_istoric INT DEFAULT ISTORIC_SEQ.NEXTVAL PRIMARY KEY,
  id_client INT,
  id_tip_abonament INT,
  id_sala INT,
  data_inceput DATE,
  data_expirare DATE,
  FOREIGN KEY (id_client) REFERENCES CLIENT(id_client),
  FOREIGN KEY (id_tip_abonament) REFERENCES TIP_ABONAMENT(id_tip_abonament),
  FOREIGN KEY (id_sala) REFERENCES SALA(id_sala)
);


INSERT INTO ISTORIC (id_client, id_tip_abonament, id_sala, data_inceput, data_expirare)
VALUES (1, 1, 1, TO_DATE('2025-06-01', 'YYYY-MM-DD'), TO_DATE('2025-08-01', 'YYYY-MM-DD'));

INSERT INTO ISTORIC (id_client, id_tip_abonament, id_sala, data_inceput, data_expirare)
VALUES (2, 1, 2, TO_DATE('2025-06-01', 'YYYY-MM-DD'), TO_DATE('2025-08-01', 'YYYY-MM-DD'));

INSERT INTO ISTORIC (id_client, id_tip_abonament, id_sala, data_inceput, data_expirare)
VALUES (3, 2, 3, TO_DATE('2025-06-01', 'YYYY-MM-DD'), TO_DATE('2025-08-01', 'YYYY-MM-DD'));

INSERT INTO ISTORIC (id_client, id_tip_abonament, id_sala, data_inceput, data_expirare)
VALUES (4, 2, 4, TO_DATE('2025-06-01', 'YYYY-MM-DD'), TO_DATE('2025-08-01', 'YYYY-MM-DD'));

INSERT INTO ISTORIC (id_client, id_tip_abonament, id_sala, data_inceput, data_expirare)
VALUES (5, 3, 5, TO_DATE('2025-06-01', 'YYYY-MM-DD'), TO_DATE('2025-09-01', 'YYYY-MM-DD'));

INSERT INTO ISTORIC (id_client, id_tip_abonament, id_sala, data_inceput, data_expirare)
VALUES (6, 3, 1, TO_DATE('2025-06-02', 'YYYY-MM-DD'), TO_DATE('2025-09-02', 'YYYY-MM-DD'));

INSERT INTO ISTORIC (id_client, id_tip_abonament, id_sala, data_inceput, data_expirare)
VALUES (7, 4, 2, TO_DATE('2025-06-02', 'YYYY-MM-DD'), TO_DATE('2025-07-02', 'YYYY-MM-DD'));

INSERT INTO ISTORIC (id_client, id_tip_abonament, id_sala, data_inceput, data_expirare)
VALUES (8, 4, 3, TO_DATE('2025-06-02', 'YYYY-MM-DD'), TO_DATE('2025-07-02', 'YYYY-MM-DD'));

INSERT INTO ISTORIC (id_client, id_tip_abonament, id_sala, data_inceput, data_expirare)
VALUES (9, 5, 4, TO_DATE('2025-06-02', 'YYYY-MM-DD'), TO_DATE('2025-07-02', 'YYYY-MM-DD'));

INSERT INTO ISTORIC (id_client, id_tip_abonament, id_sala, data_inceput, data_expirare)
VALUES (10, 5, 5, TO_DATE('2025-06-02', 'YYYY-MM-DD'), TO_DATE('2025-07-02', 'YYYY-MM-DD'));


SELECT *
FROM ISTORIC
ORDER BY id_istoric;






CREATE TABLE FEEDBACK(
  id_feedback INT DEFAULT FEEDBACK_SEQ.NEXTVAL PRIMARY KEY,
  id_antrenor INT,
  id_client INT,
  data DATE,
  mesaj VARCHAR(100),
  FOREIGN KEY (id_antrenor) REFERENCES ANTRENOR(id_antrenor),
  FOREIGN KEY (id_client) REFERENCES CLIENT(id_client)
);

INSERT INTO FEEDBACK (id_antrenor, id_client, data, mesaj)
VALUES (16, 1, TO_DATE('2025-06-21', 'YYYY-MM-DD'), 'Foarte curat!');

INSERT INTO FEEDBACK (id_antrenor, id_client, data, mesaj)
VALUES (16, 2, TO_DATE('2025-06-22', 'YYYY-MM-DD'), 'Excelent!');

INSERT INTO FEEDBACK (id_antrenor, id_client, data, mesaj)
VALUES (19, 3, TO_DATE('2025-07-03', 'YYYY-MM-DD'), 'A fost greu, dar util!');

INSERT INTO FEEDBACK (id_antrenor, id_client, data, mesaj)
VALUES (17, 4, TO_DATE('2025-06-04', 'YYYY-MM-DD'), 'Foarte implicat!');

INSERT INTO FEEDBACK (id_antrenor, id_client, data, mesaj)
VALUES (24, 5, TO_DATE('2025-06-15', 'YYYY-MM-DD'), 'Super experienta!');

INSERT INTO FEEDBACK (id_antrenor, id_client, data, mesaj)
VALUES (24, 2, TO_DATE('2025-07-06', 'YYYY-MM-DD'), 'Nota 10!');

INSERT INTO FEEDBACK (id_antrenor, id_client, data, mesaj)
VALUES (20, 3, TO_DATE('2025-07-17', 'YYYY-MM-DD'), 'M-a motivat mult!');

INSERT INTO FEEDBACK (id_antrenor, id_client, data, mesaj)
VALUES (23, 1, TO_DATE('2025-06-28', 'YYYY-MM-DD'), 'Recomand!');

INSERT INTO FEEDBACK (id_antrenor, id_client, data, mesaj)
VALUES (18, 7, TO_DATE('2025-06-19', 'YYYY-MM-DD'), 'Super curs!');

INSERT INTO FEEDBACK (id_antrenor, id_client, data, mesaj)
VALUES (25, 8, TO_DATE('2025-07-10', 'YYYY-MM-DD'), 'Foarte clar!');


SELECT *
FROM FEEDBACK
ORDER BY id_feedback;





CREATE TABLE SESIUNE_INDIVIDUALA(
  id_sesiune INT DEFAULT SESIUNE_SEQ.NEXTVAL PRIMARY KEY,
  id_antrenor INT,
  id_client INT,
  data DATE,
  ora VARCHAR(10),
  FOREIGN KEY (id_antrenor) REFERENCES ANTRENOR(id_antrenor),
  FOREIGN KEY (id_client) REFERENCES CLIENT(id_client)
);

INSERT INTO SESIUNE_INDIVIDUALA (id_antrenor, id_client, data, ora)
VALUES (21, 5, TO_DATE('2025-06-01', 'YYYY-MM-DD'), '10:30');

INSERT INTO SESIUNE_INDIVIDUALA (id_antrenor, id_client, data, ora)
VALUES (22, 5, TO_DATE('2025-07-05', 'YYYY-MM-DD'), '11:00');

INSERT INTO SESIUNE_INDIVIDUALA (id_antrenor, id_client, data, ora)
VALUES (23, 6, TO_DATE('2025-06-03', 'YYYY-MM-DD'), '12:00');

INSERT INTO SESIUNE_INDIVIDUALA (id_antrenor, id_client, data, ora)
VALUES (24, 6, TO_DATE('2025-06-04', 'YYYY-MM-DD'), '17:30');

INSERT INTO SESIUNE_INDIVIDUALA (id_antrenor, id_client, data, ora)
VALUES (25, 6, TO_DATE('2025-08-07', 'YYYY-MM-DD'), '14:45');

INSERT INTO SESIUNE_INDIVIDUALA (id_antrenor, id_client, data, ora)
VALUES (21, 5, TO_DATE('2025-07-16', 'YYYY-MM-DD'), '15:00');

INSERT INTO SESIUNE_INDIVIDUALA (id_antrenor, id_client, data, ora)
VALUES (22, 6, TO_DATE('2025-08-27', 'YYYY-MM-DD'), '16:45');

INSERT INTO SESIUNE_INDIVIDUALA (id_antrenor, id_client, data, ora)
VALUES (23, 5, TO_DATE('2025-06-18', 'YYYY-MM-DD'), '09:00');

INSERT INTO SESIUNE_INDIVIDUALA (id_antrenor, id_client, data, ora)
VALUES (24, 5, TO_DATE('2025-08-09', 'YYYY-MM-DD'), '18:15');

INSERT INTO SESIUNE_INDIVIDUALA (id_antrenor, id_client, data, ora)
VALUES (25, 6, TO_DATE('2025-06-30', 'YYYY-MM-DD'), '19:00');


SELECT *
FROM SESIUNE_INDIVIDUALA
ORDER BY id_sesiune;

