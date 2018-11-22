//
// SegundoServlet.java
//
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
public class SegundoServlet extends HttpServlet
{
String nombre;
public void service( HttpServletRequest peticion, HttpServletResponse
respuesta )
throws ServletException, IOException
{
nombre = peticion.getParameter("NOMBRE");
ServletOutputStream out = respuesta.getOutputStream();
out.println("<html>"); out.println("<head><title>HolaTalServlet</title></head>"); out.println("<body>");
out.println("<p><h1><center>Su nombre es: <B>"+nombre+"</B></center></h1></p>"); out.println("</body></html>");
out.close();
}
}