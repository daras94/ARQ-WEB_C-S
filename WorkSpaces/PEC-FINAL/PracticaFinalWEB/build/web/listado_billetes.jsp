<%-- 
    Document   : listado_billetes
    Created on : 14-ene-2019, 18:00:09
    Author     : solea
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>LBilletes disponibles</title>
    </head>
    <body>
        <h1>Billetes disponibles</h1>
        <%
            ResultSet r = (ResultSet) session.getAttribute("consulta");
            out.println("<table>");
            
            while(r.next()){
                out.println("<a href=\"ServletAnadirCesta?origen=" + r.getString(0) +"dest=" + r.getString(1)+ "id=" + r.getString(2)+"precio=" + r.getString(3)+"fecha=" + r.getString(4)+ "\" target=\"_blank\">" + "<tr>");
                out.println("<th>"+r.getString(0)+"</th>");
                out.println("<th>"+r.getString(1)+"</th>");
                out.println("<th>"+r.getString(2)+"</th>");
                out.println("<th>"+r.getString(3)+"</th>");
                out.println("<th>"+r.getString(4)+"</th>");
                out.println("</tr></a>");
            }
            
            out.println("</table>");
            
            
            
            %>
    </body>
</html>

