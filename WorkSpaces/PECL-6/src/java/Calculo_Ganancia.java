
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;
import java.sql.*;

public class Calculo_Ganancia extends HttpServlet {

    private ModeloDatos bd;

    public void init(ServletConfig cfg) throws ServletException {
        bd = new ModeloDatos();
        bd.abrirConexion();
    }

    public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        
        
        HttpSession s = req.getSession(true);
        String nombreCircuito = (String) req.getParameter("nombreCircuito");
        String nomCoche = (String) req.getParameter("nomCoche");
        int resultado = bd.calcularGanancia(nomCoche, nombreCircuito);
        
        s.setAttribute("respuesta", resultado);
        System.out.println("Cambiado la respuesta a : " + resultado);
        res.sendRedirect(res.encodeRedirectURL("Resultado.jsp"));
    }

    public void destroy() {
        bd.cerrarConexion();
        super.destroy();
    }
}
