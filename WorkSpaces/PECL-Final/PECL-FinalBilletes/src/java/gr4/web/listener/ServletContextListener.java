/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gr4.web.listener;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebListener;
import javax.sql.DataSource;
import org.springframework.stereotype.Component;

/**
 * Web application lifecycle listener.
 *
 * @author david
 */
@Component
@WebListener
public class ServletContextListener implements javax.servlet.ServletContextListener {

    /**
     * Variables globales.
     */
    private ServletContext servletContext;
    private DataSource pool;                         // Pool PostgreSQL
    private static final String ATTRIBUTE_BBDD = "conexion";
    
    /**
     * 
     * @param sce 
     */
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        this.servletContext = sce.getServletContext();
        /**
         * Incializamos el pool de conexiones y lo guadamos como un atributo de contexto 
         * para que pueda ser recuperada desde nuestros servelt.
         */
        try{
            this.pool = (DataSource) new InitialContext().lookup("java:comp/env/jdbc/postgresql_pecweb"); //Mysql.
            if (this.pool == null){
                throw new ServletException("DataSource desconocida 'postgresql_pecweb'");
            }
            if(servletContext.getAttribute("conexion") == null){
                final Connection con = this.pool.getConnection();
                servletContext.setAttribute(ATTRIBUTE_BBDD, con); //Save conection BD.
            }
        } catch (ServletException | NamingException | SQLException ex) {
            Logger.getLogger(ServletContextListener.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("Error en 'ServletContextListener.java': " + ex.getMessage());
        } 
    }

    /**
     * 
     * @param sce 
     */
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        
    }
    
    /**
     * 
     * @param servletContext
     * @return 
     */
    public static ServletContextListener getInstance(ServletContext servletContext) {
        return (ServletContextListener) servletContext.getAttribute(ATTRIBUTE_BBDD);
    }
}
