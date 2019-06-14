<%-- Written by Ismael Heredia in the year 2016 --%>

<%@page import="sistema.funciones.Funciones"%>
<%@page import="sistema.controlador.AccesoDatos"%>

<%

    AccesoDatos conexion_usuario = new AccesoDatos();
    Funciones funcion_usuario = new Funciones();

    Cookie[] cookies_usuario = request.getCookies();
    String username = funcion_usuario.get_username_cookie(cookies_usuario);

    out.println("<div class='panel contenedor panel-default'>");
    out.println("<div class='panel-heading'>Cambiar Password</div>");
    out.println("<div class='panel-body'>");

    out.println("<form action='PerfilUsuario' class='form-horizontal' method='post' role='form'>");
    out.println("<fieldset>");
    out.println("<legend>Datos</legend>");

    out.println("<div class='form-group' name='form-group-username'>"
            + "<label for='inputNombre' class='col-lg-2 control-label'>Usuario</label>"
            + "<div class='col-lg-10'>"
            + "<input class='form-control' id='inputUsuario' placeholder='Ingrese nombre usuario' type='text' name='nombre_usuario' value='" + username + "' readonly='readonly'>"
            + "</div>"
            + "</div>");

    out.println("<div class='form-group' name='form-group-anterior-password'>"
            + "<label for='inputActual' class='col-lg-2 control-label'>Actual contraseña</label>"
            + "<div class='col-lg-10'>"
            + "<input class='form-control' id='inputAnterior' placeholder='Ingrese password' type='password' name='password'>"
            + "</div>"
            + "</div>");

    out.println("<div class='form-group' name='form-group-new-password'>"
            + "<label for='inputActual' class='col-lg-2 control-label'>Nueva contraseña</label>"
            + "<div class='col-lg-10'>"
            + "<input class='form-control' id='inputNuevo' placeholder='Ingrese nuevo password' type='password' name='nuevo_password'>"
            + "</div>"
            + "</div>");

    out.println("<div class='form-group'>"
            + "<button type='submit' class='btn btn-primary center-block' name='cambiar_pass' id='cambiar_pass'>Cambiar</button>"
            + "</div>");

    out.println("</fieldset>"
            + "</form>"
            + "</div>"
            + "</div>");

%>
