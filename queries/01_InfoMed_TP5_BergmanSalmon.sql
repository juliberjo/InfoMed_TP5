CREATE TABLE Pacientes (
    id_paciente SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    fecha_nacimiento DATE,
    id_sexo INT,
    numero VARCHAR(10),
    calle VARCHAR(100),
    ciudad VARCHAR(100),
    FOREIGN KEY (id_sexo) REFERENCES SexoBiologico(id_sexo)
);



INSERT INTO Pacientes (id_paciente, nombre, fecha_nacimiento, id_sexo, numero, calle, ciudad)
VALUES
(DEFAULT,'Juan Pérez', '1990-05-15', 1, '123', 'Avenida Corrientes', 'Buenos Aires'),
(DEFAULT, 'María González', '1985-08-20', 2, '456', 'Calle Florida', ' Buenos Aires'),
(DEFAULT, 'Luis Martínez', '1978-03-10', 1, '789', 'Avenida Santa Fe', 'Buenos Aires'),
(DEFAULT, 'Ana López', '1995-11-02', 2, '1011', 'Calle Lavalle', 'Buenos Aires'),
(DEFAULT, 'Pedro Sánchez', '1980-07-08', 1, '1213', 'Calle Corrientes', 'Buenos Aires '),
(DEFAULT, 'Carolina Rodríguez', '1987-09-25', 2, '1415', 'Calle Libertad', 'Buenos Aires'),
(DEFAULT, 'Miguel García', '1976-01-30', 1, '1617', 'Avenida Rivadavia', 'Buenos  Aires'),
(DEFAULT, 'Sofía Pérez', '1993-04-18', 2, '1819', 'Calle Reconquista', 'Buenos aires'),
(DEFAULT, 'Alejandro Martínez', '1982-06-12', 1, '2021', 'Calle San Martín', 'buenos aires'),
(DEFAULT, 'Laura Sánchez', '1982-11-25', 2, '2223', 'Avenida de Mayo', 'Buenos Aires'),
(DEFAULT, 'Lucía Gómez', '1984-09-17', 2, '2425', 'Avenida Corrientes', 'Buenos Aires'),
(DEFAULT, 'Martín Rodríguez', '1989-12-08', 1, '2627', 'Calle Florida', 'Buenos Aires'),
(DEFAULT, 'Valentina López', '2021-06-23', 2, '2829', 'Avenida Santa Fe', 'Buenos Aires'),
(DEFAULT, 'Gonzalo Martínez', '1992-03-30', 1, '3031', 'Calle Lavalle', 'Buenos Aires'),
(DEFAULT, 'Camila García', '2020-07-12', 2, '3233', 'Calle Corrientes', 'Buenos Aires'),
(DEFAULT, 'Joaquín Sánchez', '1983-10-05', 1, '3435', 'Calle Libertad', 'Buenos Aires'),
(DEFAULT, 'Isabela Pérez', '1979-02-18', 2, '3637', 'Avenida Rivadavia', 'Buenos Aires'),
(DEFAULT, 'Maximiliano Martínez', '1996-05-29', 1, '3839', 'Calle Reconquista', 'Buenos Aires'),
(DEFAULT, 'Florencia Rodríguez', '1981-08-14', 2, '4041', 'Calle San Martín', 'Buenos Aires'),
(DEFAULT, 'Agustín Sánchez', '1988-11-21', 1, '4243', 'Avenida de Mayo', 'Buenos Aires'),
(DEFAULT,'Lucía Gómez', '2023-09-17', 2, '2425', 'Avenida Corrientes', 'Buenos Aires'),
(DEFAULT,'Martín Rodríguez', '1989-12-08', 1, '2627', 'Calle Florida', 'Buenos Aires'),
(DEFAULT,'Valentina López', '1975-06-23', 2, '2829', 'Avenida Santa Fe', 'Buenos Aires'),
(DEFAULT,'Gonzalo Martínez', '1992-03-30', 1, '3031', 'Calle Lavalle', 'Buenos Aires'),
(DEFAULT,'Camila García', '1987-07-12', 2, '3233', 'Calle Corrientes', 'Buenos Aires'),
(DEFAULT,'Joaquín Sánchez', '1983-10-05', 1, '3435', 'Calle Libertad', 'Buenos Aires'),
(DEFAULT,'Isabela Pérez', '1979-02-18', 2, '3637', 'Avenida Rivadavia', 'Buenos Aires'),
(DEFAULT,'Maximiliano Martínez', '1996-05-29', 1, '3839', 'Calle Reconquista', 'Buenos Aires'),
(DEFAULT,'Florencia Rodríguez', '1981-08-14', 2, '4041', 'Calle San Martín', 'Buenos Aires'),
(DEFAULT,'Agustín Sánchez', '1988-11-21', 1, '4243', 'Avenida de Mayo', 'buenos bires');



ALTER TABLE pacientes
ADD COLUMN nombre_nuevo VARCHAR(255),
ADD COLUMN apellido_nuevo VARCHAR(255);

UPDATE pacientes
SET nombre_nuevo = SUBSTRING(nombre FROM 1 FOR POSITION(' ' IN nombre) - 1),
    apellido_nuevo = SUBSTRING(nombre FROM POSITION(' ' IN nombre) + 1);

ALTER TABLE pacientes
DROP COLUMN nombre;

ALTER TABLE pacientes
RENAME COLUMN nombre_nuevo TO nombre;

ALTER TABLE pacientes
RENAME COLUMN apellido_nuevo TO apellido;

-- Crear la función personalizada mejorada
CREATE OR REPLACE FUNCTION initcap_custom(text) RETURNS text AS $$
BEGIN
    RETURN regexp_replace(initcap(regexp_replace(trim($1), '\s+', ' ', 'g')), '\s+', ' ', 'g');
END;
$$ LANGUAGE plpgsql;

-- Actualizar la columna `ciudad`
UPDATE pacientes
SET ciudad = initcap_custom(ciudad);

UPDATE pacientes SET ciudad = 'Buenos Aires' WHERE ciudad LIKE '%Buenos%' 

select * from pacientes;

UPDATE pacientes
SET ciudad = 'Chubut'
WHERE id_paciente IN (17, 18, 19, 20, 21, 22, 28);

UPDATE pacientes
SET ciudad = 'Catamarca'
WHERE id_paciente IN (24, 25, 26);

UPDATE pacientes
SET ciudad = 'La Pampa'
WHERE id_paciente IN (29);

SELECT nombre,
       apellido,
       calle || ' ' || numero AS direccion
FROM pacientes
WHERE ciudad = 'Buenos Aires';

