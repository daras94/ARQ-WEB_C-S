<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>PL6</title>
<style type="text/css">
	
	h1{
		color: darkblue;
		font: italic;
		font-family: Gotham, "Helvetica Neue", Helvetica, Arial, "sans-serif";
	}
	
	form{
		background-color: burlywood;
		padding: 10px;
		width: 40%;
		border-color: chocolate;
	}
	
	body {
		background-color: #FCFB98;
		
	}
	
	.boton {
		padding: 10px;
	}
	
	
</style>
</head>
<body>
        <h1>Resultado de la ganancia:</h1>
        <p>
            <%
                int resultado = (int) session.getAttribute("respuesta");

                System.out.println("Obtengo el resultado: " + resultado);


            %>
            <%=resultado%>
            
            <br>
            <br>
            <a href="index.html">Página de Inicio</a>

        </p>
    </body>
</html>
