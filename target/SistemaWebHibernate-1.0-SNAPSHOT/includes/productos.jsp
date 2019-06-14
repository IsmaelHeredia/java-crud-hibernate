<%-- Written by Ismael Heredia in the year 2016 --%>

<%@page import="sistema.funciones.Funciones"%>
<%@page import="sistema.controlador.AccesoDatos"%>
<%@page import="sistema.entity.Productos"%>
<%@page import="sistema.entity.Proveedores"%>
<%@page import="java.util.ArrayList"%>

<%
    if (request.getParameter("productos") != null) {

        AccesoDatos conexion_producto = new AccesoDatos();
        Funciones funcion_producto = new Funciones();

        Cookie[] cookies_producto = request.getCookies();

        if (cookies_producto != null) {
            if (funcion_producto.validar_cookie(cookies_producto)) {

                ArrayList listaProveedores = conexion_producto.listarProveedoresEnTabla("");

                ArrayList listaProductos = new ArrayList();

                if (request.getParameter("busqueda") != null) {
                    listaProductos = conexion_producto.listarProductosEnTabla(request.getParameter("nombre_buscar"));
                } else {
                    listaProductos = conexion_producto.listarProductosEnTabla("");
                }

                int cantidad_real = listaProductos.size();
                int cantidad_proveedores = listaProveedores.size();
                int cantidad_productos = listaProductos.size();

                out.println("<div class='panel contenedor panel-default'>");
                out.println("<div class='panel-heading'>Productos encontrados : " + cantidad_productos + "</div>");
                out.println("<div class='panel-body'>");
                out.println("<form action='?productos' class='form-horizontal' method='post' role='form'>");
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

                    if (cantidad_real == 0) {
                        out.println("<center><b>No se encontraron productos</b></center>");
                    } else {

                        out.println("<div class='panel contenedor panel-default'>");
                        out.println("<div class='panel-heading'>Productos encontrados : " + cantidad_productos + "</div>");
                        out.println("<div class='panel-body'>");

                        out.println("<table class='table table-striped table-hover '>");
                        out.println("<thead>"
                                + "<tr>"
                                + "<th class='fila_producto'>Nombre</th>"
                                + "<th class='fila_producto'>Descripcion</th>"
                                + "<th class='fila_producto'>Precio</th>"
                                + "<th class='fila_producto'>Proveedor</th>"
                                + "<th class='fila_producto'>Registro</th>"
                                + "<th class='fila_producto'>Opción</th>"
                                + "</tr>"
                                + "</thead>");

                        out.println("<tbody>");

                        for (int i = 0; i < listaProductos.size(); i++) {

                            Productos producto = (Productos) listaProductos.get(i);

                            int id_producto = producto.getIdProducto();
                            String nombre_producto = producto.getNombreProducto();
                            String descripcion = producto.getDescripcion();
                            String descripcion_cortada = "";
                            if (descripcion_cortada.length() >= 15) {
                                descripcion_cortada = descripcion.substring(0, 15);
                            } else {
                                descripcion_cortada = descripcion;
                            }
                            int precio = producto.getPrecio();
                            String fecha_registro = producto.getFechaRegistro();
                            int id_proveedor = producto.getProveedores().getIdProveedor();
                            String nombre_proveedor = conexion_producto.cargarNombreProveedor(id_proveedor);
                            out.println("<tr>");
                            out.println("<td class='filterable-cell fila_producto'>" + nombre_producto + "</td>");
                            out.println("<td class='filterable-cell fila_producto'>" + descripcion_cortada + "</td>");
                            out.println("<td class='filterable-cell fila_producto'>" + precio + "</td>");
                            out.println("<td class='filterable-cell fila_producto'>" + nombre_proveedor + "</td>");
                            out.println("<td class='filterable-cell fila_producto'>" + fecha_registro + "</td>");
                            out.println("<td class='filterable-cell fila_producto'><a href=?productos=&editar_producto=" + id_producto + "><img src='images/edit.png' title='Editar'></a> <a href=Productos?borrar_producto=" + id_producto + "><img src='images/delete.png' title='Borrar'></a></td>");
                            out.println("</tr>");
                        }

                        out.println("</tbody>");
                        out.println("</table>");

                        out.println("</div>");
                        out.println("</div>");

                    }

                }

                if (request.getParameter("editar_producto") == null) {

                    out.println("<div class='panel contenedor panel-default'>");
                    out.println("<div class='panel-heading'>Agregar Producto</div>");
                    out.println("<div class='panel-body'>");

                    out.println("<form action='Productos' class='form-horizontal' method='post' role='form'>");
                    out.println("<fieldset>");
                    out.println("<legend>Datos</legend>");

                    out.println("<div class='form-group' name='form-group-nombre'>"
                            + "<label for='inputNombre' class='col-lg-2 control-label'>Nombre producto</label>"
                            + "<div class='col-lg-10'>"
                            + "<input class='form-control' id='inputNombre' placeholder='Ingrese nombre producto' type='text' name='nombre_producto'>"
                            + "</div>"
                            + "</div>");

                    out.println("<div class='form-group' name='form-group-descripcion'>"
                            + "<label for='textArea' class='col-lg-2 control-label'>Descripcion</label>"
                            + "<div class='col-lg-10'>"
                            + "<textarea class='form-control' rows='3' id='textArea' placeholder='Ingrese descripcion' name='descripcion'></textarea>"
                            + "</div>"
                            + "</div>");

                    out.println("<div class='form-group' name='form-group-precio'>"
                            + "<label for='inputPrecio' class='col-lg-2 control-label'>Precio</label>"
                            + "<div class='col-lg-10'>"
                            + "<input class='form-control' id='inputPrecio' placeholder='Ingrese precio' type='text' name='precio'>"
                            + "</div>"
                            + "</div>");

                    out.println("<div class='form-group' name='form-group-proveedor'>"
                            + "<label for='select' class='col-lg-2 control-label'>Proveedor</label>"
                            + "<div class='col-lg-10'>"
                            + "<select class='form-control' id='select' name='proveedor'>");

                    if (cantidad_proveedores == 0) {
                        out.println("<option value='null'>No se encontraron proveedores</option>");
                    } else {
                        for (int i = 0; i < listaProveedores.size(); i++) {
                            Proveedores proveedor = (Proveedores) listaProveedores.get(i);
                            int id_proveedor = proveedor.getIdProveedor();
                            String nombre_empresa = proveedor.getNombreEmpresa();
                            out.println("<option value='" + id_proveedor + "'>" + nombre_empresa + "</option>");
                        }
                    }

                    out.println("</select>"
                            + "</div>"
                            + "</div>");

                    out.println("<div class='form-group'>"
                            + "<button type='submit' class='btn btn-primary center-block' name='agregar_producto' id='agregar_producto'>Agregar</button>"
                            + "</div>");

                    out.println("</fieldset>"
                            + "</form>"
                            + "</div>"
                            + "</div>");

                } else {
                    String id_producto = request.getParameter("editar_producto");
                    if (funcion_producto.valid_number(id_producto)) {

                        Productos producto_load = conexion_producto.cargarProductoEnTabla(Integer.parseInt(id_producto));

                        if (producto_load.getIdProducto() > 0) {

                            int id_producto_real = producto_load.getIdProducto();
                            String nombre_producto = producto_load.getNombreProducto();
                            String descripcion = producto_load.getDescripcion();
                            int precio = producto_load.getPrecio();
                            String fecha_registro = producto_load.getFechaRegistro();
                            int id_proveedor = producto_load.getProveedores().getIdProveedor();
                            String nombre_proveedor = conexion_producto.cargarNombreProveedor(id_proveedor);

                            out.println("<div class='panel contenedor panel-default'>");
                            out.println("<div class='panel-heading'>Editando al producto " + nombre_producto + "</div>");
                            out.println("<div class='panel-body'>");

                            out.println("<form action='Productos' class='form-horizontal' method='post' role='form'>");

                            out.println("<input type='hidden' name='id_producto' value='" + id_producto_real + "'>");

                            out.println("<fieldset>");
                            out.println("<legend>Datos</legend>");

                            out.println("<div class='form-group' name='form-group-nombre'>"
                                    + "<label for='inputNombre' class='col-lg-2 control-label'>Nombre producto</label>"
                                    + "<div class='col-lg-10'>"
                                    + "<input class='form-control' id='inputNombre' placeholder='Ingrese nombre producto' type='text' name='nombre_producto' value='" + nombre_producto + "'>"
                                    + "</div>"
                                    + "</div>");

                            out.println("<div class='form-group' name='form-group-descripcion'>"
                                    + "<label for='textArea' class='col-lg-2 control-label'>Descripcion</label>"
                                    + "<div class='col-lg-10'>"
                                    + "<textarea class='form-control' rows='3' id='textArea' placeholder='Ingrese descripcion' name='descripcion'>" + descripcion + "</textarea>"
                                    + "</div>"
                                    + "</div>");

                            out.println("<div class='form-group' name='form-group-precio'>"
                                    + "<label for='inputPrecio' class='col-lg-2 control-label'>Precio</label>"
                                    + "<div class='col-lg-10'>"
                                    + "<input class='form-control' id='inputPrecio' placeholder='Ingrese precio' type='text' name='precio' value='" + precio + "'>"
                                    + "</div>"
                                    + "</div>");

                            out.println("<div class='form-group' name='form-group-proveedor'>"
                                    + "<label for='select' class='col-lg-2 control-label'>Proveedor</label>"
                                    + "<div class='col-lg-10'>"
                                    + "<select class='form-control' id='select' name='proveedor'>");

                            if (cantidad_proveedores == 0) {
                                out.println("<option value='null'>No se encontraron proveedores</option>");
                            } else {
                                for (int i = 0; i < listaProveedores.size(); i++) {
                                    Proveedores proveedor = (Proveedores) listaProveedores.get(i);
                                    int id_proveedor_loader = proveedor.getIdProveedor();
                                    String nombre_empresa = proveedor.getNombreEmpresa();
                                    if (id_proveedor == id_proveedor_loader) {
                                        out.println("<option value='" + id_proveedor_loader + "' selected='true'>" + nombre_empresa + "</option>");
                                    } else {
                                        out.println("<option value='" + id_proveedor_loader + "'>" + nombre_empresa + "</option>");
                                    }
                                }
                            }

                            out.println("</select>"
                                    + "</div>"
                                    + "</div>");

                            out.println("<div class='form-group'>"
                                    + "<button type='submit' class='btn btn-primary center-block' name='editar_producto' id='editar_producto'>Editar</button>"
                                    + "</div>");

                            out.println("</fieldset>"
                                    + "</form>"
                                    + "</div>"
                                    + "</div>");

                        } else {
                            out.println(funcion_producto.Redirect("Productos", "Proveedor inexistente", "error", "administracion.jsp?proveedores"));
                        }
                    } else {
                        out.println(funcion_producto.Redirect("Productos", "ID invalido", "warning", "administracion.jsp?proveedores"));
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
