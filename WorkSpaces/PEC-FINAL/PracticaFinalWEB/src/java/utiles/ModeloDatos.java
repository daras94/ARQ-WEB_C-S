package utiles;

import java.util.*;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;

/**
 * Aquí se encontraran todas las funciones que produciran el funcionamiento de nuestra aplicación
 * @author RMGSB
 */
public class ModeloDatos {

    private Connection conexion;
    private Statement mandato;
    private ResultSet resultado;

    public Connection getConexion() {
        return conexion;
    }

    public void setConexion(Connection conexion) {
        this.conexion = conexion;
    }

    public Statement getMandato() {
        return mandato;
    }

    public void setMandato(Statement mandato) {
        this.mandato = mandato;
    }

    public ResultSet getResultado() {
        return resultado;
    }

    public void setResultado(ResultSet resultado) {
        this.resultado = resultado;
    }
    
    
    
    public void obtenerVuelos() {
        try {
            mandato = conexion.createStatement();
            resultado = mandato.executeQuery("SELECT * FROM public.trayecto;");
        } catch (SQLException ex) {
            Logger.getLogger(ModeloDatos.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception e) {
            System.out.println("Ha ocurrido un error al encontrar los vuelos ");
        }

    }

    public void abrirConexion() {

        try {
            Class.forName("org.postgresql.Driver");
            conexion = DriverManager.getConnection("jdbc:postgresql://localhost:5432/TFG", "postgres", "ruben");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ModeloDatos.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(ModeloDatos.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception e) {
            System.out.println("Ha ocurrido un error al conectarse a la BD");
        }

    }

    public void cerrarConexion() {
        try {
            conexion.close();
        } catch (Exception e) {
            System.out.println("Ha ocurrido un error al cerrar la conexión.");
        }
    }

}
