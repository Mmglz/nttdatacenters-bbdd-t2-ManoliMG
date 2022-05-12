------------------------------------------------------
-- Autor       : Manoli Mena González
-- Descripción : Taller práctico 2 BBDD | PL/SQL
------------------------------------------------------

--Procedimiento que devuelve el nombre, los apellidos y la nota media de los alumnos que están en la empresa NTT DATA

DELIMITER $$
DROP PROCEDURE IF EXISTS stud_info$$
CREATE PROCEDURE stud_info()
BEGIN
-- Declaración de variables
	DECLARE done BOOL DEFAULT FALSE;
	DECLARE vname VARCHAR(15);
	DECLARE vsurnames VARCHAR(30);
	DECLARE vmark DECIMAL(4,2);
	DECLARE vnamecompany VARCHAR(50);
-- Declaración del cursor
	DECLARE cstud CURSOR FOR SELECT S.NAME, SURNAMES, ROUND(AVG(ST.MARK), 2), C.NAME
							 FROM STUDENT S JOIN STUDY ST ON S.COD_STUDENT=ST.COD_STUDENT
							 JOIN COMPANY C ON C.COD_COMPANY = S.COD_COMPANY
							 WHERE C.NAME LIKE 'NTT DATA'
							 GROUP BY S.NAME;

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=true;

	OPEN cstud;
		WHILE NOT done DO
			FETCH cstud INTO vname, vsurnames, vmark, vnamecompany;
			IF NOT done THEN
				SELECT vname AS 'Nombre', vsurnames AS 'Apellidos', vmark AS 'Nota Media', vnamecompany AS 'Empresa';
			END IF;
		END WHILE;
	CLOSE cstud;
END
$$

--Llamada al procedimiento
CALL stud_info();
