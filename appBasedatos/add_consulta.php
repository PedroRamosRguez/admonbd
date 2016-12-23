<?php
    include("conexion.php");
    $nombre = $_GET['Nombre'];
    $Genero = $_GET['Genero'];
    $Director = $_GET['Director'];
    $query = 'INSERT INTO Pelicula(Nombre,Genero,Director) values ("'.$nombre.'","'.$Genero.'","'.$Director.'")';
    $result = mysql_query($query) or die('Consulta fallida: ' . mysql_error());
  
    echo '<h3>Insertados los datos</h3>';
    header("Location: /principal.php");
	exit(); 
?>