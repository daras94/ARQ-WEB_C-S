/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utiles.ModeloDatos;

/**
 *
 * @author AngelaMorenoPrado
 */
public class Mostrar_Estadisticas extends HttpServlet {

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
            bd.obtenerEstadisticas();
            s.setAttribute("consulta", bd.getResultado());
            respuesta.sendRedirect(respuesta.encodeRedirectURL("listado_vuelos.jsp"));
        } catch (Exception e) {
            // Si ocurre algún error
        }
    }

   
}
