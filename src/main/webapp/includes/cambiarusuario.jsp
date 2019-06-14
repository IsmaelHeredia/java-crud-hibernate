<%-- Written by Ismael Heredia in the year 2016 --%>

<%@page import="sistema.funciones.Funciones"%>
<%@page import="sistema.controlador.AccesoDatos"%>

<%

    AccesoDatos conexion_usuario = new AccesoDatos();
    Funciones funcion_usuario = new Funciones();

    Cookie[] cookies_usuario = request.getCookies();
    String username = funcion_usuario.get_username_cookie(cookies_usuario);

    out.println("<div class='panel contenedor panel-default'>");
    out.println("<div class='panel-heading'>Cambiar Usuario</div>");
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

    out.println("<div class='form-group' name='form-group-new-username'>"
            + "<label for='inputNuevo' class='col-lg-2 control-label'>Nuevo usuario</label>"
            + "<div class='col-lg-10'>"
            + "<input class='form-control' id='inputNuevoUsuario' placeholder='Ingrese nuevo usuario' type='text' name='nuevo_usuario'>"
            + "</div>"
            + "</div>");

    out.println("<div class='form-group' name='form-group-password'>"
            + "<label for='inputActual' class='col-lg-2 control-label'>Actual contraseña</label>"
            + "<div class='col-lg-10'>"
            + "<input class='form-control' id='inputPassword' placeholder='Ingrese password' type='password' name='password'>"
            + "</div>"
            + "</div>");

    out.println("<div class='form-group'>"
            + "<button type='submit' class='btn btn-primary center-block' name='cambiar_user' id='cambiar_user'>Cambiar</button>"
            + "</div>");

    out.println("</fieldset>"
            + "</form>"
            + "</div>"
            + "</div>");

%>


