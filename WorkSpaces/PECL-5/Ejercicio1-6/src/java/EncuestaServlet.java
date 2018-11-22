import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;

public class EncuestaServlet extends HttpServlet {
    Statement mandato = null;
    Connection conexion = null;
    
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        try{    
            Class.forName("org.postgresql.Driver");
            conexion = DriverManager.getConnection("jdbc:postgresql://localhost:5432/WEB", "postgres", "ruben");
            
        }catch (Exception e){
            System.out.println("Problemas al conectar con " + e.toString());
            return;
        }
    }
    
    public void service( HttpServletRequest peticion, HttpServletResponse respuesta ) throws ServletException, IOException {
        
        
        
        ServletOutputStream out = respuesta.getOutputStream();
        respuesta.setContentType("text/html");
        String strNombre = peticion.getParameter("NOMBRE");
        String strEmail = peticion.getParameter("EMAIL");
        String strRespuesta = peticion.getParameter("RESPUESTA");
        
               

        try{
            
            mandato = conexion.createStatement();
            String sql1 = "INSERT INTO public.\"ENCUESTA\"(\"NOMBRE\", \"EMAIL\", \"RESPUESTA\") VALUES ('"+strNombre+"', '"+strEmail+"', '"+strRespuesta+"');";
            
            mandato.executeUpdate(sql1);
            ResultSet resultado = mandato.executeQuery("SELECT public.\"ENCUESTA\".\"RESPUESTA\" FROM public.\"ENCUESTA\"");
            
            int intSI = 0;
            int intNO = 0;
            while(resultado.next()) {
            String resp = resultado.getString("RESPUESTA");
            if(resp.compareTo("SI")==0) intSI++;
            else intNO++;
            }

            out.println("<h2><center>Encuesta Servlet</center></h2>");
            out.println("<BR>Gracias por participar en esta encuesta.");
            out.println("<BR>Los resultados hasta este momento son :");
            out.println("<BR> SI : "+intSI);
            out.println("<BR> NO : "+intNO);
        }catch(Exception e){
            System.out.println(e);
            return;
        }
    }

    public void destroy()
    {
    try
    {
    conexion.close();

    }
    catch(SQLException e)
    {
    System.out.println(e);
    return;
    }
    }
}