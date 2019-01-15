package utiles;


import java.sql.Date;
import java.util.ArrayList;

/**
 * Clase que utilizaremos en las sesiones para administrar el carro de la compra
 * @author RMGSB
 */
public class Carro {
    
    private ArrayList<Vuelo> vuelos;

    public Carro() {
        vuelos = new ArrayList<>();        
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
    
    public void anadirVueloCesta(String origen, String destino, float precio, Date fecha){
        vuelos.add(new Vuelo(origen,destino,precio, fecha));
    }
    
}
