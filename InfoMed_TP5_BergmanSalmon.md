# Trabajo Práctico N°5

## Autores

* Julián Bergman (Legajo: 61819)
* Pablo Salmon (Legajo: 61559)

## Parte 1: Bases de Datos

### 1. ¿Qué tipo de base de datos es? 

Es una base de datos relacional, ya que contiene información “cruzada” entre las bases de datos. Esto se ve demostrado con que los identificadores de una de las tablas se encuentran en otra de las tablas. Siendo en una tabla Primary Keys y en otra Foreign Keys, que permiten la posibilidad de hacer Joins.

### 2. Armar el diagrama de entidad relación

![Diagrama](link_al_diagrama)

### 3. Considera que la base de datos está normalizada. En caso que no lo esté, ¿cómo podría hacerlo?

No está normalizada del todo. Tiene muchos datos normalizados, en especial los ids que interrelacionan tablas. 
Sin embargo, podrían corregirse ciertos campos:

* Cuestiones de escritura en los datos de la **ciudad** en los pacientes: buenos aires, Buenos Aires y Buenos aires en la misma columna, cosa que debería integrarse en uno solo de los valores.
* También podría separarse en **prefijo, nombre y apellido** el dato del “nombre del médico”, que está ingresado como Dra. Gabriela Fernández, y podría separarse en “Dra”, “Gabriela”, “Fernandez” para futuras operaciones.
* Puede realizarse esto también en la tabla de pacientes, que tiene en la columna nombre el **nombre** y apellido del paciente, y podría separarse en **nombre y apellido**.

## Parte 2: SQL

### 1. Obtener el nombre y la dirección de los pacientes que viven en Buenos Aires.

```
SELECT nombre,
       apellido,
       calle || ' ' || numero AS direccion
FROM pacientes
WHERE ciudad = 'Buenos Aires';
```

![query1](https://drive.google.com/uc?export=view&id=1jCa_wizMr0fArF9fgJJTA_-FPBJZJCJd)

### 2. Obtener la cantidad de recetas emitidas por cada médico.

```
SELECT m.id_medico, m.nombre, COUNT(r.id_receta) AS cantidad_recetas
FROM medicos m
JOIN recetas r ON m.id_medico = r.id_medico
GROUP BY m.nombre, m.id_medico 
ORDER BY cantidad_recetas DESC;
```

![query2](https://drive.google.com/uc?export=view&id=1QDQZAm8GQw1_ow1XfGuM5k6VNKcFTAU_)

### 3. Obtener el nombre de los pacientes junto con la fecha y el diagnóstico de todas las consultas médicas realizadas en junio del 2024.

```
SELECT p.nombre, p.apellido, c.fecha, c.diagnostico
FROM pacientes p
JOIN consultas c ON p.id_paciente = c.id_paciente
WHERE c.fecha BETWEEN '2024-06-01' AND '2024-06-30';
```

![query3](https://drive.google.com/uc?export=view&id=1O5q26qvWJkA28ddk8sKfJRF8d1CGZhVw)

### 4. Obtener el nombre de los medicamentos prescritos más de una vez por el médico con ID igual a 2.

```
SELECT m.nombre, med.nombre, COUNT(r.id_receta) AS veces_prescrito
FROM recetas r
JOIN medicos m ON r.id_medico = m.id_medico
JOIN medicamentos med ON r.id_medicamento = med.id_medicamento
WHERE m.id_medico = 2
GROUP BY m.nombre, med.nombre
HAVING COUNT(r.id_receta) > 1;
```

![query4](https://drive.google.com/uc?export=view&id=1ul-amwPDntVwOBXCdI59j1rEX68WKu4V)

### 5. Obtener el nombre de los pacientes junto con la cantidad total de recetas que han recibido.

```
SELECT p.id_paciente, p.nombre, p.apellido, COUNT(r.id_receta) AS recetas_recibidas
FROM pacientes p
JOIN recetas r ON r.id_paciente = p.id_paciente
GROUP BY p.id_paciente, p.nombre, p.apellido
ORDER BY recetas_recibidas DESC;
```

![query5](https://drive.google.com/uc?export=view&id=1wU98ieruhcqdYATlogJfgNiVchOoBFVQ)

### 6. Obtener el nombre del medicamento más recetado junto con la cantidad de recetas emitidas para ese medicamento.

```
SELECT med.nombre, COUNT(r.id_medicamento) AS veces_recetado
FROM recetas r
JOIN medicamentos med ON r.id_medicamento = med.id_medicamento
GROUP BY med.nombre
ORDER BY veces_recetado DESC
LIMIT 1;
```

![query6]()

### 7. Obtener el nombre del paciente junto con la fecha de su última consulta y el diagnóstico asociado.

```
SELECT p.id_paciente, p.nombre, p.apellido, c.fecha, c.diagnostico
FROM pacientes p
JOIN consultas c ON p.id_paciente = c.id_paciente
WHERE c.fecha = (
	SELECT MAX(fecha) 
	FROM consultas 
	WHERE id_paciente = p.id_paciente)
ORDER BY id_paciente ASC;
```

![query7](https://drive.google.com/uc?export=view&id=1p2VgS3WQrTiQuVBB_eoO57FPzTaBO_K0)

### 8. Obtener el nombre del médico junto con el nombre del paciente y el número total de consultas realizadas por cada médico para cada paciente, ordenado por médico y paciente.

```
SELECT 	
	m.nombre AS nombre_medico, 
	CONCAT(p.nombre, ' ', p.apellido) AS nombre_completo_paciente, 
	COUNT(c.id_consulta) AS total_consultas_con_el_medico
FROM medicos m
JOIN consultas c ON m.id_medico = c.id_medico
JOIN pacientes p ON c.id_paciente = p.id_paciente
GROUP BY m.nombre, p.nombre, p.apellido
ORDER BY m.nombre, nombre_completo_paciente;
```

![query8](https://drive.google.com/uc?export=view&id=1pEaOGkztfGNw3MzZ7js9dbV_rt-Oeqxg)

### 9. Obtener el nombre del medicamento junto con el total de recetas prescritas para ese medicamento, el nombre del médico que lo recetó y el nombre del paciente al que se le recetó, ordenado por total de recetas en orden descendente.

**Nota:** Se interpreta que tenemos que mostrar cada medicamento con el total de recetas prescritas, el nombre del médico que lo recetó cada vez y el nombre del paciente que lo recibió. Ordenado por total de recetas en orden descendente.

```
WITH total_recetas_por_medicamento AS (
    SELECT 
        id_medicamento, 
        COUNT(*) AS total_recetas
    FROM 
        recetas
    GROUP BY 
        id_medicamento
)
SELECT 
    med.nombre AS medicamento,
    tr.total_recetas,
    medicos.nombre AS nombre_medico,
    CONCAT(pacientes.nombre, ' ', pacientes.apellido) AS nombre_completo_paciente
FROM 
    recetas
JOIN 
    medicamentos med ON recetas.id_medicamento = med.id_medicamento
JOIN 
    medicos ON recetas.id_medico = medicos.id_medico
JOIN 
    pacientes ON recetas.id_paciente = pacientes.id_paciente
JOIN 
    total_recetas_por_medicamento tr ON recetas.id_medicamento = tr.id_medicamento
ORDER BY 
    tr.total_recetas DESC;
```

![query9](https://drive.google.com/uc?export=view&id=1h7R3kL3Yhh1Chd-zNnC5Cu25msDlNiAO)

### 10. Obtener el nombre del médico junto con el total de pacientes a los que ha atendido, ordenado por el total de pacientes en orden descendente.

**Nota:** Se entiende por "total de pacientes a los que ha atendido" a los pacientes DIFERENTES que atendió cada médico. Pues si no el encunciado debería decir: cantidad de consultas realizadas.
```
SELECT
  me.nombre AS nombre_medico,
  COUNT(DISTINCT pa.id_paciente) AS total_pacientes_atendidos
FROM consultas c
JOIN medicos me ON c.id_medico = me.id_medico
JOIN pacientes pa ON c.id_paciente = pa.id_paciente
GROUP BY me.nombre
ORDER BY total_pacientes_atendidos DESC;
```

![query10](https://drive.google.com/uc?export=view&id=1W3GClDCZ5r9U9ypKEBWSVXjGprSETf3Q)
