/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gr4.web.servlet;

import com.itextpdf.text.BadElementException;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.text.pdf.draw.LineSeparator;
import gr4.web.util.Billete;
import java.io.IOException;
import java.net.MalformedURLException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author david
 */
public class VerPDFbillete extends HttpServlet {

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
        final String id = request.getParameter("identificador");
        try {
            response.setContentType("application/pdf"); // Code 1
            Document document = new Document();
            Image imagen = Image.getInstance(request.getServletContext().getRealPath("/WEB-INF/res/img/") + "/logo.png");
            Connection con = (Connection) request.getServletContext().getAttribute("conexion");
            try {
                PdfWriter.getInstance(document, response.getOutputStream()); // Code
                document.open();
                document.add(imagen);
                document.add(new LineSeparator());
                final String query = "SELECT * FROM public.billete as b NATURAL JOIN public.compras as l WHERE (b.identificador = l.id_compra) and b.identificador = '" + id + "'";
                try {
                    PreparedStatement stmt = con.prepareStatement(query);
                    ResultSet rs = stmt.executeQuery();
                    while (rs.next()) {
                        document.add(new Paragraph(" - Origen         \t : \t" + rs.getString("aer_origen")));
                        document.add(new Paragraph(" - Destino        \t : \t" + rs.getString("aer_destino")));
                        document.add(new Paragraph(" - Fecha Compra   \t : \t" + new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(rs.getTimestamp("fecha"))));
                        document.add(new Paragraph(" - Indentificador \t : \t" + rs.getString("identificador")));
                        document.add(new Paragraph(" - Tolal :" + String.valueOf(rs.getFloat("total")) + "€"));
                    }
                    rs.close();
                    stmt.close();
                } catch (SQLException ex) {
                    Logger.getLogger(Billete.class.getName()).log(Level.SEVERE, null, ex);
                }
                document.close();
            } catch (DocumentException e) {
                e.printStackTrace();
            }
        } catch (BadElementException ex) {
            Logger.getLogger(VerPDFbillete.class.getName()).log(Level.SEVERE, null, ex);
        } catch (MalformedURLException ex) {
            Logger.getLogger(VerPDFbillete.class.getName()).log(Level.SEVERE, null, ex);
        }
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
