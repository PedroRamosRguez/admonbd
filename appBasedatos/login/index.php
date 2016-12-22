<!DOCTYPE html>
<html>
    <head>
        <title>Aplicacion Base Datos</title>
        <!--Import Google Icon Font-->
        <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <!--Import materialize.css-->
        <link type="text/css" rel="stylesheet" href="../css/materialize.min.css"  media="screen,projection"/>
        <link type="text/css" rel="stylesheet" href="../css/mystyle.css">
        <!--Let browser know website is optimized for mobile-->
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>    
    </head>
    <body>  
        <div class="container">
          <div class="row">
              
              <form id="form_login" class="col s10" method="post">
                <div class="row">
                  <div class="input-field col s6">
                    <input id="email" type="email" name ="email" class="validate">
                    <label for="email">Email</label>
                  </div>
                </div>
                <div class="row">
                  <div class="input-field col s6">
                    <input id="password" type="password" name = "passwd" class="validate">
                    <label for="password">Password</label>
                  </div>
                </div>
                <div class="row">
                  <div class="input-field col s6">
                    <button class="btn waves-effect waves-light" type="submit" name="action" action="index.php">Submit
                    <i class="material-icons right">send</i>
                    </button>
                  </div>
                </div>
              </form>
            </div>  
        </div>
        
        <?php
        include("conexion.php");
        
        $_POST['passwd']= md5($_POST['passwd']);
        $datos= $_POST;
        
        if(!empty($_POST['email']) && !empty($_POST["passwd"]) && isset($_POST['email']) && isset($_POST["passwd"]))
        {
            $email = $_POST['email'];
            $passwd = $_POST["passwd"];
            $email = filter_var($email, FILTER_VALIDATE_EMAIL );
            $email = filter_var($email, FILTER_SANITIZE_EMAIL);
            $email= filter_var($email, FILTER_SANITIZE_SPECIAL_CHARS);
               
            $sql = "SELECT * FROM UsuarioDeClaseAdmin 
                    where AdminBaseDatosUsuario = '".$email."' AND DatosBaseAdminPasswd ='".$passwd."' LIMIT 1";
            $query = mysql_query ($sql);
                        
            if($query && mysql_num_rows($query) >0)
            {
                 header("Location: ../index.php");
            }
             else {
                 echo "<h2>Usuario o contraseña erroneo.</h2>";
             }
         }
         //echo $datos;
        /* echo "<pre>";
          print_r ($_POST);
         echo "</pre>";*/
        ?>
            <!--Import jQuery before materialize.js-->
      <script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
      <script type="text/javascript" src="../js/materialize.min.js"></script>
    </body>
</html>