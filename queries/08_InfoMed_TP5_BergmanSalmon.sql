SELECT 	
	m.nombre AS nombre_medico, 
	CONCAT(p.nombre, ' ', p.apellido) AS nombre_completo_paciente, 
	COUNT(c.id_consulta) AS total_consultas_con_el_medico
FROM medicos m
JOIN consultas c ON m.id_medico = c.id_medico
JOIN pacientes p ON c.id_paciente = p.id_paciente
GROUP BY m.nombre, p.nombre, p.apellido
ORDER BY m.nombre, nombre_completo_paciente;