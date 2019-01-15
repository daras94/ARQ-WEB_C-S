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
public class Aeropuerto {
    
    private Connection com = null;

    public Aeropuerto(Connection com) {
        this.com = com;
    }
    
    public ArrayList<String[]> getAeropuertos() {
        final String query              = "SELECT * FROM public.aeropuerto";
        ArrayList<String[]> aeropuertos = new ArrayList<>();
        try {
            PreparedStatement stmt = com.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                String nombre = rs.getString("nombre");
                String tasas  = String.valueOf(rs.getFloat("tasas"));
                aeropuertos.add(aeropuertos.size(), new String[]{nombre, tasas});
            }
            rs.close();
            stmt.close();
        } catch (SQLException ex) {
            Logger.getLogger(Aeropuerto.class.getName()).log(Level.SEVERE, null, ex);
        }
        return aeropuertos;
    }
   
    public ArrayList<String> getName() {
        final String query = "SELECT * FROM public.aeropuerto";
        ArrayList<String> nombre = new ArrayList<>();
        try {
            PreparedStatement stmt = com.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                nombre.add(nombre.size(), rs.getString("nombre"));
            }
            rs.close();
            stmt.close();
        } catch (SQLException ex) {
            Logger.getLogger(Aeropuerto.class.getName()).log(Level.SEVERE, null, ex);
        }
        return nombre;
    }
    
    public int deleteAeropuerto(String id) {
        final String query = "DELETE FROM public.aeropuerto WHERE nombre = '" + id + "'";
        int status = 0;
        try {
            Statement stmt = com.createStatement();
            stmt.executeUpdate(query);
            stmt.closeOnCompletion();
        } catch (SQLException ex) {
            Logger.getLogger(Aeropuerto.class.getName()).log(Level.SEVERE, null, ex);
            status = -1;
        }
        return status;
    }
    
    public int insertAeropuerto(String name, float tasa) {
        final String query = "INSERT INTO public.aeropuerto(nombre, tasas) VALUES ('" + name + "', " + tasa + ")";
        int status = 0;
        try {
            Statement stmt = com.createStatement();
            stmt.executeUpdate(query);
            stmt.closeOnCompletion();
        } catch (SQLException ex) {
            Logger.getLogger(Aeropuerto.class.getName()).log(Level.SEVERE, null, ex);
            status = -1;
        }
        return status; 
    }
}
