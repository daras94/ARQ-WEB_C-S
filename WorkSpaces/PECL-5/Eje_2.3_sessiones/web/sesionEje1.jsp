<%-- 
    Document   : sesionEje1
    Created on : 20-nov-2018, 21:00:15
    Author     : david
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <h1>Ejemplo de Sesión</h1>
    <center>
        Hola, <%=session.getAttribute("Nombre")%> Bienvenido a la página 2
    </center>
</html>
