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
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author david
 */
public class Estadisticas {
    
    private Connection con;

    public Estadisticas(Connection con) {
        this.con = con;
    }
    
    public ArrayList<String[]> getEstadisticas(){
        ArrayList<String[]> stadistic = new ArrayList<>();
        final String query            = "SELECT * FROM public.trayecto";
        try {
            PreparedStatement stmt = con.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int cont         = 0;
                float total      = 0;
                String origen    = rs.getString("aer_origen");
                String destino   = rs.getString("aer_destino");
                String id_viaje  = String.valueOf(rs.getInt("id_viaje"));
                Float precio     = rs.getFloat("precio");
                String sub_query = "SELECT * FROM public.billete AS b NATURAL JOIN public.compras AS l WHERE b.identificador =  l.id_compra and (b.aer_origen, b.aer_destino, b.id_trayecto) = ('" + origen + "', '" + destino +"', '" + id_viaje + "')";
                PreparedStatement stmt_sub = con.prepareStatement(sub_query);
                ResultSet rs_sub = stmt_sub.executeQuery();
                while (rs_sub.next()) {
                    cont  += 1;
                    total += rs_sub.getFloat("total");
                }
                rs_sub.close();
                stmt_sub.close();
                stadistic.add(stadistic.size(), new String[]{id_viaje, origen, destino, String.valueOf(cont), String.valueOf(total), String.valueOf(total - (precio * cont))});
            }
            rs.close();
            stmt.close();
        } catch (SQLException ex) {
            Logger.getLogger(Estadisticas.class.getName()).log(Level.SEVERE, null, ex);
        }
        return stadistic;
    }
    
}
