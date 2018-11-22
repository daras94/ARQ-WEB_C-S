//Primer Servlet.
//Muy sencillo.
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class PrimerServlet extends HttpServlet{
    public void doGet (HttpServletRequest req, HttpServletResponse res)throws ServletException, IOException{
        res.setContentType("text/html");
        PrintWriter out = new PrintWriter(res.getOutputStream());
        out.println("<html>");
        out.println("<head><title>HolaMundoServlet</title></head>");
        out.println("<body>");
        out.println("<h1><center>Hola Mundo desde el servidor WEB</center></h1>");
        out.println("</body></html>");
        out.close();
    }
    public String getServletInfo(){
        return "Crea una página HTML que dice HolaMundo";
    }
}
