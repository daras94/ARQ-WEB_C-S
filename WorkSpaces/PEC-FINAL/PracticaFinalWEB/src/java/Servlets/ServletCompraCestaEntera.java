
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utiles.*;

public class ServletCompraCestaEntera extends HttpServlet {

    public void service(HttpServletRequest peticion, HttpServletResponse respuesta) throws ServletException, IOException {

        HttpSession session = peticion.getSession();
        Carro carro = (Carro) session.getAttribute("carro");

        try {

            if (carro == null) {
                carro = new Carro();
            } else {
                int num_productos = carro.cantidad_cesta();
                if (num_productos == 0) {
                    //out.println("El carro se encuentra vacio");
                } else {
                    
                    for (int i = 0; i < num_productos; i++) {
                        
                        
                            // Aquí paso a la validación de Carlos de la tarjeta 
                            
                       
                       
                        
                    }
                    
                    
                }

            }

        } catch (Exception en) {
            System.out.println(en);
            return;
        }
    }

}
