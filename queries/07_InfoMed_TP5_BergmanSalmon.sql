SELECT p.id_paciente, p.nombre, p.apellido, c.fecha, c.diagnostico
FROM pacientes p
JOIN consultas c ON p.id_paciente = c.id_paciente
WHERE c.fecha = (
	SELECT MAX(fecha) 
	FROM consultas 
	WHERE id_paciente = p.id_paciente)
ORDER BY id_paciente ASC;