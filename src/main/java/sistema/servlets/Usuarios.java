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

@WebServlet(name = "Usuarios", urlPatterns = {"/Usuarios"})
public class Usuarios extends HttpServlet {

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
            String admin_check = funcion.get_username_cookie(cookies);

            if (cookies != null) {
                if (funcion.validar_cookie(cookies)) {
                    if (conexion_now.es_admin(admin_check)) {

                        if (request.getParameter("agregar_usuario") != null) {
                            String nombre_usuario = request.getParameter("nombre_usuario");
                            String password = request.getParameter("password");
                            int tipo = Integer.parseInt(request.getParameter("tipo"));
                            String fecha_registro = funcion.fecha_del_dia();

                            if (!"".equals(nombre_usuario) && !"".equals(password) && funcion.valid_number(String.valueOf(tipo))) {
                                if (conexion_now.comprobar_existencia_usuario_crear(nombre_usuario)) {
                                    out.println(funcion.Redirect("Usuarios", "El usuario " + nombre_usuario + " ya existe", "warning", "administracion.jsp?usuarios"));
                                } else {
                                    String password_encoded = funcion.md5_encode(password);
                                    if (conexion_now.agregarUsuario(nombre_usuario, password_encoded, tipo, fecha_registro)) {
                                        out.println(funcion.Redirect("Usuarios", "Usuario registrado", "success", "administracion.jsp?usuarios"));
                                    } else {
                                        out.println(funcion.Redirect("Usuarios", "Ha ocurrido un error en la base de datos", "error", "administracion.jsp?usuarios"));
                                    }
                                }
                            } else {
                                out.println(funcion.Redirect("Usuarios", "Faltan datos", "warning", "administracion.jsp?usuarios"));
                            }
                        } else if (request.getParameter("editar_usuario") != null) {
                            int id_usuario = Integer.parseInt(request.getParameter("id_usuario"));
                            String nombre_usuario = request.getParameter("nombre_usuario");
                            int tipo = Integer.parseInt(request.getParameter("tipo"));
                            if (funcion.valid_number(String.valueOf(id_usuario)) && !"".equals(nombre_usuario) && funcion.valid_number(String.valueOf(tipo))) {
                                if (conexion_now.editarUsuario(id_usuario,"","", tipo,"")) {
                                    out.println(funcion.Redirect("Usuarios", "Usuario editado", "success", "administracion.jsp?usuarios"));
                                } else {
                                    out.println(funcion.Redirect("Usuarios", "Ha ocurrido un error en la base de datos", "error", "administracion.jsp?usuarios"));
                                }
                            } else {
                                out.println(funcion.Redirect("Usuarios", "Faltan datos", "warning", "administracion.jsp?usuarios"));
                            }
                        } else if (request.getParameter("borrar_usuario") != null) {
                            int id_usuario = Integer.parseInt(request.getParameter("borrar_usuario"));
                            if (funcion.valid_number(String.valueOf(id_usuario))) {
                                if (conexion_now.borrarUsuario(id_usuario)) {
                                    out.println(funcion.Redirect("Usuarios", "Usuario borrado", "success", "administracion.jsp?usuarios"));
                                } else {
                                    out.println(funcion.Redirect("Usuarios", "Ha ocurrido un error en la base de datos", "error", "administracion.jsp?usuarios"));
                                }
                            } else {
                                out.println(funcion.Redirect("Usuarios", "ID invalido", "warning", "administracion.jsp?usuarios"));
                            }
                        } else {
                            RequestDispatcher rd = request.getRequestDispatcher("administracion.jsp?usuarios");
                            rd.include(request, response);
                        }
                    } else {
                        out.println(funcion.Redirect("Usuarios", "Acceso Denegado", "error", "administracion.jsp"));
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
