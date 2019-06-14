// Written by Ismael Heredia in the year 2016
package sistema.funciones;

import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import sistema.controlador.AccesoDatos;
import sistema.funciones.Funciones;
import java.security.MessageDigest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Calendar;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.http.Cookie;

public class Funciones {

    public String md5_encode(String text) {
        // Credits : Based on http://www.avajava.com/tutorials/lessons/how-do-i-generate-an-md5-digest-for-a-string.html
        StringBuffer string_now = null;
        try {
            MessageDigest generate = MessageDigest.getInstance("MD5");
            generate.update(text.getBytes());
            byte[] result = generate.digest();
            string_now = new StringBuffer();
            for (byte line : result) {
                string_now.append(String.format("%02x", line & 0xff));
            }
        } catch (Exception e) {
            //
        }
        return string_now.toString();
    }

    public static boolean valid_number(String str) {
        try {
            double d = Double.parseDouble(str);
        } catch (NumberFormatException nfe) {
            return false;
        }
        return true;
    }

    public String convertir_fecha_para_db(String fecha) {
        String date_formatted = "";
        try {
            SimpleDateFormat format_date = new SimpleDateFormat("dd/MM/yyyy");
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            Date date = format_date.parse(fecha);
            date_formatted = formatter.format(date);
        } catch (ParseException ex) {
            //
        }
        return date_formatted;
    }

    public String convertir_fecha_para_usuario(String fecha) {
        String date_formatted = "";
        try {
            SimpleDateFormat format_date = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
            Date date = format_date.parse(fecha);
            date_formatted = formatter.format(date);
        } catch (ParseException ex) {
            //
        }
        return date_formatted;
    }

    public boolean validar_cookie(Cookie[] cookies) {
        boolean respuesta = false;
        AccesoDatos conexion_now = new AccesoDatos();
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("user_login")) {
                String cookie_content = base64_decode(cookie.getValue());
                Pattern regex1 = null;
                Matcher regex2 = null;
                regex1 = Pattern.compile("(.*)-(.*)");
                regex2 = regex1.matcher(cookie_content);
                if (regex2.find()) {
                    String usuario = regex2.group(1);
                    String password = regex2.group(2);
                    if (!"".equals(usuario) && !"".equals(password)) {
                        if (conexion_now.ingreso_usuario(usuario, password)) {
                            respuesta = true;
                        } else {
                            respuesta = false;
                        }
                    } else {
                        respuesta = false;
                    }
                } else {
                    respuesta = false;
                }
            }
        }
        return respuesta;
    }

    public String get_username_cookie(Cookie[] cookies) {
        String respuesta = "";
        AccesoDatos conexion_now = new AccesoDatos();
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("user_login")) {
                String cookie_content = base64_decode(cookie.getValue());
                Pattern regex1 = null;
                Matcher regex2 = null;
                regex1 = Pattern.compile("(.*)-(.*)");
                regex2 = regex1.matcher(cookie_content);
                if (regex2.find()) {
                    String usuario = regex2.group(1);
                    String password = regex2.group(2);
                    if (!"".equals(usuario) && !"".equals(password)) {
                        if (conexion_now.ingreso_usuario(usuario, password)) {
                            respuesta = usuario;
                        } else {
                            respuesta = "desconocido";
                        }
                    } else {
                        respuesta = "desconocido";
                    }
                } else {
                    respuesta = "desconocido";
                }
            }
        }
        return respuesta;
    }

    public boolean validar_cookie_admin(Cookie[] cookies) {
        boolean respuesta = false;
        AccesoDatos conexion_now = new AccesoDatos();
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("user_login")) {
                String cookie_content = base64_decode(cookie.getValue());
                Pattern regex1 = null;
                Matcher regex2 = null;
                regex1 = Pattern.compile("(.*)-(.*)");
                regex2 = regex1.matcher(cookie_content);
                if (regex2.find()) {
                    String usuario = regex2.group(1);
                    String password = regex2.group(2);
                    if (!"".equals(usuario) && !"".equals(password)) {
                        if (conexion_now.ingreso_usuario(usuario, password)) {
                            if (conexion_now.es_admin(usuario)) {
                                respuesta = true;
                            } else {
                                respuesta = false;
                            }
                        } else {
                            respuesta = false;
                        }
                    } else {
                        respuesta = false;
                    }
                } else {
                    respuesta = false;
                }
            }
        }
        return respuesta;
    }

    public String base64_encode(String text) {
        String encoded = "";
        byte[] data;
        try {
            data = text.getBytes("UTF-8");
            encoded = Base64.getEncoder().encodeToString(data);
        } catch (UnsupportedEncodingException ex) {
            //
        }
        return encoded;
    }

    public String base64_decode(String text) {
        byte[] data = Base64.getDecoder().decode(text);
        String decoded = new String(data, StandardCharsets.UTF_8);
        return decoded;
    }

    public String Redirect(String titulo, String contenido, String tipo, String url) {
        String respuesta = "";
        if (!"".equals(titulo) && !"".equals(contenido) && !"".equals(tipo) && !"".equals(url)) {
            respuesta
                    = "<html lang='en'>"
                    + "<head>"
                    + "<link href='dist/sweetalert.css' rel='stylesheet'/>"
                    + "<script src='bootstrap/js/jquery-1.11.2.min.js'></script>"
                    + "<script src='dist/sweetalert-dev.js'></script>"
                    + "</head>"
                    + "<body>"
                    + "<script>"
                    + "swal({"
                    + "title: '" + titulo + "',"
                    + "text: '" + contenido + "',"
                    + "type: '" + tipo + "',"
                    + "html: true,"
                    + "animation: false"
                    + "}, function() {"
                    + "window.location = '" + url + "';"
                    + "});"
                    + "</script>"
                    + "</body>"
                    + "</html>";
        } else {
            respuesta = "";
        }
        return respuesta;
    }

    public String fecha_del_dia() {
        String fecha = new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime());
        return fecha;
    }

}
