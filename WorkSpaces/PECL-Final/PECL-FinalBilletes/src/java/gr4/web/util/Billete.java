/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gr4.web.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author david
 */
public class Billete {

    private Connection con;

    public Billete(Connection con) {
        this.con = con;
    }
    
    /**
     * Obtiene el codigo de identificacion.
     * @param an
     * @return 
     */
    public static String generarIdentificador(String an) {
        String ide = "";
        for (int i = 0; i <= 5; i++) {
            int numero = (int)(Math.random() * 36);
            ide       += an.charAt(numero);
        }
        return ide;
    }
    
    public int insertBillete(String origen, String destino, String fecha, String id, String dni, String id_trayecto) {
        final String query = "INSERT INTO public.billete(aer_origen, aer_destino, fecha, identificador, id_usuario, id_trayecto) VALUES ('" + origen +"', '" + destino + "', '" + fecha + "', '" + id + "', '" + dni + "', " + id_trayecto + ")";
        int status = 0;
        try {
            Statement stmt = con.createStatement();
            stmt.executeUpdate(query);
            stmt.closeOnCompletion();
        } catch (SQLException ex) {
            Logger.getLogger(Billete.class.getName()).log(Level.SEVERE, null, ex);
            status = -1;
        }
        return status; 
    }
    
    public void createBillete(int id_vuelo, int num_billetes, String dni, float total) {
        final String query      = "SELECT * FROM public.trayecto where id_viaje = " + id_vuelo;
        final String id_bill    = generarIdentificador("ABCDEFGHIJKLMNÑOPQRSTUVWXYZ0123456789");
        try {
            PreparedStatement stmt = con.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                String origen     = rs.getString("aer_origen");
                String destino    = rs.getString("aer_destino");
                String id_trayect = String.valueOf(rs.getInt("id_viaje"));
                String fecha      = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new Date());
                insertBillete(origen, destino, fecha, id_bill, dni, id_trayect);
            }
            new Comprar(con).insertCompra(id_bill, dni, total);
            new Trayectos(con).updateTrayectoPlazas(id_vuelo, num_billetes);
            rs.close();
            stmt.close();
        } catch (SQLException ex) {
            Logger.getLogger(Billete.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public ArrayList<String[]> obtenerBilletesUsuario(String dni){
        ArrayList<String[]>  bill = new ArrayList<>();
        final String query        = "SELECT * FROM public.billete as b NATURAL JOIN public.compras as l WHERE (b.identificador = l.id_compra) and b.id_usuario='" + dni + "'";
        try {
            PreparedStatement stmt = con.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                String origen  = rs.getString("aer_origen");
                String destino = rs.getString("aer_destino");
                String fecha   = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(rs.getTimestamp("fecha"));
                String id      = rs.getString("id_compra");
                String total   = String.valueOf(rs.getFloat("total"));
                bill.add(bill.size(), new String[]{origen, destino, fecha, id, total});
            }
            rs.close();
            stmt.close();
        } catch (SQLException ex) {
            Logger.getLogger(Billete.class.getName()).log(Level.SEVERE, null, ex);
        }
        return bill;
    }
}
