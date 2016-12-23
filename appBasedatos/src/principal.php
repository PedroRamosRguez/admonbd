<!DOCTYPE html>
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
            <form action="nuevo.php" method="post">
              <input class="btn waves-effect waves-teal lighten-1" type="submit" value="Nuevo"/>
            </form>
            <form action="principal.php" name = "Buscar" method="get">
              <input type="text" name="Buscar" placeholder="Buscar"/>
              <input class="btn waves-effect waves-teal lighten-1" type="submit" value="Buscar"/>
            </form>
            <?php 
            #$_GET['Buscar'] = $_get['Buscar'];
            $bandera = false;
            include("conexion.php");
            $numero_total_resultados=10;
            if (isset($_GET["page"])) { $page  = $_GET["page"]; } else { $page=1; }; 
            $comienzo = ($page-1) * $numero_total_resultados; 
            if(empty($_GET['Buscar'])){
                $sql = "SELECT * FROM Pelicula"; 
                
               // $orderBy = array('Id_pelicula','Nombre', 'Genero', 'Director');
               $order = $_GET['sort'];
               if(!empty($order))
                {
                    $sql .= " ORDER BY $order ASC ";
                }
                $sql .= " LIMIT $comienzo, $numero_total_resultados";
            }//fin if(empty($_GET['Buscar']))
            else{
                $sql = "SELECT * FROM Pelicula  
                        WHERE Nombre LIKE '%".$_GET['Buscar']."%' OR Genero LIKE '%".$_GET['Buscar']."%' OR Director LIKE '%".$_GET['Buscar']."%'";
                $order = $_GET['sort'];
                if(!empty($order))
                {
                        $sql .= " ORDER BY $order ASC ";
                }
                $sql .= " LIMIT $comienzo, $numero_total_resultados";
                
                $bandera = true;
            }
            $query = mysql_query ($sql); //run the query
            ?> 
            <table class="highlight" class="centered">
                <tr>
                    <td></td>
                    <td><a style="color:black;" href="principal.php?sort=Nombre">Nombre</a></td>
                    <td><a style="color:black;" href="principal.php?sort=Genero">Genero</a></td>
                    <td><a style="color:black;" href="principal.php?sort=Director">Director</a></td>
                </tr>    
                
                <?php 
                
                while ($row = mysql_fetch_assoc($query)) { 
                ?> 
                <?php
                
                     echo '<form method=get>';
                     echo '<tr><td style=float:right; ><button class="btn waves-effect brown darken-2" type="submit" formaction="nuevo.php" name = "id" value ="'.$row['Id_pelicula'] .'">Editar</button>
                           <button class="btn waves-effect waves-light red darken-2" type="submit" formaction="borrar.php" name = "id" value ="'.$row['Id_pelicula'] .'">Borrar</button></td><td>'. $row['Nombre'] . "</td>
                           <td style=align:center;>" . $row['Genero'] . "</td><td>" . $row['Director'] . "</td></tr>";
                     echo '</form>';   
                ?>            
                <?php 
                }; //Fin while($row = mysql_fetch_assoc($query))
                ?>     
                </table>
                <?php 
                    if($bandera == false)
                    {
                        $sql = "SELECT * FROM Pelicula" ;
                    }
                    else{
                         $sql = "SELECT * FROM Pelicula  
                            WHERE Nombre LIKE '%".$_GET['Buscar']."%' 
                            OR Genero LIKE '%".$_GET['Buscar']."%' 
                            OR Director LIKE '%".$_GET['Buscar']."%'";
                    }
                    
                    $query = mysql_query($sql); //run the query
                    $total_records = mysql_num_rows($query);  //count number of records
                    $total_pages = ceil($total_records / $numero_total_resultados); 
                    echo '<div id="main" style="float:right;margin:0px 25% 0 0; ">';
                    echo '<ul class="pagination">';
                    echo '<li class="waves-effect">
                          <a href="principal.php?page=1&Buscar='.$_GET['Buscar'].'&sort='.$order.'"><i class="material-icons">chevron_left</i></a></li>';
                          
                    for ($i=1; $i<=$total_pages; $i++) { 
                        echo '<li class="waves-effect">
                              <a href="principal.php?page='.$i.'&Buscar='.$_GET['Buscar'].'&sort='.$order.'">'.$i.'</a></li>'; 
                    }; 
                    echo '<li class="waves-effect"> 
                          <a href="principal.php?page='.$total_pages.'&Buscar='.$_GET['Buscar'].'&sort='.$order.'"><i class="material-icons">chevron_right</i></a></li>';
                    echo '</ul>';
                    echo '</div>';
                    mysql_close();
                ?>
        </div>
          <!--Import jQuery before materialize.js-->
        <script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
        <script type="text/javascript" src="../js/materialize.min.js"></script> 
    </body>
</html>