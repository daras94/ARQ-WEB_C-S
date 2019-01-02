<%-- 
    Document   : carro_compra
    Created on : 21-dic-2018, 10:18:56
    Author     : RMGSB
--%>

<%@ page import= "utiles.Vuelo" %> 
<%@ page import= "utiles.Carro" %> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Carro de la Compra</title>
    </head>
    <body>
        <h1>Carro de la compra:</h1>
        <%
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
        %>
    </body>
</html>
