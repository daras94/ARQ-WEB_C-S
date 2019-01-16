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
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author david
 */
public class Perfil {

    private final Connection con;

    public Perfil(Connection con) {
        this.con = con;
    }

    public String[] getInfoUser(String dni) {
        String[] user = new String[]{};
        final String query = "SELECT * FROM public.usuarios";
        try {
            PreparedStatement stmt = con.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                String nombre = rs.getString("nombre");
                String nif = rs.getString("dni");
                user = new String[]{nombre, nif};
            }
            rs.close();
            stmt.close();
        } catch (SQLException ex) {
            Logger.getLogger(Perfil.class.getName()).log(Level.SEVERE, null, ex);
        }
        return user;
    }

    public int insertUser(String nombre, String pass, String dni) {
        int status = 0;
        if (!validateUser(dni)) {
            final String query_01 = "INSERT INTO public.usuarios(nombre, contrasena, DNI, enabled)  VALUES('" + nombre + "', '" + pass + "', '" + dni + "', true);";
            final String query_02 = "INSERT INTO public.authorities(DNI, AUTHORITY) VALUES('" + dni + "', 'ROLE_USER')";
            try {
                Statement stmt = con.createStatement();
                stmt.executeUpdate(query_02);
                stmt.executeUpdate(query_01);
                stmt.closeOnCompletion();
            } catch (SQLException ex) {
                Logger.getLogger(Aeropuerto.class.getName()).log(Level.SEVERE, null, ex);
                status = -1;
            }
        } else {
            status = -2;
        }
        return status;
    }

    public boolean validateUser(String dni) {
        boolean exists = false;
        final String query = "SELECT * FROM public.usuarios as u WHERE u.dni = '" + dni + "'";
        try {
            PreparedStatement stmt = con.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                exists = true;
            }
            rs.close();
            stmt.close();
        } catch (SQLException ex) {
            Logger.getLogger(Perfil.class.getName()).log(Level.SEVERE, null, ex);
        }
        return exists;
    }
}
