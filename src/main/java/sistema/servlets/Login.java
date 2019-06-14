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

@WebServlet(name = "Login", urlPatterns = {"/Login"})
public class Login extends HttpServlet {

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

            // Login
            if (request.getParameter("LogOn") != null) {

                String nombre_usuario = request.getParameter("username");
                String password = request.getParameter("password");

                if (!"".equals(nombre_usuario) && !"".equals(password)) {
                    String password_encoded = funcion.md5_encode(password);
                    if (conexion_now.ingreso_usuario(nombre_usuario, password_encoded)) {
                        String mensaje = "";
                        if (conexion_now.es_admin(nombre_usuario)) {
                            mensaje = "Bienvenido a la administración administrador " + nombre_usuario;
                        } else {
                            mensaje = "Bienvenido a la administración usuario " + nombre_usuario;
                        }
                        Cookie cookie = new Cookie("user_login", funcion.base64_encode(nombre_usuario + '-' + password_encoded));
                        response.addCookie(cookie);

                        out.println(funcion.Redirect("Inicio Sesion", mensaje, "success", "administracion.jsp"));

                    } else {
                        out.println(funcion.Redirect("Inicio Sesion", "Datos invalidos", "error", "login.jsp"));
                    }
                } else {
                    out.println(funcion.Redirect("Inicio Sesion", "Faltan datos", "warning", "login.jsp"));
                }

            } else if (request.getParameter("LogOut") != null) {
                Cookie[] cookies = request.getCookies();
                if (cookies != null) {
                    if (funcion.validar_cookie(cookies)) {
                        Cookie cookie_delete = new Cookie("user_login", "");
                        cookie_delete.setMaxAge(0);
                        response.addCookie(cookie_delete);
                        out.println(funcion.Redirect("Cerrar Sesion", "Las cookies han sido borradas", "success", "login.jsp"));
                    } else {
                        out.println(funcion.Redirect("Cerrar Sesion", "No has iniciando una sesion", "warning", "login.jsp"));
                    }
                } else {
                    out.println(funcion.Redirect("Cerrar Sesion", "No has iniciando una sesion", "warning", "login.jsp"));
                }
            } else {
                RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                rd.include(request, response);
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
