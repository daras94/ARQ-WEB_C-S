<%@ page language="java" contentType="application/pdf; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import= "java.io.*" %>
    <%
    //CODIGO JSP 
    String ruta = (String)session.getAttribute("ruta");
    FileInputStream ficheroInput = new FileInputStream(ruta);
    int tamanoInput = ficheroInput.available();
    byte[] datosPDF = new byte[tamanoInput];
    ficheroInput.read( datosPDF, 0, tamanoInput);
    String file = "${ruta}".substring("${ruta}".lastIndexOf('/') + 1);
    response.setHeader("Content-disposition","inline; filename="+file );
    response.setContentType("application/pdf");
    response.setContentLength(tamanoInput);
    response.getOutputStream().write(datosPDF);
 
    ficheroInput.close();
%>