package Servlets;

/**@author solea*/

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utiles.ModeloDatos;

public class MostrarBilletes extends HttpServlet {

    private ModeloDatos bd;

    public void init(ServletConfig cfg) throws ServletException {
        bd = new ModeloDatos();
        bd.abrirConexion();
    }
    
    
    public void destroy() {
        bd.cerrarConexion();
        super.destroy();
    }
    
    public void service(HttpServletRequest peticion, HttpServletResponse respuesta) throws ServletException, IOException {
        try {
            HttpSession s = peticion.getSession(true);
            //Hay que coger la fecha de ida, la fecha de vuelta, el aeropuerto origen y el aeropuerto destino
            String f_ida="2019/01/15"; //coger de la pagina inicial
            String f_vuelta="2019/01/30";
            String aer_origen="Madrid";
            String aer_destino="Barcelona";
            bd.obtenerBilletes(aer_origen,aer_destino,f_ida,f_vuelta); //pasar por parámetro lo mencionado arriba 
            s.setAttribute("consulta", bd.getResultado());
            respuesta.sendRedirect(respuesta.encodeRedirectURL("listado_billetes.jsp"));
        } catch (Exception e) {
            System.out.println("Error: "+e);
        }
    }
}

