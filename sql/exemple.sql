
--12--


-- 1
--Afisati toate salile de antrenament (ID-ul si capacitatea acestora), impreuna cu numele antrenorilor care au primit feedback pozitiv (mesaje ce contin cuvintele "super" sau "excelent"). Salile selectate trebuie sa fie cele in care s-au desfasurat cursuri sustinute de acesti antrenori.

SELECT DISTINCT S.id_sala, S.capacitate, A.nume AS Antrenor
FROM SALA S
JOIN (
    SELECT F.id_antrenor
    FROM FEEDBACK F
    WHERE LOWER(F.mesaj) LIKE '%super%' OR LOWER(F.mesaj) LIKE '%excelent%'
) FB_A ON S.id_sala IN (
    SELECT DISTINCT P.id_curs
    FROM PROGRAMARE_CURS P
    WHERE P.id_antrenor = FB_A.id_antrenor
)
JOIN ANTRENOR A ON FB_A.id_antrenor = A.id_antrenor;







--2
--Sa se obtina o statistica pentru fiecare antrenor care a sustinut cursuri in luna iunie 2025. Pentru fiecare antrenor, se va afisa numele sau (cu prima litera mare), varsta medie a clientilor care au participat la cursurile sale in acea luna, numarul de cursuri diferite sustinute, data ultimei programari sustinute in acea luna, numarul de clienti care au un abonament activ (la data de 15 iunie 2025) intr-una din salile in care antrenorul a sustinut cursuri, precum si nivelul de experienta al antrenorului (stabilit in functie de anii de experienta: daca are peste 5 ani este experimentat, daca are sub 2 ani este considerat nou, iar in celelalte cazuri se considera ca are experienta medie). In raport vor fi inclusi doar antrenorii care au cel putin 3 clienti cu abonamente active in salile in care predau. Rezultatele vor fi ordonate descrescator in functie de numarul de clienti cu abonamente active.

WITH abonamente_active AS (
    SELECT I.id_client, I.id_sala
    FROM ISTORIC I
    WHERE  TO_DATE('2025-06-15', 'YYYY-MM-DD') BETWEEN I.data_inceput AND I.data_expirare
)
SELECT
    INITCAP(A.nume) AS nume_antrenor,
    ROUND(AVG(C.varsta), 2) AS varsta_medie_clienti,
    COUNT(DISTINCT PC.id_curs) AS nr_cursuri_sustinute,
    TO_CHAR(MAX(PC.data), 'DD-MON-YYYY') AS data_ultima_programare,
    NVL((
        SELECT COUNT(DISTINCT AA.id_client)
        FROM abonamente_active AA
        WHERE AA.id_sala IN (
            SELECT DISTINCT S.id_sala
            FROM CURS CU
            JOIN SALA S ON CU.id_sala = S.id_sala
            WHERE CU.id_curs IN (
                SELECT PC2.id_curs FROM PROGRAMARE_CURS PC2 WHERE PC2.id_antrenor = A.id_antrenor
            )
        )
    ), 0) AS nr_clienti_abonati,
    CASE
        WHEN AC.ani_experienta > 5 THEN 'Experimentat'
        WHEN AC.ani_experienta < 2 THEN 'Nou'
        ELSE 'Experienta medie'
    END AS nivel_experienta
FROM ANTRENOR A
JOIN ANTRENOR_CURS AC ON A.id_antrenor = AC.id_antrenor
JOIN PROGRAMARE_CURS PC ON A.id_antrenor = PC.id_antrenor
JOIN COMPONENTA_CLASA CC ON PC.id_programare = CC.id_programare
JOIN CLIENT C ON CC.id_client = C.id_client
WHERE TO_CHAR(PC.data, 'MM-YYYY') = '06-2025'
GROUP BY A.id_antrenor, A.nume, AC.ani_experienta
HAVING (
    SELECT COUNT(DISTINCT AA.id_client)
    FROM abonamente_active AA
    WHERE AA.id_sala IN (
        SELECT DISTINCT S.id_sala
        FROM CURS CU
        JOIN SALA S ON CU.id_sala = S.id_sala
        WHERE CU.id_curs IN (
            SELECT PC2.id_curs FROM PROGRAMARE_CURS PC2 WHERE PC2.id_antrenor = a.id_antrenor
        )
    )
) >= 3
ORDER BY nr_clienti_abonati DESC;




--3
--Se cere sa se afiseze pentru fiecare curs: denumirea cursului, nivelul de dificultate, numarul de participanti, rata medie de prezenta calculata procentual, numele si email-ul antrenorului (scris cu litere mici), precum si denumirea si capacitatea salii in care se tine cursul.

SELECT
    statistici_curs.denumire_curs,
    statistici_curs.nivel_dificultate,
    statistici_curs.numar_participanti,
    ROUND(statistici_curs.rata_prezenta) AS procent_prezenta,
    informatii_antrenor.nume_antrenor,
    LOWER(informatii_antrenor.email_antrenor) AS mail_antrenor,
    informatii_sala.nume_sala,
    informatii_sala.capacitate
FROM (
    SELECT
        C.id_curs,
        C.denumire AS denumire_curs,
        C.nivel_dificultate,
        C.id_sala,
        COUNT(CC.id_client) AS numar_participanti,
        AVG(CC.prezenta_efectiva) * 100 AS rata_prezenta
    FROM CURS C
    LEFT JOIN PROGRAMARE_CURS PC ON C.id_curs = PC.id_curs
    LEFT JOIN COMPONENTA_CLASA CC ON PC.id_programare = CC.id_programare
    GROUP BY C.id_curs, C.denumire, C.nivel_dificultate, C.id_sala
) statistici_curs
LEFT JOIN (
    SELECT DISTINCT
        PC.id_curs,
        A.nume AS nume_antrenor,
        A.email AS email_antrenor
    FROM PROGRAMARE_CURS PC
    JOIN ANTRENOR A ON PC.id_antrenor = A.id_antrenor
    WHERE A.tip = 'Curs'
) informatii_antrenor ON statistici_curs.id_curs = informatii_antrenor.id_curs
LEFT JOIN (
    SELECT
        S.id_sala,
        S.nume_sala,
        S.capacitate
    FROM SALA S
) informatii_sala ON statistici_curs.id_sala = informatii_sala.id_sala;







--4
--Sa se obtina o lista cu toate programarile de cursuri realizate in luna iunie 2025. Pentru fiecare programare, se vor afisa urmatoarele informatii: denumirea cursului, numele antrenorului, denumirea salii in care se tine cursul, precum si numarul de echipamente in stare buna disponibile in sala respectiva. In cazul in care nu exista echipamente in stare buna, se va afisa valoarea 0. Rezultatele vor fi ordonate descrescator in functie de numarul de echipamente disponibile.

SELECT DISTINCT
    PC.id_programare,
    C.denumire AS nume_curs,
    A.nume AS antrenor,
    S.nume_sala,
    NVL(COUNT(E.id_echipament), 0) AS nr_echipamente
FROM
    PROGRAMARE_CURS PC
JOIN
    CURS C ON PC.id_curs = C.id_curs
JOIN
    ANTRENOR A ON PC.id_antrenor = A.id_antrenor
JOIN
    SALA S ON C.id_sala = S.id_sala
LEFT JOIN
    ECHIPAMENT E ON S.id_sala = E.id_sala AND LOWER(E.stare) LIKE '%buna%'
WHERE
    TO_CHAR(PC.data, 'MM-YYYY') = '06-2025'
GROUP BY
    PC.id_programare, C.denumire, A.nume, S.nume_sala
ORDER BY
    nr_echipamente DESC;









--5
--Sa se afiseze detalii despre programarile cursurilor din luna iunie 2025. Pentru fiecare programare, sa se afiseze ID-ul programarii, numele cursului scris cu majuscule si fara spatii suplimentare, numele antrenorului, data programarii in format calendaristic si ziua saptamanii, ora programarii, perioada saptamanii clasificata (Weekend, Inceput de saptamana, Mijlocul saptamanii, numarul participantilor, statusul temporal al programarii (viitoare, de azi sau trecuta), o descriere detaliata a nivelului de dificultate al cursului, precum si capacitatea salii unde se tine programarea. Rezultatele vor fi ordonate crescator dupa data programarii, ora programarii si nivelul de dificultate.

SELECT
    PC.id_programare,
    TRIM(UPPER(C.denumire)) AS nume_curs,
    A.nume,
    TO_CHAR(PC.data, 'DD-MON-YYYY') AS data_calendaristica,
    TO_CHAR(PC.data, 'DAY') AS ziua_saptamanii,
    PC.ora_programare,
    CASE
        WHEN TO_CHAR(PC.data, 'D') IN ('6', '7') THEN 'Weekend'
        WHEN TO_CHAR(PC.data, 'D') IN ('1', '2', '3') THEN 'Inceput saptamana'
        ELSE 'Mijlocul saptamanii'
    END AS perioada_saptamana,
    NVL(COUNT(CC.id_client), 0) AS numar_participanti,
    DECODE(
        SIGN(PC.data - SYSDATE),
        1, 'Programare viitoare',
        0, 'Programare astazi',
        'Programare trecuta'
    ) AS status_temporal,
    DECODE(
        C.nivel_dificultate,
        'Incepator', 'Nivel 1 - Usor',
        'Intermediar', 'Nivel 2 - Mediu',
        'Avansat', 'Nivel 3 - Dificil',
        'Nivel nedefinit'
    ) AS descriere_nivel,
    NVL(S.capacitate, 0) AS capacitate_sala
FROM PROGRAMARE_CURS PC
JOIN CURS C ON PC.id_curs = C.id_curs
JOIN ANTRENOR A ON PC.id_antrenor = A.id_antrenor
JOIN SALA S ON C.id_sala = S.id_sala
LEFT JOIN COMPONENTA_CLASA CC ON PC.id_programare = CC.id_programare
WHERE EXTRACT(MONTH FROM PC.data) = 6
AND EXTRACT(YEAR FROM PC.data) = 2025
GROUP BY PC.id_programare, C.denumire, A.nume, PC.data, PC.ora_programare,
         C.nivel_dificultate, S.capacitate
ORDER BY PC.data,
         NVL(PC.ora_programare, '00:00'),
         DECODE(C.nivel_dificultate, 'Incepator', 1, 'Intermediar', 2, 'Avansat', 3, 0);













--13
--1
--Sa se scada cu 10 capacitatea salilor (coloana “capacitate” din tabela SALA) in care exista macar un aparat avariat.

UPDATE SALA
SET capacitate = capacitate - 10
WHERE id_sala IN (
    SELECT DISTINCT E.id_sala
    FROM ECHIPAMENT E
    WHERE LOWER(E.stare) = 'avariat'
);


--2
--Sa se stearga toate tipurile de abonament pe care nu le-a cumparat nimeni.

DELETE FROM TIP_ABONAMENT
WHERE id_tip_abonament NOT IN (
    SELECT DISTINCT id_tip_abonament
    FROM ISTORIC
);



--3
--Sa se actualizeze nivelul de dificultate ca fiind pentru incepatori pentru cursurile la care media de prezenta efectiva este de sub o persoana, pentru a le face mai atractive pentru cei incepatori.

UPDATE CURS
SET nivel_dificultate = 'Incepator'
WHERE id_curs IN (
    SELECT C.id_curs
    FROM CURS C
    JOIN PROGRAMARE_CURS PC ON C.id_curs = PC.id_curs
    JOIN COMPONENTA_CLASA CC ON PC.id_programare = CC.id_programare
    GROUP BY C.id_curs
    HAVING AVG(CC.prezenta_efectiva) < 1
);







--14
--Sa se creeze o vizualizare care sa afiseze, pentru fiecare programare de curs, denumirea cursului, numele antrenorului, sala, data programarii si numarul de participanti inscrisi (inclusiv 0 pentru programarile fara participanti).

CREATE OR REPLACE VIEW v_statistici_cursuri AS
SELECT
    PC.id_programare,
    C.denumire AS nume_curs,
    A.nume AS nume_antrenor,
    S.nume_sala,
    TO_CHAR(PC.data, 'DD-MON-YYYY') AS data_programare,
    NVL(COUNT(CC.id_client), 0) AS numar_participanti
FROM PROGRAMARE_CURS PC
JOIN CURS C ON PC.id_curs = C.id_curs
JOIN ANTRENOR A ON PC.id_antrenor = A.id_antrenor
JOIN SALA S ON C.id_sala = S.id_sala
LEFT JOIN COMPONENTA_CLASA CC ON PC.id_programare = CC.id_programare
GROUP BY PC.id_programare, C.denumire, A.nume, S.nume_sala, PC.data;



SELECT * FROM v_statistici_cursuri WHERE nume_curs = 'Zumba';



-- INSERT INTO v_statistici_cursuri (id_programare, nume_curs, nume_antrenor, nume_sala, data_programare, numar_participanti)
-- VALUES (101, 'Pilates', 'Andrei Ionescu', 'GymLife', '15-JUN-2025', 10);






--15

--1
--Sa se afiseze toate salile, si, daca exista, cursurile desfasurate in ele, alaturi de antrenorii care le predau si feedbackurile primite de acestia.

SELECT
    S.nume_sala,
    C.denumire AS denumire_curs,
    A.nume AS nume_antrenor,
    F.mesaj AS feedback
FROM SALA S
LEFT JOIN CURS C ON S.id_sala = C.id_sala
LEFT JOIN PROGRAMARE_CURS PC ON C.id_curs = PC.id_curs
LEFT JOIN ANTRENOR A ON PC.id_antrenor = A.id_antrenor
LEFT JOIN FEEDBACK F ON A.id_antrenor = F.id_antrenor;





--2
--Sa se selecteze salile in care toate echipamentele se afla in stare buna.

SELECT S.id_sala, S.nume_sala
FROM SALA S
WHERE NOT EXISTS (
    SELECT 1
    FROM ECHIPAMENT E
    WHERE E.id_sala = S.id_sala
      AND LOWER(E.stare) != 'buna'
);






--3
--Sa se afiseze primii 3 antrenori, in functie de numarul de feedbackuri primite.

SELECT A.id_antrenor, A.nume, COUNT(F.id_feedback) AS numar_feedbackuri
FROM ANTRENOR A
JOIN FEEDBACK F ON A.id_antrenor = F.id_antrenor
GROUP BY A.id_antrenor, A.nume
ORDER BY numar_feedbackuri DESC
FETCH FIRST 3 ROWS ONLY;





--16

SELECT CL.nume, PC.ora_programare, C.denumire, S.nume_sala, O.nume_oras
FROM PROGRAMARE_CURS PC, COMPONENTA_CLASA CC, CLIENT CL,
CURS C, SALA S, ORAS O
WHERE PC.id_programare = CC.id_programare
AND CC.id_client = CL.id_client
AND C.id_curs = PC.id_curs
AND C.id_sala = S.id_sala
AND S.id_oras = O.id_oras
AND PC.ora_programare >= TO_CHAR(16);





SELECT CL.nume, PC.ora_programare, C.denumire, S.nume_sala, O.nume_oras
FROM PROGRAMARE_CURS PC
JOIN CURS C ON C.id_curs = PC.id_curs AND PC.ora_programare >= TO_CHAR(16)
JOIN SALA S on S.id_sala = C.id_sala
JOIN ORAS O on O.id_oras = S.id_oras
JOIN COMPONENTA_CLASA CC on PC.id_programare = CC.id_programare
JOIN CLIENT CL ON CL.id_client = CC.id_client;





--17 b

SELECT PC.data, PC.ora_programare,
C.nivel_dificultate, C.denumire,
S.nume_sala, S.adresa, S.capacitate
FROM PROGRAMARE_CURS PC
JOIN CURS C ON C.id_curs = PC.id_curs
JOIN SALA S ON S.id_sala = C.id_sala;
