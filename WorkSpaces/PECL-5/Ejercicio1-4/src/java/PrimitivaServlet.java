//
// PrimitivaServlet.java
//
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
public class PrimitivaServlet extends HttpServlet
{
int primi[] = new int[6], combiUsuario[] = new int[6];
int i, contador=0, aux, aciertos=0;
Random rand = new Random();
public void init(ServletConfig config) throws ServletException
{
super.init(config);
//generamos los números
while (contador<6)
{
aux = rand.nextInt(48) + 1;
if (!comprueba(primi,aux))
{
primi[contador] = aux;
contador++;
}
}
//ordenamos el array
Arrays.sort(primi);
}
private boolean comprueba(int array[], int num)
{
for (int i=0; i<=5; i++)
{
if (primi[i]==num) return true;
}
return false;
}
public void service( HttpServletRequest peticion, HttpServletResponse
respuesta )
throws ServletException, IOException
{
aciertos=0;
ServletOutputStream out = respuesta.getOutputStream();
combiUsuario[0] =
Integer.parseInt(peticion.getParameter("NUM1"));
combiUsuario[1] =
Integer.parseInt(peticion.getParameter("NUM2"));
combiUsuario[2] =
Integer.parseInt(peticion.getParameter("NUM3"));
combiUsuario[3] =
Integer.parseInt(peticion.getParameter("NUM4"));
combiUsuario[4] =
Integer.parseInt(peticion.getParameter("NUM5"));
combiUsuario[5] =
Integer.parseInt(peticion.getParameter("NUM6"));
out.println("<h2><center>Primitiva Servlet</center></h2>");
//imprimimos todos los números de la combinación del usuario
out.print("<p>Tu combinación es:</p><B>");
for (i=0; i<6; i++)
{
out.print(" "+combiUsuario[i]);
}
out.print("</B>");
//comprobamos la combinación
for (i=0; i<=5; i++)
{
if (Arrays.binarySearch(primi,combiUsuario[i])>=0)
{
out.println("<p>Número acertado:<B>"+combiUsuario[i]+"</B></p>");
aciertos++;
}
}
out.println("<p>Números acertados: <B>"+aciertos+"</B></p>");
//imprimimos todos los números de la combinación ganadora
out.print("<p>La combinación ganadora es:</p><B>");
for (i=0; i<6; i++)
{
out.print(" "+primi[i]);
}
out.print("</B>");
out.close();
}
}