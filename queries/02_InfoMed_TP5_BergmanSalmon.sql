SELECT * FROM public.consultas
ORDER BY id_consulta ASC LIMIT 100

SELECT * FROM public.recetas
ORDER BY id_receta ASC LIMIT 100

SELECT * FROM public.medicos
ORDER BY id_medico ASC LIMIT 100

SELECT m.id_medico, m.nombre, COUNT(r.id_receta) AS cantidad_recetas
FROM medicos m
JOIN recetas r ON m.id_medico = r.id_medico
GROUP BY m.nombre, m.id_medico 
ORDER BY cantidad_recetas DESC;