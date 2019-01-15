/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gr4.web.servlet;

import gr4.web.util.Billete;
import gr4.web.util.Carrito;
import gr4.web.util.Comprar;
import gr4.web.util.Trayectos;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.userdetails.UserDetails;

/**
 *
 * @author david
 */
public class ObternerBillete extends HttpServlet {

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
        ArrayList<String[]> compra = (ArrayList<String[]>) request.getSession(true).getAttribute("billete");
        if ((compra != null) && !compra.isEmpty()) {
            Authentication auth = null;
            Connection con      = null;
            String username     = null;
            try {
                auth = ((SecurityContext) request.getSession(true).getAttribute("SPRING_SECURITY_CONTEXT")).getAuthentication();
                con  = (Connection) ctx.getAttribute("conexion");
                car  = (Carrito)request.getSession(true).getAttribute("carro");
                if (auth.isAuthenticated()) {
                    Object principal = auth.getPrincipal();
                    if (principal instanceof UserDetails) {
                        username = ((UserDetails) principal).getUsername();
                    } else {
                        username = principal.toString();
                    }
                    for (int i = 0; i < compra.size(); i++){
                        new Billete(con).createBillete(Integer.valueOf(compra.get(i)[0]), Integer.valueOf(compra.get(i)[1]), username);
                        if (car != null) {
                            car.removeProducto(Integer.valueOf(compra.get(i)[0]));
                        }
                    }
                    request.getSession().removeAttribute("billete");
                }
            } catch (Exception ex) {
                Logger.getLogger(ObternerBillete.class.getName()).log(Level.SEVERE, null, ex);
                status = -1;
            }
        }
        response.sendRedirect(ctx.getContextPath() + this.url + "?status=" + status);
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
