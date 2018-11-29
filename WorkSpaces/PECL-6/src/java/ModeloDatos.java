
import java.util.*;
import java.sql.*;

public class ModeloDatos {

    private Connection con;
    private Statement set;
    private ResultSet rs;

    public void abrirConexion() {
        String sURL = "jdbc:odbc:mvc";
        try {
            Class.forName("org.postgresql.Driver");
            con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/WEB", "postgres", "ruben");
            System.out.println("Se ha conectado");
        } catch (Exception e) {
            System.out.println("No se ha conectado");
        }
    }

    public void cerrarConexion() {
        try {
            con.close();
        } catch (Exception e) {
        }
    }

    public int calcularGanancia(String nomCoche, String nombreCircuito) {

        System.out.println("Calculando la ganancia: " + nomCoche + " " + nombreCircuito);

        int ganancia = 0;

        try {

            int numVueltas = 0, numCurvas = 0, gananciaPotenciaCoche = 0;
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT \"nombreCircuito\", ciudad, pais, \"longVueltas\", \"numVueltas\", \"numCurvas\" FROM public.circuitos	WHERE \"nombreCircuito\"= '" + nombreCircuito + "';");

            Statement stmt1 = con.createStatement();
            ResultSet rs1 = stmt1.executeQuery("SELECT \"nomCoche\", \"gananciaPotencia\" FROM public.coches WHERE \"nomCoche\" = '" + nomCoche + "';");

            while (rs.next()) {
                numVueltas = rs.getInt("numVueltas");
                numCurvas = rs.getInt("numCurvas");; // Curvas por cada 
            }
            while (rs1.next()) {
                gananciaPotenciaCoche = rs1.getInt("gananciaPotencia");
            }

            int curvas_totales = numVueltas * numCurvas;

            ganancia = curvas_totales * gananciaPotenciaCoche;

            System.out.println("La ganancia es: " + ganancia);
            return ganancia;

        } catch (Exception e) {
            System.out.println("Error: " + e.toString());
        }

        return 0;

    }

    public void crearCoche(String nomCoche, int gananciaPotencia) {

        try {
            String sql = "INSERT INTO public.coches(\"nomCoche\", \"gananciaPotencia\") VALUES ('" + nomCoche + "', " + gananciaPotencia + ");";
            set = con.createStatement();
            set.executeUpdate(sql);
            rs.close();
            set.close();
        } catch (Exception e) {
            System.out.println("Error: " + e.toString());
        }
    }

    public void crearCircuito(String nombreCircuito, String ciudad, String pais,
            int longVueltas, int numVueltas, int numCurvas) {

        try {

            set = con.createStatement();
            set.executeUpdate(" INSERT INTO public.circuitos(	\"nombreCircuito\", ciudad, pais, \"longVueltas\", \"numVueltas\", \"numCurvas\") "
                    + ""
                    + "VALUES ('" + nombreCircuito + "', '" + ciudad + "', '" + pais + "', '" + longVueltas + "', '" + numVueltas + "', '" + numCurvas + "');");

            rs.close();
            set.close();

        } catch (Exception e) {
            System.out.println("Error: " + e.toString());
        }

    }

}
