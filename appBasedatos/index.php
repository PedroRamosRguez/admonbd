
<!DOCTYPE html>
<html>
    <head>
      <title>Aplicacion Base Datos</title>
      <link type="text/css" rel="stylesheet" href="css/estilo.css">
      <meta name="viewport" content="width=device-width, initial-scale=1.0"/>  
    </head>
    <body>  
       <div class="login-page">
        <div class="form">
          <form class="login-form" method="post">
            <input id="email" type="email" name ="email" placeholder="username"/>
            <input id="password" type="password" name = "passwd"  placeholder="password"/>
            <button type="submit" name="action" action="principal.php">Login</button>
          </form>
        </div>
      </div>
      <?php
      include("conexion_login.php");
      
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
               header("Location: ./src/principal.php");
          }
           else {
               echo "<h3>Usuario o contraseña erroneo.</h3>";
           }
       }
      ?>
    </body>
</html>