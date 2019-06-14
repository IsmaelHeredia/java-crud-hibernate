<%-- Written by Ismael Heredia in the year 2016 --%>

<%@page import="sistema.funciones.Funciones"%>
<%@page import="sistema.controlador.AccesoDatos"%>
<%@page import="sistema.entity.Usuarios"%>
<%@page import="java.util.ArrayList"%>

<%
    if (request.getParameter("usuarios") != null) {

        AccesoDatos conexion_usuario = new AccesoDatos();
        Funciones funcion_usuario = new Funciones();

        Cookie[] cookies_usuario = request.getCookies();
        String admin_check = funcion_usuario.get_username_cookie(cookies_usuario);

        if (cookies_usuario != null) {
            if (funcion_usuario.validar_cookie(cookies_usuario)) {
                if (conexion_usuario.es_admin(admin_check)) {
                    ArrayList listaUsuarios = new ArrayList();

                    if (request.getParameter("busqueda") != null) {
                        listaUsuarios = conexion_usuario.listarUsuariosEnTabla(request.getParameter("nombre_buscar"));
                    } else {
                        listaUsuarios = conexion_usuario.listarUsuariosEnTabla("");
                    }

                    int cantidad_usuarios = listaUsuarios.size();

                    out.println("<div class='panel contenedor panel-default'>");
                    out.println("<div class='panel-heading'>Usuarios encontrados : " + cantidad_usuarios + "</div>");
                    out.println("<div class='panel-body'>");
                    out.println("<form action='?usuarios' class='form-horizontal' method='post' role='form'>");
                    out.println("<fieldset>"
                            + "<div class='form-group'>"
                            + "<label for='inputBuscar' class='col-lg-2 control-label'>Nombre</label>"
                            + "<div class='col-lg-10'>"
                            + "<input class='form-control' id='inputBuscar' placeholder='Nombre' name='nombre_buscar' type='text'>"
                            + "</div>"
                            + "</div>"
                            + "<div class='form-group'>"
                            + "<button type='submit' name='busqueda' id='buscar_usuarios' class='btn btn-primary center-block'>Buscar</button>"
                            + " </div>"
                            + "</fieldset>"
                            + "</div>"
                            + "</form>");

                    out.println("</div>");
                    out.println("</div>");

                    if (request.getParameter("busqueda") != null) {

                        if (cantidad_usuarios == 0) {
                            out.println("<center><b>No se encontraron usuarios</b></center>");
                        } else {

                            out.println("<div class='panel contenedor panel-default'>");
                            out.println("<div class='panel-heading'>Usuarios encontrados : " + cantidad_usuarios + "</div>");
                            out.println("<div class='panel-body'>");

                            out.println("<table class='table table-striped table-hover '>");
                            out.println("<thead>"
                                    + "<tr>"
                                    + "<th class='fila_usuario'>Nombre</th>"
                                    + "<th class='fila_usuario'>Tipo</th>"
                                    + "<th class='fila_usuario'>Registro</th>"
                                    + "<th class='fila_usuario'>Opción</th>"
                                    + "</tr>"
                                    + "</thead>");

                            out.println("<tbody>");

                            for (int i = 0; i < listaUsuarios.size(); i++) {
                                Usuarios usuario_load = (Usuarios) listaUsuarios.get(i);
                                int id_usuario = usuario_load.getIdUsuario();
                                String nombre_usuario = usuario_load.getUsuario();
                                String password = usuario_load.getClave();
                                int tipo = usuario_load.getTipo();
                                String fecha_registro = usuario_load.getFechaRegistro();
                                String tipo_nombre = "";
                                if (tipo == 1) {
                                    tipo_nombre = "Administrador";
                                } else {
                                    tipo_nombre = "Usuario";
                                }
                                out.println("<tr>");
                                out.println("<td class='filterable-cell fila_usuario'>" + nombre_usuario + "</td>");
                                out.println("<td class='filterable-cell fila_usuario'>" + tipo_nombre + "</td>");
                                out.println("<td class='filterable-cell fila_usuario'>" + fecha_registro + "</td>");
                                out.println("<td class='filterable-cell fila_usuario'><a href=?usuarios=&editar_usuario=" + id_usuario + "><img src='images/edit.png' title='Editar'></a> <a href=Usuarios?borrar_usuario=" + id_usuario + "><img src='images/delete.png' title='Borrar'></a></td>");
                                out.println("</tr>");
                            }

                            out.println("</tbody>");
                            out.println("</table>");

                            out.println("</div>");
                            out.println("</div>");
                        }

                    }

                    if (request.getParameter("editar_usuario") == null) {

                        out.println("<div class='panel contenedor panel-default'>");
                        out.println("<div class='panel-heading'>Agregar Usuario</div>");
                        out.println("<div class='panel-body'>");

                        out.println("<form action='Usuarios' class='form-horizontal' method='post' role='form'>");
                        out.println("<fieldset>");
                        out.println("<legend>Datos</legend>");

                        out.println("<div class='form-group' name='form-group-nombre'>"
                                + "<label for='inputNombre' class='col-lg-2 control-label'>Nombre usuario</label>"
                                + "<div class='col-lg-10'>"
                                + "<input class='form-control' id='inputNombre' placeholder='Ingrese nombre usuario' type='text' name='nombre_usuario'>"
                                + "</div>"
                                + "</div>");

                        out.println("<div class='form-group' name='form-group-password'>"
                                + "<label for='inputPrecio' class='col-lg-2 control-label'>Password</label>"
                                + "<div class='col-lg-10'>"
                                + "<input class='form-control' id='inputPassword' placeholder='Ingrese password' type='password' name='password'>"
                                + "</div>"
                                + "</div>");

                        out.println("<div class='form-group' name='form-group-tipo'>"
                                + "<label for='select' class='col-lg-2 control-label'>Tipo</label>"
                                + "<div class='col-lg-10'>"
                                + "<select class='form-control' id='select' name='tipo'>"
                                + "<option value='2'>Usuario</option>"
                                + "<option value='1'>Administrador</option>"
                                + "</select>"
                                + "</div>"
                                + "</div>");

                        out.println("<div class='form-group'>"
                                + "<button type='submit' class='btn btn-primary center-block' name='agregar_usuario' id='agregar_usuario'>Agregar</button>"
                                + "</div>");

                        out.println("</fieldset>"
                                + "</form>"
                                + "</div>"
                                + "</div>");

                    } else {
                        String id_usuario = request.getParameter("editar_usuario");
                        if (funcion_usuario.valid_number(id_usuario)) {

                            Usuarios usuario_load = conexion_usuario.cargarUsuarioEnTabla(Integer.parseInt(id_usuario));

                            if (usuario_load.getIdUsuario() > 0) {

                                int id_usuario_real = usuario_load.getIdUsuario();
                                String nombre_usuario = usuario_load.getUsuario();
                                String password = usuario_load.getClave();
                                int tipo = usuario_load.getTipo();
                                String fecha_registro = usuario_load.getFechaRegistro();
                                String tipo_nombre = "";
                                if (tipo == 1) {
                                    tipo_nombre = "Administrador";
                                } else {
                                    tipo_nombre = "Usuario";
                                }

                                out.println("<div class='panel contenedor panel-default'>");
                                out.println("<div class='panel-heading'>Editando al usuario " + nombre_usuario + "</div>");
                                out.println("<div class='panel-body'>");

                                out.println("<form action='Usuarios' class='form-horizontal' method='post' role='form'>");
                                out.println("<input type='hidden' name='id_usuario' value='" + id_usuario_real + "'>");
                                out.println("<fieldset>");
                                out.println("<legend>Datos</legend>");

                                out.println("<div class='form-group' name='form-group-nombre'>"
                                        + "<label for='inputNombre' class='col-lg-2 control-label'>Nombre usuario</label>"
                                        + "<div class='col-lg-10'>"
                                        + "<input class='form-control' id='inputNombre' placeholder='Ingrese nombre usuario' type='text' name='nombre_usuario' value='" + nombre_usuario + "' readonly='readonly'>"
                                        + "</div>"
                                        + "</div>");

                                out.println("<div class='form-group' name='form-group-password'>"
                                        + "<label for='inputPrecio' class='col-lg-2 control-label'>Password</label>"
                                        + "<div class='col-lg-10'>"
                                        + "<input class='form-control' id='inputPassword' placeholder='Ingrese password' type='password' name='password' readonly='readonly'>"
                                        + "</div>"
                                        + "</div>");

                                out.println("<div class='form-group' name='form-group-tipo'>"
                                        + "<label for='select' class='col-lg-2 control-label'>Tipo</label>"
                                        + "<div class='col-lg-10'>"
                                        + "<select class='form-control' id='select' name='tipo'>");
                                if (tipo == 1) {
                                    out.println("<option value='2'>Usuario</option>");
                                    out.println("<option value='1' selected='true'>Administrador</option>");
                                } else {
                                    out.println("<option value='2' selected='true'>Usuario</option>");
                                    out.println("<option value='1'>Administrador</option>");
                                }
                                out.println("</select>"
                                        + "</div>"
                                        + "</div>");

                                out.println("<div class='form-group'>"
                                        + "<button type='submit' class='btn btn-primary center-block' name='editar_usuario' id='editar_usuario'>Editar</button>"
                                        + "</div>");

                                out.println("</fieldset>"
                                        + "</form>"
                                        + "</div>"
                                        + "</div>");

                            } else {
                                out.println(funcion_usuario.Redirect("Usuarios", "Usuario inexistente", "error", "administracion.jsp?usuarios"));
                            }
                        } else {
                            out.println(funcion_usuario.Redirect("Usuarios", "ID invalido", "warning", "administracion.jsp?usuarios"));
                        }
                    }
                } else {
                    out.println(funcion_usuario.Redirect("Usuarios", "Acceso Denegado", "error", "administracion.jsp"));
                }
            } else {
                response.sendRedirect("login.jsp");
            }
        } else {
            response.sendRedirect("login.jsp");
        }
    }
%>
