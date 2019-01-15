package Servlets;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import utiles.ModeloDatos;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utiles.ModeloDatos;

/**
 *
 * @author RMGSB
 */
public class BilleteNavegador extends HttpServlet {

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
            //HttpSession s = peticion.getSession(true);
            
            System.out.println("Al principio");
            System.out.println("Antes de ruta");
            String ruta = bd.imprimirBillete("Soledad Alvargonzalez","Madrid","Barcelona","2018/22/12");
            System.out.println(ruta);
            //colocamos los resultados de la búsqueda como atributo del request
            peticion.getSession().setAttribute("ruta", ruta);
            peticion.getRequestDispatcher("bill_navegador.jsp").forward(peticion, respuesta);
        
        } catch (Exception e) {
            System.out.println("Excepcion: " + e);
        }
    }

   
}
