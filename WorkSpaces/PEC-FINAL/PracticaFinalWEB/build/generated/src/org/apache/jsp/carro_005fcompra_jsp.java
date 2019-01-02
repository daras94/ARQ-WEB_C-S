package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import utiles.Vuelo;
import utiles.Carro;

public final class carro_005fcompra_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write(" \n");
      out.write(" \n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>Carro de la Compra</title>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        <h1>Carro de la compra:</h1>\n");
      out.write("        ");

            try {
                Carro carro = (Carro) session.getAttribute("carro");
                // Veo si el carro ya había sido creado previamente
                if (carro == null) {
                    carro = new Carro();
                    out.println("El carro se encuentra vacio");
                } else {
                    int num_productos = carro.cantidad_cesta();
                    if (num_productos == 0) {
                        out.println("El carro se encuentra vacio");
                    } else {
                        out.println("<p>Productos:</p>");
                        out.println("<table>");
                        for(int i=0; i< num_productos; i++){
                            out.println("<tr>");
                            Vuelo aux = carro.getVuelos().get(i);
                            out.println("<th>"+aux.getOrigen()+"</th>");
                            out.println("<th>"+aux.getDestino()+"</th>");
                            out.println("<th>"+aux.getPrecio()+"</th>");
                            out.println("</tr>");
                        }
                        out.println("</table>");
                    }

                }
            } catch (Exception e) {
                System.out.println("Error: " + e.toString());
            }
        
      out.write("\n");
      out.write("    </body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
