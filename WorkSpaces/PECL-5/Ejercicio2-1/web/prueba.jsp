<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <title>Tutorial JSP, Base de Datos</title>
    </head>
    <body>
        <%@ page import="java.sql.*" %>
        <%!
            Connection c;
            Statement s;
            ResultSet rs;
            ResultSetMetaData rsmd;
        %>
        <%
        Class.forName("org.postgresql.Driver");
        c = DriverManager.getConnection("jdbc:postgresql://localhost:5432/WEB", "postgres", "ruben");
        s = c.createStatement();
        rs = s.executeQuery("SELECT * FROM public.\"LIBROS\"");
        rsmd = rs.getMetaData();
        %>
        <table width="100%" border="1">
            <tr>
                <% for( int i=1; i <= rsmd.getColumnCount(); i++ ) { %>
                <th><%= rsmd.getColumnLabel( i ) %></th>
                <% } %>
            </tr>
        <% while( rs.next() ) { %>
        <tr>
        <% for( int i=1; i <= rsmd.getColumnCount(); i++ ) { %>
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