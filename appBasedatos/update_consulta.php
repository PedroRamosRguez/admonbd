<?php
    include("conexion.php");
    $idActualizar = $_GET['id'];
    $nombre = $_GET['Nombre'];
    $Genero = $_GET['Genero'];
    $Director = $_GET['Director'];
    $query = 'update Pelicula set Nombre ="'.$nombre.'", Genero="'.$Genero.'", Director="'.$Director.'" where Id_pelicula ='.$idActualizar;
    $result = mysql_query($query) or die('Consulta fallida: ' . mysql_error());
  
    echo '<h3> Datos actualizados</h3>';
    header("Location: /index.php");
	exit(); 
?>