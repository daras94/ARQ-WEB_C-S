<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <title>Tutorial JSP, Base de Datos</title>
    </head>
    <body>
        <%@ page import="java.sql.*" %>
        <%!
        // Declaraciones de las variables utilizadas para la
        // conexión a la base de datos y para la recuperación de
        // datos de las tablas
        Connection c;
        PreparedStatement ps;
        Statement s;
        ResultSet rs;
        ResultSetMetaData rsmd;
        %>
        <%
        // Inicialización de las variables necesarias para la
        // conexión a la base de datos y realización de consultas
        
        String nombre = request.getParameter("nombre");
        System.out.println(nombre);
        Class.forName("org.apache.derby.jdbc.ClientDriver").newInstance();
        c = DriverManager.getConnection("jdbc:derby://localhost:1527/sample","app","app");
        //s = c.createStatement();
        ps = c.prepareStatement("SELECT ALUMNO.DNI, ALUMNO.NOMBRE, ASIGNATURA.ASIGNATURA FROM ALUMNO INNER JOIN ASISTE ON ALUMNO.DNI = ASISTE.DNI INNER JOIN ASIGNATURA ON ASISTE.ASIGNATURA = ASIGNATURA.ASIGNATURA INNER JOIN IMPARTE ON ASIGNATURA.ASIGNATURA = IMPARTE.ASIGNATURA WHERE IMPARTE.DNI = (SELECT DNI FROM PROFESOR WHERE PROFESOR.NOMBRE = ?)");
        ps.setString(1,nombre);
        rs = ps.executeQuery();
        rsmd = rs.getMetaData();
        %>
        <table width="100%" border="1">
            <tr>
                <% for( int i=1; i <= rsmd.getColumnCount(); i++ ) { %>
                <%-- Obtenemos los nombres de las columnas y los colocamos
                como cabecera de la tabla --%>
                <th><%= rsmd.getColumnLabel( i ) %></th>
                <% } %>
            </tr>
            <% while( rs.next() ) { %>
            <tr>
                <% for( int i=1; i <= rsmd.getColumnCount(); i++ ) { %>
                <%-- Recuperamos los valores de las columnas que
                corresponden a cada uno de los registros de la
                tabla. Hay que recoger correctamente el tipo de
                dato que contiene la columna --%>
                <% if( i == 3 ) { %>
                <td><%= rs.getInt( i ) %></td>
                <% } else { %>
                <td><%= rs.getString( i ) %></td>
                <% } } %>
            </tr>
            <% } %>
        </table>
    </body>
</html>

