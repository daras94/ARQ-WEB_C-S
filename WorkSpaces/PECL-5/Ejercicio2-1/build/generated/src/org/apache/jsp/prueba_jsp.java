package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;

public final class prueba_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {


            Connection c;
            Statement s;
            ResultSet rs;
            ResultSetMetaData rsmd;
        
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
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <title>Tutorial JSP, Base de Datos</title>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        \n");
      out.write("        ");
      out.write("\n");
      out.write("        ");

        Class.forName("org.postgresql.Driver");
        c = DriverManager.getConnection("jdbc:postgresql://localhost:5432/WEB", "postgres", "ruben");
        s = c.createStatement();
        rs = s.executeQuery("SELECT * FROM public.\"LIBROS\"");
        rsmd = rs.getMetaData();
        
      out.write("\n");
      out.write("        <table width=\"100%\" border=\"1\">\n");
      out.write("            <tr>\n");
      out.write("                ");
 for( int i=1; i <= rsmd.getColumnCount(); i++ ) { 
      out.write("\n");
      out.write("                <th>");
      out.print( rsmd.getColumnLabel( i ) );
      out.write("</th>\n");
      out.write("                ");
 } 
      out.write("\n");
      out.write("            </tr>\n");
      out.write("        ");
 while( rs.next() ) { 
      out.write("\n");
      out.write("        <tr>\n");
      out.write("        ");
 for( int i=1; i <= rsmd.getColumnCount(); i++ ) { 
      out.write("\n");
      out.write("        ");
 if( i == 3 ) { 
      out.write("\n");
      out.write("        <td>");
      out.print( rs.getInt( i ) );
      out.write("</td>\n");
      out.write("        ");
 } else { 
      out.write("\n");
      out.write("        <td>");
      out.print( rs.getString( i ) );
      out.write("</td>\n");
      out.write("        ");
 } } 
      out.write("\n");
      out.write("        </tr>\n");
      out.write("        ");
 } 
      out.write("\n");
      out.write("        </table>\n");
      out.write("    </body>\n");
      out.write("</html>");
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
