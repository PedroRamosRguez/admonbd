<html>
    <head>
        <title>Aplicacion Base Datos</title>
        <!--Import Google Icon Font-->
        <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <!--Import materialize.css-->
        <link type="text/css" rel="stylesheet" href="../css/materialize.min.css"  media="screen,projection"/>
        
        <!--Let browser know website is optimized for mobile-->
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    </head>
<body>
    <div class="container">
    <div class="row">
<?php
    $id= $_GET['id'];
    include("conexion.php");
    if($id !=0)//Si es de modificar 
    {
        $query = 'select * from Pelicula where Id_pelicula = '.$id;
        $result = mysql_query($query) or die('Consulta fallida: ' . mysql_error());
        $row = mysql_fetch_array($result);
        $nombre = $row['Nombre'];
        $Genero = $row['Genero'];
        $Director = $row['Director'];
        echo '<h2 class="flow-text center">Actualizando datos</h2>';
        echo'<form class="col s12" method="get" action="update_consulta.php">';
        echo '<div class="row">';
        echo '<div class="input-field col s6">';
        echo '<input type="hidden" name=id value = "'.$id.'"/>';
        echo 'Nombre   :<input type="Text" name="Nombre" value ="'.$nombre.'"/><br>';
        echo '</div>';
        echo '</div>';
        echo '<div class="row">';
        echo '<div class="input-field col s6">';
        echo 'Genero:<input type="Text" name="Genero" value ="'.$Genero.'"/><br>';
        echo '</div>';
        echo '</div>';
        echo '<div class="row">';
        echo '<div class="input-field col s6">';
        echo 'Director :<input type="Text" name="Director" value ="'.$Director.'"/><br>';
        echo '</div>';
        echo '</div>';
        echo '<div class="row center">';
        echo '<div class="input-field col s6">';
        echo '<input class="btn waves-effect waves-teal lighten-1" type="Submit" value="Modificar Pelicula">';
        echo '</div>';
        echo '</div>';
        echo '</form>';
    }
    else {
        echo'<form method="get" action="add_consulta.php">';
        echo 'Nombre   :<input type="Text" name="Nombre"/><br>';
        echo 'Genero:<input type="Text" name="Genero"/><br>';
        echo 'Director :<input type="Text" name="Director"/><br>';
        echo '<input class="btn waves-effect waves-teal lighten-1" type="Submit" value="Agregar Pelicula">';
        echo '</form>';
    }
?>
</div>
</div>
</body>
</html>