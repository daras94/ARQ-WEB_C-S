<%-- 
    Document   : register
    Created on : 15-ene-2019, 3:10:57
    Author     : david
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Registro</title>
    <meta name="description" content="Registro">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="${pageContext.request.contextPath}/res/css/admin.css" rel="stylesheet" type="text/css"/>
</head>
<body class="bg-dark">
    <div class="sufee-login d-flex align-content-center flex-wrap">
        <div class="container">
            <div class="login-content">
                <div class="login-logo">
                    <a href="${pageContext.request.contextPath}/index.html">
                        <img src="${pageContext.request.contextPath}/res/img/logo.png" alt=""/>
                    </a>
                </div>
                <div class="login-form">
                    <form action="${pageContext.request.contextPath}/pag/registeruser" method="GET">
                        <div class="form-group">
                            <label>Nombre: </label>
                            <input type="text" class="form-control" placeholder="Nombre" id="nombre" name="nombre" required>
                        </div>
                        <div class="form-group">
                            <label>DNI:</label>
                            <input type="text" class="form-control" placeholder="00000000P" id="dni" name="dni" required>
                        </div>
                        <div class="form-group">
                            <label>Contraseña</label>
                            <input type="password" class="form-control" placeholder="Contraseña" id="pass" name="pass" required>
                        </div>
                        <button type="submit" class="btn btn-primary btn-flat m-b-30 m-t-30">Register</button>
                    </form>
                </div>
                <%
                    String status = request.getParameter("status");
                    if (status != null) {
                        out.append("<br />");
                        out.append("<div class='sufee-alert alert with-close alert-info alert-dismissible fade show'>");
                        out.append("<span class='badge badge-pill badge-info'>");
                        out.append((Integer.valueOf(status) >= 0) ? "Success" : "Out").append("!!!");
                        out.append("</span>");
                        switch (status) {
                            case "0":
                                out.append(" - Se creo correctamente el usuario.");
                                break;
                            case "-1":
                                out.append(" - Error de base de datos.");
                                break;
                            case "-2":
                                out.append(" - Existe un usaurio con ese DNI.");
                                break;
                        }
                        out.append("<button type='button' class='close' data-dismiss='alert' aria-label='Close'>");
                        out.append("<span aria-hidden='true'>&times;</span>");
                        out.append("</button>");
                        out.append("</div>");
                    }
                %>
            </div>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/res/js/jquery.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/res/js/popper.min.js"></script>
    <script src="${pageContext.request.contextPath}/res/js/bootstrap/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/res/js/jquery.matchHeight.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/res/js/admin/main.js"></script>
</body>
