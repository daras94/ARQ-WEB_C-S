<%@page import="utiles.Carro"%>
<%@ page import= "utiles.Vuelo" %> 
<%@ page import= "utiles.Carro" %> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%

Carro carro = (Carro) session.getAttribute("carro");
carro.anadirVueloCesta(origen, destino, precio);


%>

