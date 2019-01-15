/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

/**
 *
 * @author solea
 */
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utiles.*;

public class ServletAnadirCesta extends HttpServlet {

    public void service(HttpServletRequest peticion, HttpServletResponse respuesta) throws ServletException, IOException {
        HttpSession session = peticion.getSession();
        Carro carro = (Carro) session.getAttribute("carro");
        String aer_origen = peticion.getParameter("origen");
        String aer_destino = peticion.getParameter("dest");
        String id = peticion.getParameter("id");
        String p = peticion.getParameter("precio");
        float precio = Float.parseFloat(p);
        String fecha = peticion.getParameter("fecha");
        carro.anadirVueloCesta(aer_origen,aer_destino,precio,fecha);
    }
    
}
