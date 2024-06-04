SELECT p.id_paciente, p.nombre, p.apellido, COUNT(r.id_receta) AS recetas_recibidas
FROM pacientes p
JOIN recetas r ON r.id_paciente = p.id_paciente
GROUP BY p.id_paciente, p.nombre, p.apellido
ORDER BY recetas_recibidas DESC;

