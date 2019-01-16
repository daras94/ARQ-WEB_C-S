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
public class Comprar {

    private Connection com;

    public Comprar(Connection com) {
        this.com = com;
    }

    public ArrayList<String[]> validateOneComprar(int id_vuelo, int num_billetes, String dni) {
        ArrayList<String[]> compra = new ArrayList<>();
        String query = "SELECT * FROM public.trayecto INNER JOIN public.aeropuerto ON public.trayecto.aer_origen = public.aeropuerto.nombre where public.trayecto.id_viaje = " + id_vuelo;
        try {
            final int count_bill = countCompras(dni);
            PreparedStatement stmt = com.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                float tasas_origen = rs.getFloat("tasas");
                float precio_bruto = rs.getFloat("precio");
                if (rs.getInt("plazas") >= num_billetes) {
                    float total = precio_bruto + (precio_bruto * (21 + tasas_origen) / 100);
                    if ((count_bill % 3) == 1) {
                        total = total / 2;
                    }
                    compra.add(compra.size(), new String[]{String.valueOf(id_vuelo), String.valueOf(num_billetes), String.valueOf(total)});
                }
            }
            rs.close();
            stmt.close();
        } catch (SQLException ex) {
            Logger.getLogger(Comprar.class.getName()).log(Level.SEVERE, null, ex);
        }
        return compra;
    }

    public ArrayList<String[]> validateFUllComprar(Carrito car, String dni) {
        ArrayList<String[]> compra = new ArrayList<>();
        String query               = null;
        if (!car.getCarro().isEmpty()) {
            for (int i = 0; i < car.getCarro().size(); i++) {
                int num_billetes = car.getCarro().get(i).getNum_bille();
                int id_vuelo     = car.getCarro().get(i).getId_vuelo();
                query = "SELECT * FROM public.trayecto INNER JOIN public.aeropuerto ON public.trayecto.aer_origen = public.aeropuerto.nombre where public.trayecto.id_viaje = " + id_vuelo;
                try {
                    final int count_bill = countCompras(dni);
                    PreparedStatement stmt = com.prepareStatement(query);
                    ResultSet rs = stmt.executeQuery();
                    while (rs.next()) {
                        float tasas_origen = rs.getFloat("tasas");
                        float precio_bruto = rs.getFloat("precio");
                        if (rs.getInt("plazas") >= num_billetes) {
                            float total = (precio_bruto + (precio_bruto * (21 + tasas_origen) / 100)) * num_billetes;
                            if ((count_bill % 3) == 1) {
                                total = total / 2;
                            }
                            compra.add(compra.size(), new String[]{String.valueOf(id_vuelo), String.valueOf(num_billetes), String.valueOf(total)});
                        }
                    }
                    rs.close();
                    stmt.close();
                } catch (SQLException ex) {
                    Logger.getLogger(Comprar.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        return compra;
    }

    public ArrayList<String[]> getCompras(ArrayList<String[]> billete) {
        ArrayList<String[]> compras = new ArrayList<>();
        if (!billete.isEmpty()) {
            for (int i = 0; i < billete.size(); i++) {
                String query = "SELECT * FROM public.trayecto WHERE id_viaje = " + billete.get(i)[0];
                try {
                    PreparedStatement stmt = com.prepareStatement(query);
                    ResultSet rs = stmt.executeQuery();
                    if (rs.next()) {
                        String origen   = rs.getString("aer_origen");
                        String destino  = rs.getString("aer_destino");
                        String precio   = String.valueOf(rs.getInt("precio"));
                        String fecha    = String.valueOf(rs.getDate("fecha"));
                        String num_bill = billete.get(i)[1];
                        String total    = billete.get(i)[2];
                        compras.add(compras.size(), new String[]{origen, destino, precio, fecha, num_bill, total});
                    }
                    rs.close();
                    stmt.close();
                } catch (SQLException ex) {
                    Logger.getLogger(Comprar.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        return compras;
    }

    public int insertCompra(String id, String dni, float total) {
        final String query = "INSERT INTO public.compras(id_usuario, id_compra, total)VALUES ('" + dni + "', '" + id + "', " + total + ")";
        int status = 0;
        try {
            Statement stmt = com.createStatement();
            stmt.executeUpdate(query);
            stmt.closeOnCompletion();
        } catch (SQLException ex) {
            Logger.getLogger(Comprar.class.getName()).log(Level.SEVERE, null, ex);
            status = -1;
        }
        return status;
    }

    public int countCompras(String dni) {
        final String query = "SELECT count(id_compra) FROM public.compras WHERE id_usuario = '" + dni + "'";
        int status = 0;
        try {
            PreparedStatement stmt = com.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                status = rs.getInt("count");
            }
        } catch (SQLException ex) {
            Logger.getLogger(Comprar.class.getName()).log(Level.SEVERE, null, ex);
            status = -1;
        }
        return status;
    }

}
