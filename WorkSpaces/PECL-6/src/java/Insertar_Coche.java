
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;
import java.sql.*;

public class Insertar_Coche extends HttpServlet {

    private ModeloDatos bd;

    public void init(ServletConfig cfg) throws ServletException {
        bd = new ModeloDatos();
        bd.abrirConexion();
    }

    public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        
        
        HttpSession s = req.getSession(true);
        String nomCoche = (String) req.getParameter("nomCoche");
        int gananciaPotencia = Integer.parseInt(req.getParameter("gananciaPotencia"));
        bd.crearCoche(nomCoche, gananciaPotencia);
        
        res.sendRedirect(res.encodeRedirectURL("index.html"));
    }

    public void destroy() {
        bd.cerrarConexion();
        super.destroy();
    }
}