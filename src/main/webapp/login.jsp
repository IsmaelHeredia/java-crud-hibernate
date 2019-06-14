<%-- Written by Ismael Heredia in the year 2016 --%>

<%@page import="sistema.funciones.Funciones"%>
<%@page import="sistema.controlador.AccesoDatos"%>
<%
    Funciones funcion = new Funciones();
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        if (funcion.validar_cookie(cookies)) {
            response.sendRedirect("administracion.jsp");
        }
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Login</title>
        <!-- Bootstrap -->

        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet"/>
        <link href="css/style.css" rel="stylesheet"/>
        <link href="dist/sweetalert.css" rel="stylesheet"/>

        <script src="bootstrap/js/jquery-1.11.2.min.js"></script>
        <script src="bootstrap/js/bootstrap.js"></script>
        <script src="dist/sweetalert-dev.js"></script>

        <script src="js/jquery2.2.0.js"></script>   

        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
              <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
              <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
            <![endif]-->
    </head>
    <script>

        $(document).ready(function () {

            $(document).on('click', '#ingresar', function (e) {

                var username = $("input[name='username']").val();
                var password = $("input[name='password']").val();

                if (username == "") {
                    $("input[name='username']").attr("placeholder", "Falta nombre de usuario");
                    $("div[name='form-group-username']").addClass('has-error');
                    $("input[name='username']").focus();
                    e.preventDefault();
                    return false;
                } else {
                    $("div[name='form-group-username']").addClass('has-success');
                }

                if (password == "") {
                    $("input[name='password']").attr("placeholder", "Falta password");
                    $("div[name='form-group-password']").addClass('has-error');
                    $("input[name='password']").focus();
                    e.preventDefault();
                    return false;
                } else {
                    $("div[name='form-group-password']").addClass('has-success');
                }

            });

        });

    </script>
    <body>
               
        <div class="container-fluid">

            <div class="panel login panel-default">
                <div class="panel-heading">Login</div>
                <div class="panel-body">

                    <form action="Login" name="form_login" class="form-horizontal" method="post" role="form">
                        <fieldset>
                            <legend>Datos</legend>
                            <div class="form-group" name="form-group-username">
                                <label for="inputTexto1" class="col-lg-2 control-label">Username</label>
                                <div class="col-lg-10">
                                    <input class="form-control" id="inputUsername" name="username" placeholder="Ingrese usuario" type="text">
                                </div>
                            </div>
                            <div class="form-group" name="form-group-password">
                                <label for="inputTexto2" class="col-lg-2 control-label">Password</label>
                                <div class="col-lg-10">
                                    <input class="form-control" id="inputPassword" name="password" placeholder="Ingrese password" type="password">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-lg-10 col-lg-offset-2">
                                    <br />
                                    <button type="submit" name="LogOn" id="ingresar" class="btn btn-primary">Ingresar</button>
                                </div>
                            </div>
                        </fieldset>
                    </form>       

                </div>
            </div>

        </div>

    </body>
</html>