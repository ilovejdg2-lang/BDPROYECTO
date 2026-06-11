# Instituto Técnico TECNIC — Base de Datos

Este proyecto es la base de datos del Instituto Técnico TECNIC. Aquí se maneja todo lo académico: sedes, aulas, materias, profesores, estudiantes, matrículas, notas, asistencia, horarios y seguridad con bitácora.

Funciona en Microsoft SQL Server. La base de datos se llama InstitutoTECNIC.

## Antes de empezar

Hay que tener creadas estas carpetas en el disco C, si no, algunos scripts no van a correr:

- C:\SQLData — aquí van los archivos de datos
- C:\SQLLOG — aquí va el archivo de log
- C:\SqlBackup — aquí se guardan los respaldos

Sin SQLData y SQLLOG falla el script 1 al crear la base. Sin SqlBackup falla el respaldo del script 6.

## En qué orden ejecutar los scripts

Los scripts van del 1 al 11 y ese es el orden que se entrega al profesor. Hay un duodécimo que no se entrega; es solo para mostrar errores en la presentación.

El 1 crea la base de datos y los filegroups.

El 2 crea las 22 tablas con sus llaves primarias, foráneas, restricciones y demás.

El 3 tiene todos los procedimientos de CRUD, las funciones, la antigüedad de profesores y tutores, y el registro de bitácora.

El 4 trae los procedimientos especiales: consultas con JOINs y el proceso completo de matrícula.

El 5 tiene todos los triggers: auditoría, reglas de negocio y la protección para no borrar registros que tengan relaciones.

El 6 es seguridad: usuarios, roles de base de datos, permisos, logins de SQL Server y el backup.

El 7 inserta los datos de prueba. Ahí está el profesor José Angel Jiménez Torrentes y los cursos como Primer Año.

Del 8 al 11 van las pruebas: consultas, CRUD de sede y aula, seguridad y el flujo de matrícula que sí funciona.


## Usuarios y contraseñas

Dentro de la aplicación, en la tabla Usuario, están estos usuarios de ejemplo:

- admin: Admin#2026 — Administrador
- dinia.medina: Profe#2026 — Profesor
- sofia.mora: Profe#2026 — Profesor
- yeisson.villalobos: Estu#2026 — Estudiante

En SQL Server, el script 6 crea tres logins para probar permisos:

- tecnic_admin: Admin#2026 — rol administrador, control total
- tecnic_profesor: Profe#2026 — rol profesor, puede consultar, poner notas y asistencia
- tecnic_estudiante: Estu#2026 — rol estudiante, puede consultar lo suyo e inscribirse

Los roles de la aplicación (Administrador, Profesor, Estudiante, Usuario) van en la columna rol de la tabla Usuario. No hay tabla Rol aparte porque son pocos y fijos; además están los roles de base de datos de SQL Server para los permisos.

