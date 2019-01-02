package utiles;


import java.util.ArrayList;

/**
 * Clase que utilizaremos en las sesiones para administrar el carro de la compra
 * @author RMGSB
 */
public class Carro {
    
    private ArrayList<Vuelo> vuelos;

    public Carro() {
        vuelos = new ArrayList<Vuelo>();        
    }

    public ArrayList<Vuelo> getVuelos() {
        return vuelos;
    }

    public void setVuelos(ArrayList<Vuelo> vuelos) {
        this.vuelos = vuelos;
    }
    
    public int cantidad_cesta(){
        return vuelos.size();
    }
    
    
}
