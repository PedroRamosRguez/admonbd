<?php
    $servidor = "localhost";
    $usuario = "root";
    $password = "admin1234";

    // Conectando, seleccionando la base de datos
    $link = mysql_connect($servidor, $usuario, $password)
        or die('No se pudo conectar: ' . mysql_error());
    
    mysql_select_db('bdpeliculas') or die('No se pudo seleccionar la base de datos');
?>