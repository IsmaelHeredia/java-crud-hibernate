<%-- Written by Ismael Heredia in the year 2016 --%>

<%@page import="sistema.funciones.Funciones"%>
<%@page import="sistema.controlador.AccesoDatos"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Index</title>
    </head>
    <body>
        <%

            Funciones funcion = new Funciones();

            Cookie[] cookies = request.getCookies();

            if (cookies != null) {
                if (funcion.validar_cookie(cookies)) {
                    response.sendRedirect("administracion.jsp");
                } else {
                    response.sendRedirect("login.jsp");
                }
            } else {
                    response.sendRedirect("login.jsp");
            }
        %>
    </body>
</html>
