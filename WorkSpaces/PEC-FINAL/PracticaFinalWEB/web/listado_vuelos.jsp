<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Listado de Vuelos disponibles</title>
    </head>
    <body>
        <h1>Listado de vuelos disponibles</h1>
        <%
            ResultSet r = (ResultSet) session.getAttribute("consulta");
            out.println("<table>");
            
            while(r.next()){
                out.println("<tr>");
                out.println("<th>"+r.getString(0)+"</th>");
                out.println("<th>"+r.getString(1)+"</th>");
                out.println("<th>"+r.getString(2)+"</th>");
                out.println("<th>"+r.getString(3)+"</th>");
                out.println("<th>"+r.getString(4)+"</th>");
                out.println("</tr>");
            }
            
            out.println("</table>");
            
            
            
            %>
    </body>
</html>
