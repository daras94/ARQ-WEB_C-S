<%-- 
    Document   : create-journey
    Created on : 15-ene-2019, 0:04:11
    Author     : david
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="gr4.web.util.Aeropuerto"%>
<%@page import="java.sql.Connection"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="org.springframework.security.core.authority.SimpleGrantedAuthority"%>
<%@page import="java.util.Collection"%>
<%@page import="org.springframework.security.core.Authentication"%>
<%@page import="org.springframework.security.core.context.SecurityContext"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="no-js" lang="">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Admin Dasboard</title>
        <meta name="description" content="Ela Admin - HTML5 Admin Template">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/res/css/admin.css">
        <link href="${pageContext.request.contextPath}/res/css/bootstrap/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css"/>
        <script src="${pageContext.request.contextPath}/res/js/jquery.min.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/res/js/popper.min.js"></script>
        <script src="${pageContext.request.contextPath}/res/js/bootstrap/bootstrap.js"></script>
        <script src="${pageContext.request.contextPath}/res/js/jquery.matchHeight.min.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/res/js/admin/main.js"></script>
    </head>
    <body>
        <!-- Left Panel -->
        <aside id="left-panel" class="left-panel">
            <nav class="navbar navbar-expand-sm navbar-default">
                <div id="main-menu" class="main-menu collapse navbar-collapse">
                    <ul class="nav navbar-nav">
                        <li class="active">
                            <a href="${pageContext.request.contextPath}/admin"><i class="menu-icon fa fa-laptop"></i>Dashboard </a>
                        </li>
                        <li class="menu-title"> Gestion:</li>
                        <!-- /.menu-title -->
                        <li class="menu-item-has-children dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> 
                                <i class="menu-icon fa  fa-fighter-jet"></i>Aeropuertos
                            </a>
                            <ul class="sub-menu children dropdown-menu">                           
                                <li><i class="menu-icon fa fa-th"></i><a href="${pageContext.request.contextPath}/admin/data-airports.html">Ver/Gestionar</a></li>
                                <li><i class="menu-icon fa fa-th"></i><a href="${pageContext.request.contextPath}/admin/create-airports.html">Crear</a></li>
                            </ul>
                        </li>
                        <li class="menu-item-has-children dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> 
                                <i class="menu-icon fa fa-area-chart"></i>Trayectos
                            </a>
                            <ul class="sub-menu children dropdown-menu">                           
                                <li><i class="menu-icon fa fa-th"></i><a href="${pageContext.request.contextPath}/admin/data-journey.html">Ver/Gestionar</a></li>
                                <li><i class="menu-icon fa fa-th"></i><a href="${pageContext.request.contextPath}/admin/create-journey.html">Crear</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
                <!-- /.navbar-collapse -->
            </nav>
        </aside>
        <!-- /#left-panel -->
        <!-- Right Panel -->
        <div id="right-panel" class="right-panel">
            <!-- Header-->
            <header id="header" class="header">
                <div class="top-left">
                    <div class="navbar-header">
                        <a class="navbar-brand" href="${pageContext.request.contextPath}">
                            <img src="${pageContext.request.contextPath}/res/img/logo.png" alt="Logo">
                        </a>
                        <a id="menuToggle" class="menutoggle">
                            <i class="fa fa-bars"></i>
                        </a>
                    </div>
                </div>
                <div class="top-right">
                    <div class="header-menu">
                        <div class="user-area dropdown float-right">
                            <%
                                String path_url = pageContext.getServletContext().getContextPath();
                                try {
                                    Authentication auth = ((SecurityContext) session.getAttribute("SPRING_SECURITY_CONTEXT")).getAuthentication();
                                    if (auth.isAuthenticated()) {
                                        out.append("<a href='#' class='dropdown-toggle active' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false'>");
                                        boolean isAdmin = auth.getAuthorities().stream().anyMatch(r -> r.getAuthority().equals("ROLE_ADMIN"));
                                        if (isAdmin) {
                                            out.append("<img class='user-avatar rounded-circle' src='").append(path_url).append("/res/img/admin/avatar/admin.png' alt='User Avatar'>");
                                        } else {
                                            out.append("<img class='user-avatar rounded-circle' src='").append(path_url).append("/res/img/admin/avatar/client.png' alt='User Avatar'>");
                                        }
                                        out.append("</a>");
                                        String[] text = new String[]{"Mi Perfil", "Cerrar Sesion"};
                                        String[] icon = new String[]{"fa-user", "fa-power-off"};
                                        String[] url = new String[]{"/admin", "/logout"};
                                        out.append("<div class='user-menu dropdown-menu'>");
                                        for (int i = 0; i < text.length; i++) {
                                            out.append("<a class='nav-link' href='").append(path_url + url[i]).append("'><i class='fa ").append(icon[i]).append("'></i>").append(text[i]).append("</a>");
                                        }
                                        out.append("<div/>");
                                    } else {
                                        out.append("<a href='").append(path_url).append(path_url).append("/login'><i class='menu-icon fa fa-laptop'></i>Iniciar Session</a>");
                                    }
                                } catch (Exception ex) {
                                    out.append("<a href='").append(path_url).append(path_url).append("/login'>Iniciar Session <i class='menu-icon fa fa-laptop'></i></a>");
                                }
                            %>
                        </div>
                    </div>
                </div>
            </header>
            <!-- /#header -->
            <!-- Content -->
            <div class="content">
                <%
                    String status = request.getParameter("status");
                    if (status != null) {
                        out.append("<div class='sufee-alert alert with-close alert-info alert-dismissible fade show'>");
                        out.append("<span class='badge badge-pill badge-info'>");
                        out.append((status != "-1") ? "Success" : "Out").append("!!!");
                        out.append("</span>");
                        switch (status) {
                            case "0":
                                out.append(" - El trayecto fue creado satisfactoriamente");
                                break;
                            case "-1":
                                out.append(" - Algo Fallo Al dar de alta el trayecto.");
                                break;
                            case "-2":
                                out.append(" - El Aeropuerto de oerigen y destino no puden coincidir.");
                                break;
                        }
                        out.append("<button type='button' class='close' data-dismiss='alert' aria-label='Close'>");
                        out.append("<span aria-hidden='true'>&times;</span>");
                        out.append("</button>");
                        out.append("</div>");
                    }
                %>
                <div class="card">
                    <div class="card-header">
                        <strong class="card-title">Trayectos</strong>
                    </div>
                    <div class="card-body">
                        <!-- Credit Card -->
                        <div id="pay-invoice">
                            <div class="card-body">
                                <div class="card-title">
                                    <h3 class="text-center">Dar de alta</h3>
                                </div>
                                <hr>
                                <form action="${pageContext.request.contextPath}/admin/createjourney" method="get">
                                    <div class="row">
                                        <div class="col-6">
                                            <div class="form-group">
                                                <label for="cc-exp" class="control-label mb-1">Aeropuerto de origen</label>
                                                <select name="aer-origin" id="aer-origin" class="form-control-lg form-control">
                                                    <%
                                                        Connection con = (Connection) pageContext.getServletContext().getAttribute("conexion");
                                                        ArrayList<String> nombre = new Aeropuerto(con).getName();
                                                        for (int i = 0; i < nombre.size(); i++) {
                                                            out.append("<option value='").append(nombre.get(i)).append("'>").append(nombre.get(i)).append("</option>");
                                                        }
                                                    %>
                                                </select>
                                                <span class="help-block" data-valmsg-for="cc-exp" data-valmsg-replace="true"></span>
                                            </div>
                                        </div>
                                        <div class="col-6">
                                            <div class="form-group">
                                                <label for="cc-exp" class="control-label mb-1">Aeropuerto de destino</label>
                                                <select name="aer-destiny" id="aer-destiny" class="form-control-lg form-control">
                                                    <%
                                                        for (int i = nombre.size() - 1; i >= 0; i--) {
                                                            out.append("<option value='").append(nombre.get(i)).append("'>").append(nombre.get(i)).append("</option>");
                                                        }
                                                    %>
                                                </select>
                                                <span class="help-block" data-valmsg-for="cc-exp" data-valmsg-replace="true"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <div class="col col-md-12">
                                            <label for="cc-payment" class="control-label mb-1">Precio Trayecto</label>
                                            <div class="input-group">
                                                <div class="input-group-addon"><i class="fa fa-euro"></i></div>
                                                <input type="number" id="precio" name="precio" placeholder="0" class="form-control" required>
                                                <div class="input-group-addon">.00</div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <div class='col-sm-6'>
                                            <div class="form-group">
                                                <label for="cc-payment" class="control-label mb-1">Fecha</label>
                                                <div class='input-group date' id='datetimepicker1'>
                                                    <input type='date' class="form-control" id="fecha" name="fecha" required>
                                                    <span class="input-group-addon">
                                                        <span class="fa fa-calendar"></span>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col col-sm-6">
                                            <label for="cc-payment" class="control-label mb-1">Numero de Plazas</label>
                                            <div class="input-group">
                                                <input type="number" id="num-plazas" name="num-plazas" placeholder="1" class="form-control" min="1" max="75" required>
                                                <div class="input-group-addon"><i class="fa fa-group"></i></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div>
                                        <button id="payment-button" type="submit" class="btn btn-lg btn-info btn-block">
                                            <i class="fa fa-lock fa-lg"></i>&nbsp;
                                            <span id="payment-button-amount">Crear trayecto</span>
                                            <span id="payment-button-sending" style="display:none;">Sending…</span>
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>

                    </div>
                </div> <!-- .card -->
            </div>
            <!-- /.content -->
            <div class="clearfix"></div>
            <footer class="site-footer">
                <div class="footer-inner bg-white">
                    <div class="row">
                        <div class="col-sm-6">
                            Copyright &copy; 2018 GR4-Tra@vel
                        </div>
                        <div class="col-sm-6 text-right">
                            Designed by <a href="#">D@r@s S.A</a>
                        </div>
                    </div>
                </div>
            </footer>
        </div>
        <script src="${pageContext.request.contextPath}/res/js/bootstrap/bootstrap-datetimepicker.js" type="text/javascript"></script>
        <script type="text/javascript">
            $(function () {
                $('#datetimepicker1').datetimepicker();
            });
        </script>
    </body>
</html>
