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
public class Carrito {

    /**
     * @return the carro
     */
    public ArrayList<Vuelos> getCarro() {
        return carro;
    }
    private ArrayList<Vuelos> carro = null;


    public Carrito() {
        this.carro = new ArrayList<>();
    }
    
    public int removeProducto(final int id_trayecto) {
        int status = -2;
        if (!carro.isEmpty()) {
            Loop:for (int i = 0; i < getCarro().size(); i++){
                if (getCarro().get(i).getId_vuelo() == id_trayecto) {
                    getCarro().remove(i);
                    status = 1;
                    break Loop;
                }
            }
        }
        return status;
    }
    
    public int addProducto(final int id_trayecto, int num_billetes) {
        Integer status = 0;
        if (!carro.isEmpty()) {
            Loop:for (int i = 0; i < getCarro().size(); i++){
                if (getCarro().get(i).getId_vuelo() == id_trayecto) {
                    getCarro().get(i).setNum_bille(getCarro().get(i).getNum_bille() + num_billetes);
                    status = -1;
                    break Loop;
                }
            }
        } 
        if (status != -1){
            this.getCarro().add(carro.size(),new Vuelos(id_trayecto, num_billetes));
        } 
        return status;
    }
    
    public Vuelos getBillete(final int id_trayecto) {
        Vuelos vuelo = null;
        if (!carro.isEmpty()) {
            Loop:for (int i = 0; i < carro.size(); i++) {
                if (getCarro().get(i).getId_vuelo() == id_trayecto) {
                    vuelo = getCarro().get(i);
                    break Loop;
                }
            }
        }
        return vuelo;
    }
    
    public ArrayList<String[]> getProductos(Connection com) {
        ArrayList<String[]> aeropuertos = new ArrayList<>();
        if (!carro.isEmpty()) {
            for (int i = 0; i < carro.size(); i++) {
                String query = "SELECT * FROM public.trayecto WHERE id_viaje = " + carro.get(i).getId_vuelo();
                try {
                    PreparedStatement stmt = com.prepareStatement(query);
                    ResultSet rs = stmt.executeQuery();
                    while (rs.next()) {
                        String origen    = rs.getString("aer_origen");
                        String destino   = rs.getString("aer_destino");
                        String precio    = String.valueOf(rs.getInt("precio"));
                        String fecha     = String.valueOf(rs.getDate("fecha"));
                        String num_bille = String.valueOf(carro.get(i).getNum_bille());
                        String id_viaje  = String.valueOf(carro.get(i).getId_vuelo());
                        aeropuertos.add(aeropuertos.size(), new String[]{origen, destino, precio, fecha, num_bille, id_viaje});
                    }
                    rs.close();
                    stmt.close();
                } catch (SQLException ex) {
                    Logger.getLogger(Carrito.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        return aeropuertos;
    }
    
    public class Vuelos {
        private int id_vuelo;
        private int num_bille;

        public Vuelos(int id_vuelo, int num_billetes) {
            this.id_vuelo  = id_vuelo;
            this.num_bille = num_billetes;
        }

        /**
         * @return the id_vuelo
         */
        public int getId_vuelo() {
            return id_vuelo;
        }

        /**
         * @param id_vuelo the id_vuelo to set
         */
        public void setId_vuelo(int id_vuelo) {
            this.id_vuelo = id_vuelo;
        }

        /**
         * @return the num_bille
         */
        public int getNum_bille() {
            return num_bille;
        }

        /**
         * @param num_bille the num_bille to set
         */
        public void setNum_bille(int num_bille) {
            this.num_bille = num_bille;
        }
        
        
        
    }
    
}
