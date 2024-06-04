SELECT med.nombre, COUNT(r.id_medicamento) AS veces_recetado
FROM recetas r
JOIN medicamentos med ON r.id_medicamento = med.id_medicamento
GROUP BY med.nombre
ORDER BY veces_recetado DESC
LIMIT 1;

