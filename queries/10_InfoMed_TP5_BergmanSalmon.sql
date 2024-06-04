/*
Obtener el nombre del médico junto con el total de pacientes a los que ha atendido,
ordenado por el total de pacientes en orden descendente.

Nota: Se entiende por "total de pacientes a los que ha atendido" a los pacientes DIFERENTES 
que atendió cada médico. Pues si no el encunciado debería decir: cantidad de consultas realizadas.
*/

SELECT
  me.nombre AS nombre_medico,
  COUNT(DISTINCT pa.id_paciente) AS total_pacientes_atendidos
FROM consultas c
JOIN medicos me ON c.id_medico = me.id_medico
JOIN pacientes pa ON c.id_paciente = pa.id_paciente
GROUP BY me.nombre
ORDER BY total_pacientes_atendidos DESC;

SELECT
  c.id_consulta, c.id_paciente, c.fecha, 
  me.nombre AS nombre_medico,
  c.diagnostico
FROM consultas c
JOIN medicos me ON c.id_medico = me.id_medico
WHERE me.nombre LIKE '%Carlos García%';
