Esta es la tabla creada con los datos provistos del desafío:

Inscritos=# SELECT*FROM inscritos;
 cantidad |   fecha    | fuente
----------+------------+--------
       44 | 2021-01-01 | Blog
       56 | 2021-01-01 | Página
       39 | 2021-02-01 | Blog
       81 | 2021-02-01 | Página
       12 | 2021-03-01 | Blog
       91 | 2021-03-01 | Página
       48 | 2021-04-01 | Blog
       45 | 2021-04-01 | Página
       55 | 2021-05-01 | Blog
       33 | 2021-05-01 | Página
       18 | 2021-06-01 | Blog
       12 | 2021-06-01 | Página
       34 | 2021-07-01 | Blog
       24 | 2021-07-01 | Página
       83 | 2021-08-01 | Blog
       99 | 2021-08-01 | Página
(16 filas)




¿Cuántos registros hay? (Contar)

inscritos=# SELECT COUNT(*) FROM inscritos;

 count
-------
    16
(1 fila)




¿Cuántos inscritos hay en total?

inscritos=# SELECT SUM(cantidad) AS total_inscritos FROM inscritos;


 total_inscritos
-----------------
             774
(1 fila)




¿Cuál o cuales son los registros de mayor antiguedad?


inscritos=# SELECT * FROM inscritos WHERE fecha = (SELECT MIN(fecha) FROM inscritos);

 cantidad |   fecha    | fuente
----------+------------+--------
       44 | 2021-01-01 | Blog
       56 | 2021-01-01 | Página
(2 filas)





¿Cuantos inscritos hay por día?


inscritos=# SELECT fecha, SUM(cantidad) AS total_inscritos_por_dia FROM inscritos GROUP BY fecha;

   fecha    | total_inscritos_por_dia
------------+-------------------------
 2021-02-01 |                     120
 2021-08-01 |                     182
 2021-05-01 |                      88
 2021-04-01 |                      93
 2021-06-01 |                      30
 2021-07-01 |                      58
 2021-03-01 |                     103
 2021-01-01 |                     100
(8 filas)




¿Cuántos inscritos hay por fuente?


inscritos=# SELECT fuente, SUM(cantidad) AS total_inscritos_por_fuente FROM inscritos GROUP BY fuente;

 fuente | total_inscritos_por_fuente
--------+----------------------------
 Página |                        441
 Blog   |                        333
(2 filas)




¿Qué día se inscribió la mayor cantidad de personas? Y ¿Cuántas personas se
inscribieron en ese día?


inscritos=# SELECT fecha, SUM(cantidad) AS total_inscritos FROM inscritos GROUP BY fecha ORDER BY Tota
l_inscritos DESC LIMIT 1;

   fecha    | total_inscritos
------------+-----------------
 2021-08-01 |             182
(1 fila)





¿Qué días se inscribieron la mayor cantidad de personas utilizando el blog? 
 y ¿Cuántas personas fueron ese día?


inscritos=# SELECT fecha, SUM(cantidad) AS total_inscritos FROM inscritos WHERE fuente = 'Blog' GROUP
BY fecha ORDER BY total_inscritos DESC LIMIT 1;

   fecha    | total_inscritos
------------+-----------------
 2021-08-01 |              83
(1 fila)




¿Cuál es el promedio de personas inscritas por día?


Esta es la respuesta si quisiera saber el promedio general:


inscritos=# SELECT AVG(cantidad) AS promedio_inscritos_por_dia FROM inscritos;

 promedio_inscritos_por_dia
----------------------------
        48.3750000000000000
(1 fila)


Esta es la respuesta si quisieramos saber de cada uno de los días AVG:


inscritos=# SELECT fecha, AVG(cantidad) AS promedio_inscritos_por_dia FROM inscritos GROUP BY fecha OR
DER BY fecha;

   fecha    | promedio_inscritos_por_dia
------------+----------------------------
 2021-01-01 |        50.0000000000000000
 2021-02-01 |        60.0000000000000000
 2021-03-01 |        51.5000000000000000
 2021-04-01 |        46.5000000000000000
 2021-05-01 |        44.0000000000000000
 2021-06-01 |        15.0000000000000000
 2021-07-01 |        29.0000000000000000
 2021-08-01 |        91.0000000000000000
(8 filas)


¿Qué días se inscribieron más de 50 personas?

inscritos=# SELECT fecha, SUM(cantidad) AS total_inscritos FROM inscritos GROUP BY fecha HAVING SUM(cantidad) > 50 ORDER BY fecha;

   fecha    | total_inscritos
------------+-----------------
 2021-01-01 |             100
 2021-02-01 |             120
 2021-03-01 |             103
 2021-04-01 |              93
 2021-05-01 |              88
 2021-07-01 |              58
 2021-08-01 |             182
(7 filas)



¿Cuál es el promedio diario de personas inscritas a partir del tercer día en adelante,
considerando únicamente las fechas posteriores o iguales a la indicada?


inscritos=# SELECT AVG(cantidad) AS promedio_por_dia_depues_del_3 FROM (SELECT fecha, SUM(cantidad) as cantidad FROM inscritos GROUP BY fecha HAVING fecha >= date('2021-01-03'));

 promedio_por_dia_depues_del_3
-------------------------------
           96.2857142857142857
(1 fila)