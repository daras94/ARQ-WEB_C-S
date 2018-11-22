import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class FicheroServlet extends HttpServlet {
    StringBuffer mensaje = null;
    FileOutputStream fos = null;
    String[] strTEXTO;

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        FileInputStream fis;
        
        try {
            fis = new FileInputStream("C:\\Users\\solea\\Desktop\\Arquitectura y diseño de sistemas web\\Práctica\\Practica5\\texto.txt");
            mensaje = new StringBuffer();            
            int caracter = 0;
            while ( (caracter = fis.read()) != -1 ) {
                mensaje.append((char)caracter);
            }
            fis.close();
        }
        catch(java.io.IOException e) {
            e.printStackTrace();
        }
        
        try {
            fos = new FileOutputStream("C:\\Users\\solea\\Desktop\\Arquitectura y diseño de sistemas web\\Práctica\\Practica5\\log.txt");
        }
        catch(java.io.IOException e) {
            e.printStackTrace();
        }
    }

    public void service( HttpServletRequest peticion, HttpServletResponse respuesta ) throws ServletException, IOException {
        strTEXTO = peticion.getParameterValues("TEXTO");
        ServletOutputStream out = respuesta.getOutputStream();
        out.println("<p>"+mensaje+"</p>");
        out.println("<p>Su nombre es: "+strTEXTO[0]+"</p>");
        out.close();
        registrar();
    }
    public void destroy() {
        try {
            fos.close();
        }
        catch(java.io.IOException e) {
            e.printStackTrace();
        }
    }

    public synchronized void registrar() {
        try {
            fos.write(strTEXTO[0].getBytes());
        }
        catch(java.io.IOException e) {
            e.printStackTrace();
        }
    }
}