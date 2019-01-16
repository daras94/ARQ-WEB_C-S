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
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author david
 */
public class Trayectos {
    
    private final Connection com;

    public Trayectos(Connection com) {
        this.com = com;
    }
    
    public int insertJourney(String origen, String destino, float precio, String fecha, int plazas) {
        final String query = "INSERT INTO public.trayecto(aer_origen, aer_destino, precio, fecha, plazas) VALUES ('" + origen +"', '" + destino + "', " + precio + ", '" + fecha + "', " + plazas +");";
        int status = 0;
        try {
            Statement stmt = com.createStatement();
            stmt.executeUpdate(query);
            stmt.closeOnCompletion();
        } catch (SQLException ex) {
            Logger.getLogger(Trayectos.class.getName()).log(Level.SEVERE, null, ex);
            status = -1;
        }
        return status; 
    }
    
    public ArrayList<String[]> getTrayectos() {
        final String query              = "SELECT * FROM public.trayecto";
        ArrayList<String[]> aeropuertos = new ArrayList<>();
        try {
            PreparedStatement stmt = com.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                String origen   = rs.getString("aer_origen");
                String destino  = rs.getString("aer_destino");
                String precio   = String.valueOf(rs.getInt("precio"));
                String fecha    = String.valueOf(rs.getDate("fecha"));
                String plazas   = String.valueOf(rs.getInt("plazas"));
                String id_viaje = String.valueOf(rs.getInt("id_viaje"));
                aeropuertos.add(aeropuertos.size(), new String[]{origen, destino, precio, fecha, plazas, id_viaje});
            }
            rs.close();
            stmt.close();
        } catch (SQLException ex) {
            Logger.getLogger(Trayectos.class.getName()).log(Level.SEVERE, null, ex);
        }
        return aeropuertos;
    }
    
    public int deleteTrayecto(int id) {
        final String query = "DELETE FROM public.trayecto WHERE id_viaje = " + id;
        int status = 0;
        try {
            Statement stmt = com.createStatement();
            stmt.executeUpdate(query);
            stmt.closeOnCompletion();
        } catch (SQLException ex) {
            Logger.getLogger(Trayectos.class.getName()).log(Level.SEVERE, null, ex);
            status = -1;
        }
        return status;
    }
    
     public int updateTrayectoPlazas(int id, int num_billetes) {
        final String query = "UPDATE public.trayecto SET plazas= ((select plazas from public.trayecto where id_viaje = " + id + ") - " + num_billetes + ") WHERE id_viaje = " + id;
        int status = 0;
        try {
            Statement stmt = com.createStatement();
            stmt.executeUpdate(query);
            stmt.closeOnCompletion();
        } catch (SQLException ex) {
            Logger.getLogger(Trayectos.class.getName()).log(Level.SEVERE, null, ex);
            status = -1;
        }
        return status;
    }
    
}
