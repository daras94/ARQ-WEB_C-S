<%-- 
    Document   : sesionEje
    Created on : 20-nov-2018, 20:56:35
    Author     : david
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String val = request.getParameter("nombre");
            if (val != null) {
                session.setAttribute("Nombre",val);
            }
        %>
        <center> 
            <h1>Ejemplo de Sesión</h1>
        </center>
        Donde quieres ir!!!
        <a href="sesionEje1.jsp">Ir a Página 1</a>
        <a href="sesionEje2.jsp">Ir a Página 2</a>
    </body>
</html>