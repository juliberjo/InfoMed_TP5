/* Consigna 9:
Obtener el nombre del medicamento junto con el total de recetas prescritas para ese
medicamento, el nombre del médico que lo recetó y el nombre del paciente al que se
le recetó, ordenado por total de recetas en orden descendente.

Nota: Se interpreta que tenemos que mostrar:
Cada medicamento con el total de recetas prescritas, 
el nombre del médico que lo recetó cada vez y el nombre del paciente que lo recibió. 
Ordenado por total de recetas en orden descendente.
*/
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



