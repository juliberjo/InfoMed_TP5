SELECT m.nombre, med.nombre, COUNT(r.id_receta) AS veces_prescrito
FROM recetas r
JOIN medicos m ON r.id_medico = m.id_medico
JOIN medicamentos med ON r.id_medicamento = med.id_medicamento
WHERE m.id_medico = 2
GROUP BY m.nombre, med.nombre
HAVING COUNT(r.id_receta) > 1;