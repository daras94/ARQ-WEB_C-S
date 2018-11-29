
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;
import java.sql.*;

public class Insertar_Circuito extends HttpServlet {

    private ModeloDatos bd;

    public void init(ServletConfig cfg) throws ServletException {
        bd = new ModeloDatos();
        bd.abrirConexion();
    }

    public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        
        
        HttpSession s = req.getSession(true);
        String nombreCircuito = (String) req.getParameter("nombreCircuito");
        String ciudad = (String) req.getParameter("ciudad");
        String pais = (String) req.getParameter("pais");
        
        
        int numVueltas = Integer.parseInt(req.getParameter("numVueltas"));
        int longVueltas = Integer.parseInt(req.getParameter("longVueltas"));
        int numCurvas = Integer.parseInt(req.getParameter("numCurvas"));
        bd.crearCircuito(nombreCircuito, ciudad, pais, longVueltas, numVueltas, numCurvas);
        
        res.sendRedirect(res.encodeRedirectURL("index.html"));
    }

    public void destroy() {
        bd.cerrarConexion();
        super.destroy();
    }
}
