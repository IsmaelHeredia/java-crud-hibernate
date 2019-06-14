<%-- Written by Ismael Heredia in the year 2016 --%>

<%@page import="sistema.funciones.Funciones"%>
<%@page import="sistema.controlador.AccesoDatos"%>
<%@page import="sistema.entity.Proveedores"%>
<%@page import="java.util.ArrayList"%>

<%
    if (request.getParameter("proveedores") != null) {

        AccesoDatos conexion_proveedor = new AccesoDatos();
        Funciones funcion_proveedor = new Funciones();

        Cookie[] cookies_proveedor = request.getCookies();

        if (cookies_proveedor != null) {
            if (funcion_proveedor.validar_cookie(cookies_proveedor)) {

                ArrayList listaProveedores = new ArrayList();

                if (request.getParameter("busqueda") != null) {
                    listaProveedores = conexion_proveedor.listarProveedoresEnTabla(request.getParameter("nombre_buscar"));
                } else {
                    listaProveedores = conexion_proveedor.listarProveedoresEnTabla("");
                }

                int cantidad_proveedores = listaProveedores.size();

                out.println("<div class='panel contenedor panel-default'>");
                out.println("<div class='panel-heading'>Proveedores encontrados : " + cantidad_proveedores + "</div>");
                out.println("<div class='panel-body'>");
                out.println("<form action='?proveedores' class='form-horizontal' method='post' role='form'>");
                out.println("<fieldset>"
                        + "<div class='form-group'>"
                        + "<label for='inputBuscar' class='col-lg-2 control-label'>Nombre</label>"
                        + "<div class='col-lg-10'>"
                        + "<input class='form-control' id='inputBuscar' placeholder='Nombre' name='nombre_buscar' type='text'>"
                        + "</div>"
                        + "</div>"
                        + "<div class='form-group'>"
                        + "<button type='submit' name='busqueda' id='buscar_productos' class='btn btn-primary center-block'>Buscar</button>"
                        + " </div>"
                        + "</fieldset>"
                        + "</div>"
                        + "</form>");

                out.println("</div>");
                out.println("</div>");

                if (request.getParameter("busqueda") != null) {

                    if (cantidad_proveedores == 0) {
                        out.println("<center><b>No se encontraron proveedores</b></center>");
                    } else {

                        out.println("<div class='panel contenedor panel-default'>");
                        out.println("<div class='panel-heading'>Proveedores encontrados : " + cantidad_proveedores + "</div>");
                        out.println("<div class='panel-body'>");

                        out.println("<table class='table table-striped table-hover '>");
                        out.println("<thead>"
                                + "<tr>"
                                + "<th class='fila_proveedor'>Nombre</th>"
                                + "<th class='fila_proveedor'>Direccion</th>"
                                + "<th class='fila_proveedor'>Telefono</th>"
                                + "<th class='fila_proveedor'>Registro</th>"
                                + "<th class='fila_proveedor'>Opción</th>"
                                + "</tr>"
                                + "</thead>");

                        out.println("<tbody>");

                        for (int i = 0; i < listaProveedores.size(); i++) {
                            Proveedores proveedor = (Proveedores) listaProveedores.get(i);
                            int id_proveedor = proveedor.getIdProveedor();
                            String nombre_empresa = proveedor.getNombreEmpresa();
                            String direccion = proveedor.getDireccion();
                            int telefono = proveedor.getTelefono();
                            String fecha_registro = proveedor.getFechaRegistroProveedor();
                            out.println("<tr>");
                            out.println("<td class='filterable-cell fila_proveedor'>" + nombre_empresa + "</td>");
                            out.println("<td class='filterable-cell fila_proveedor'>" + direccion + "</td>");
                            out.println("<td class='filterable-cell fila_proveedor'>" + telefono + "</td>");
                            out.println("<td class='filterable-cell fila_proveedor'>" + fecha_registro + "</td>");
                            out.println("<td class='filterable-cell fila_proveedor'><a href=?proveedores=&editar_proveedor=" + id_proveedor + "><img src='images/edit.png' title='Editar'></a> <a href=Proveedores?borrar_proveedor=" + id_proveedor + "><img src='images/delete.png' title='Borrar'></a></td>");
                            out.println("</tr>");
                        }

                        out.println("</tbody>");
                        out.println("</table>");

                        out.println("</div>");
                        out.println("</div>");
                    }

                }

                if (request.getParameter("editar_proveedor") == null) {

                    out.println("<div class='panel contenedor panel-default'>");
                    out.println("<div class='panel-heading'>Agregar Proveedor</div>");
                    out.println("<div class='panel-body'>");

                    out.println("<form action='Proveedores' class='form-horizontal' method='post' role='form'>");
                    out.println("<fieldset>");
                    out.println("<legend>Datos</legend>");

                    out.println("<div class='form-group' name='form-group-nombre'>"
                            + "<label for='inputNombre' class='col-lg-2 control-label'>Nombre empresa</label>"
                            + "<div class='col-lg-10'>"
                            + "<input class='form-control' id='inputNombre' placeholder='Ingrese nombre empresa' type='text' name='nombre_empresa'>"
                            + "</div>"
                            + "</div>");

                    out.println("<div class='form-group' name='form-group-direccion'>"
                            + "<label for='inputDireccion' class='col-lg-2 control-label'>Direccion</label>"
                            + "<div class='col-lg-10'>"
                            + "<input class='form-control' id='inputDireccion' placeholder='Ingrese direccion' type='text' name='direccion'>"
                            + "</div>"
                            + "</div>");

                    out.println("<div class='form-group' name='form-group-telefono'>"
                            + "<label for='inputTelefono' class='col-lg-2 control-label'>Telefono</label>"
                            + "<div class='col-lg-10'>"
                            + "<input class='form-control' id='inputTelefono' placeholder='Ingrese telefono' type='text' name='telefono'>"
                            + "</div>"
                            + "</div>");

                    out.println("<div class='form-group'>"
                            + "<button type='submit' class='btn btn-primary center-block' name='agregar_proveedor' id='agregar_proveedor'>Agregar</button>"
                            + "</div>");

                    out.println("</fieldset>"
                            + "</form>"
                            + "</div>"
                            + "</div>");

                } else {
                    String id_proveedor = request.getParameter("editar_proveedor");
                    if (funcion_proveedor.valid_number(id_proveedor)) {

                        Proveedores proveedor_load = conexion_proveedor.cargarProveedorEnTabla(Integer.parseInt(id_proveedor));

                        if (proveedor_load.getIdProveedor() > 0) {

                            int id_proveedor_real = proveedor_load.getIdProveedor();
                            String nombre_empresa = proveedor_load.getNombreEmpresa();
                            String direccion = proveedor_load.getDireccion();
                            int telefono = proveedor_load.getTelefono();
                            String fecha_registro = proveedor_load.getFechaRegistroProveedor();

                            out.println("<div class='panel contenedor panel-default'>");
                            out.println("<div class='panel-heading'>Editando al proveedor " + nombre_empresa + "</div>");
                            out.println("<div class='panel-body'>");

                            out.println("<form action='Proveedores' class='form-horizontal' method='post' role='form'>");
                            out.println("<input type='hidden' name='id_proveedor' value='" + id_proveedor_real + "'>");
                            out.println("<fieldset>");
                            out.println("<legend>Datos</legend>");

                            out.println("<div class='form-group' name='form-group-nombre'>"
                                    + "<label for='inputNombre' class='col-lg-2 control-label'>Nombre empresa</label>"
                                    + "<div class='col-lg-10'>"
                                    + "<input class='form-control' id='inputNombre' placeholder='Ingrese nombre empresa' type='text' name='nombre_empresa' value='" + nombre_empresa + "'>"
                                    + "</div>"
                                    + "</div>");

                            out.println("<div class='form-group' name='form-group-direccion'>"
                                    + "<label for='inputDireccion' class='col-lg-2 control-label'>Direccion</label>"
                                    + "<div class='col-lg-10'>"
                                    + "<input class='form-control' id='inputDireccion' placeholder='Ingrese direccion' type='text' name='direccion' value='" + direccion + "'>"
                                    + "</div>"
                                    + "</div>");

                            out.println("<div class='form-group' name='form-group-telefono'>"
                                    + "<label for='inputTelefono' class='col-lg-2 control-label'>Telefono</label>"
                                    + "<div class='col-lg-10'>"
                                    + "<input class='form-control' id='inputTelefono' placeholder='Ingrese telefono' type='text' name='telefono' value='" + telefono + "'>"
                                    + "</div>"
                                    + "</div>");

                            out.println("<div class='form-group'>"
                                    + "<button type='submit' class='btn btn-primary center-block' name='editar_proveedor' id='editar_proveedor'>Editar</button>"
                                    + "</div>");

                            out.println("</fieldset>"
                                    + "</form>"
                                    + "</div>"
                                    + "</div>");

                        } else {
                            out.println(funcion_proveedor.Redirect("Proveedores", "Proveedor inexistente", "error", "administracion.jsp?proveedores"));
                        }
                    } else {
                        out.println(funcion_proveedor.Redirect("Proveedores", "ID invalido", "warning", "administracion.jsp?proveedores"));
                    }
                }

            } else {
                response.sendRedirect("login.jsp");
            }
        } else {
            response.sendRedirect("login.jsp");
        }

    }
%>