package utiles;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Clase para almacenar los registros de los vuelos en la cesta de la compra 
 * @author RMGSB
 */
public class Vuelo {
    
    private String origen;
    private String destino;
    private float precio; 

    public Vuelo(String origen, String destino, float precio) {
        this.origen = origen;
        this.destino = destino;
        this.precio = precio;
    }

    public String getOrigen() {
        return origen;
    }

    public void setOrigen(String origen) {
        this.origen = origen;
    }

    public String getDestino() {
        return destino;
    }

    public void setDestino(String destino) {
        this.destino = destino;
    }

    public float getPrecio() {
        return precio;
    }

    public void setPrecio(float precio) {
        this.precio = precio;
    }
    
    
    
    
}
