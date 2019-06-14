// Written by Ismael Heredia in the year 2016

package sistema.controlador;

import java.sql.Connection;
import java.sql.DriverManager;

public class Conexion {

    public Connection con;

    public void abrir() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost/sistema", "root", "");
            //con = DriverManager.getConnection("jdbc:sqlserver://localhost;integratedSecurity=true;databaseName=Producciones", "", "");
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public void cerrar() {
        if (con != null) {
            try {
                con.close();
            } catch (Exception e) {
                //
            }
        }
    }

    public Connection retornar() {
        return con;
    }

}
