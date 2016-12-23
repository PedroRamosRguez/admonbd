<?php
    include("conexion.php");
    $id= $_GET['id'];
    $query = 'delete from Pelicula where Id_pelicula ='.$id;
    $result = mysql_query($query) or die('Consulta fallida: ' . mysql_error());
  
    echo '<h3> Dato borrado</h3>';
    header("Location: /principal.php");
	exit(); 
?>