// Written by Ismael Heredia in the year 2016

package sistema.servlets;

import sistema.controlador.AccesoDatos;
import sistema.funciones.Funciones;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "Productos", urlPatterns = {"/Productos"})
public class Productos extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            AccesoDatos conexion_now = new AccesoDatos();
            Funciones funcion = new Funciones();

            Cookie[] cookies = request.getCookies();

            if (cookies != null) {
                if (funcion.validar_cookie(cookies)) {

                    if (request.getParameter("agregar_producto") != null) {
                        String nombre_producto = request.getParameter("nombre_producto");
                        String descripcion = request.getParameter("descripcion");
                        int precio = Integer.parseInt(request.getParameter("precio"));
                        int id_proveedor = Integer.parseInt(request.getParameter("proveedor"));
                        String fecha_registro = funcion.fecha_del_dia();
                        if (!"".equals(nombre_producto) && !"".equals(descripcion) && funcion.valid_number(String.valueOf(precio)) && funcion.valid_number(String.valueOf(id_proveedor)) && !"".equals(fecha_registro)) {
                            if (conexion_now.comprobar_existencia_producto_crear(nombre_producto)) {
                                out.println(funcion.Redirect("Productos", "El producto " + nombre_producto + " ya existe", "warning", "administracion.jsp?productos"));
                            } else {
                                if (conexion_now.agregarProducto(nombre_producto, descripcion, precio, id_proveedor, fecha_registro)) {
                                    out.println(funcion.Redirect("Productos", "Producto registrado", "success", "administracion.jsp?productos"));
                                } else {
                                    out.println(funcion.Redirect("Productos", "Ha ocurrido un error en la base de datos", "error", "administracion.jsp?productos"));
                                }
                            }
                        } else {
                            out.println(funcion.Redirect("Producos", "Faltan datos", "warning", "administracion.jsp?productos"));
                        }

                    } else if (request.getParameter("editar_producto") != null) {
                        int id_producto = Integer.parseInt(request.getParameter("id_producto"));
                        String nombre_producto = request.getParameter("nombre_producto");
                        String descripcion = request.getParameter("descripcion");
                        int precio = Integer.parseInt(request.getParameter("precio"));
                        int id_proveedor = Integer.parseInt(request.getParameter("proveedor"));
                        if (funcion.valid_number(String.valueOf(id_producto)) && !"".equals(nombre_producto) && !"".equals(descripcion) && funcion.valid_number(String.valueOf(precio)) && funcion.valid_number(String.valueOf(id_proveedor))) {
                            if (conexion_now.comprobar_existencia_producto_editar(Integer.parseInt(String.valueOf(id_producto)), nombre_producto)) {
                                out.println(funcion.Redirect("Productos", "El producto " + nombre_producto + " ya existe", "warning", "administracion.jsp?productos"));
                            } else {
                                if (conexion_now.editarProducto(id_producto, nombre_producto, descripcion, precio, id_proveedor,"")) {
                                    out.println(funcion.Redirect("Productos", "Producto editado", "success", "administracion.jsp?productos"));
                                } else {
                                    out.println(funcion.Redirect("Productos", "Ha ocurrido un error en la base de datos", "error", "administracion.jsp?productos"));
                                }
                            }
                        } else {
                            out.println(funcion.Redirect("Productos", "Faltan datos", "warning", "administracion.jsp?productos"));
                        }
                    } else if (request.getParameter("borrar_producto") != null) {
                        int id_producto = Integer.parseInt(request.getParameter("borrar_producto"));
                        if (funcion.valid_number(String.valueOf(id_producto))) {
                            if (conexion_now.borrarProducto(id_producto)) {
                                out.println(funcion.Redirect("Productos", "Producto borrado", "success", "administracion.jsp?productos"));
                            } else {
                                out.println(funcion.Redirect("Productos", "Ha ocurrido un error en la base de datos", "error", "administracion.jsp?productos"));
                            }
                        } else {
                            out.println(funcion.Redirect("Productos", "ID invalido", "warning", "administracion.jsp?productos"));
                        }
                    } else {
                        RequestDispatcher rd = request.getRequestDispatcher("administracion.jsp?productos");
                        rd.include(request, response);
                    }

                } else {
                    response.sendRedirect("login.jsp");
                }
            } else {
                response.sendRedirect("login.jsp");
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
