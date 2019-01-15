/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gr4.web.servlet;

import gr4.web.util.Carrito;
import gr4.web.util.Comprar;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.ArrayList;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.userdetails.UserDetails;

/**
 *
 * @author david
 */
public class PayFullFlyCarrito extends HttpServlet {

    private Carrito car = null;
    private String url = "/pag/carrito.html";
    private Integer status = 0;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ServletContext ctx = request.getServletContext();
        car                = (Carrito) request.getSession(true).getAttribute("carro");
        String username    = null;
        if (car != null) {
            Object principal     = ((SecurityContext) request.getSession(true).getAttribute("SPRING_SECURITY_CONTEXT")).getAuthentication().getPrincipal();
            if (principal instanceof UserDetails) {
                username = ((UserDetails) principal).getUsername();
            } else {
                username = principal.toString();
            }
            if (!car.getCarro().isEmpty()) {              
                ArrayList<String[]> meta_bill = new Comprar((Connection) ctx.getAttribute("conexion")).validateFUllComprar(car, username);
                if (!meta_bill.isEmpty()) {
                    request.getSession(true).setAttribute("billete", meta_bill);
                    this.url = "/client/end-pay.html";
                } else {
                    status = -5;
                }
            } else {
                status = -4;
            }
        } else {
            status = -3;
        }
        response.sendRedirect(request.getServletContext().getContextPath() + this.url + "?status=" + status);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
