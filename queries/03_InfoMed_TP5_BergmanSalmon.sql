SELECT p.nombre, p.apellido, c.fecha, c.diagnostico
FROM pacientes p
JOIN consultas c ON p.id_paciente = c.id_paciente
WHERE c.fecha BETWEEN '2024-06-01' AND '2024-06-30';
