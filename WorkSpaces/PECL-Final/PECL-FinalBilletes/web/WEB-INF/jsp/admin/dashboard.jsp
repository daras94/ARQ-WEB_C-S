<%-- 
    Document   : dashboard
    Created on : 05-ene-2019, 13:20:50
    Author     : david
--%>
<%@page import="gr4.web.util.Estadisticas"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="gr4.web.util.Comprar"%>
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
        <meta name="description" content="Admin Dasboard">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/res/css/admin.css">
        <link href="${pageContext.request.contextPath}/res/css/admin/lib/datatable/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css"/>
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
                <div class="animated fadeIn">
                    <div class="row">
                        <div class="col-md-8">
                            <div class="card border border-success">
                                <div class="card-header">
                                    <strong class="card-title">Listado Trayectos</strong>
                                </div>
                                <div class="card-body">
                                    <form action="${pageContext.request.contextPath}/pag/removevuelocarrito" method="get" novalidate="novalidate">
                                        <table id="bootstrap-data-table" class="table table-striped table-bordered">
                                            <col width="30">
                                            <col>
                                            <col>
                                            <col width="120">
                                            <col width="80">
                                            <col width="80">
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Origen</th>
                                                    <th>Destino</th>
                                                    <th>Nº Viajeros</th>
                                                    <th>PAY</th>
                                                    <th>Ganacias</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    float total_pay = 0;
                                                    float total_gan = 0;
                                                    float total_use = 0;
                                                    ArrayList<String[]> stadis = new Estadisticas((Connection) pageContext.getServletContext().getAttribute("conexion")).getEstadisticas();
                                                    if (!stadis.isEmpty()) {
                                                        for (int i = 0; i < stadis.size(); i++) {
                                                            int end_pos = stadis.get(i).length;
                                                            out.append("<tr>");
                                                            for (int j = 0; j < stadis.get(i).length; j++) {
                                                                out.append("<td>").append(stadis.get(i)[j]).append(((j > end_pos - 2) ? " <i class='fa fa-eur'></i>" : "")).append("</td>");
                                                            }
                                                            out.append("</tr>");
                                                            total_use += Float.valueOf(stadis.get(i)[end_pos - 3]);
                                                            total_pay += Float.valueOf(stadis.get(i)[end_pos - 2]);
                                                            total_gan += Float.valueOf(stadis.get(i)[end_pos - 1]);
                                                        }
                                                    }
                                                %>
                                            </tbody>
                                        </table>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <aside class="profile-nav alt">
                                <section class="card">
                                    <div class="card-header user-header alt bg-dark">
                                        <div class="media">
                                            <a href="#">
                                                <img class="align-self-center rounded-circle mr-3" style="width:130px; height:130px;" alt="" src="${pageContext.request.contextPath}/res/img/a1.jpg">
                                            </a>
                                            <div class="media-body">
                                                <h2 class="text-light display-6">Estadisticas</h2>
                                                <p><b>Proyect :</b> GR4-TR@VEL</p>
                                            </div>
                                        </div>
                                    </div>
                                    <ul class="list-group list-group-flush">
                                        <li class="list-group-item">
                                            <b>
                                                <a><i class='fa fa-arrow-circle-o-right'></i> Total Nº Viajeros:
                                                    <span class="badge badge-warning pull-right r-activity">
                                                        <%= total_use%> <i class='fa fa-users'></i>
                                                    </span>
                                                </a>
                                            </b>
                                        </li>
                                        <li class="list-group-item">
                                            <b>
                                                <a><i class='fa fa-arrow-circle-o-right'></i> Total bruto:
                                                    <span class="badge badge-warning pull-right r-activity">
                                                        <%= total_pay%> <i class='fa fa-eur'></i>
                                                    </span>
                                                </a>
                                            </b>
                                        </li>
                                        <li class="list-group-item">
                                            <b>
                                                <a><i class='fa fa-arrow-circle-o-right'></i> Total Ganancias:
                                                    <span class="badge badge-warning pull-right r-activity">
                                                        <%= total_gan%> <i class='fa fa-eur'></i>
                                                    </span>
                                                </a>
                                            </b>
                                        </li>
                                    </ul>
                                </section>
                            </aside>
                        </div>
                    </div>
                </div>
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
        <!-- Scripts -->
        <script src="${pageContext.request.contextPath}/res/js/admin/lib/data-table/datatables.min.js"></script>
        <script src="${pageContext.request.contextPath}/res/js/admin/lib/data-table/dataTables.bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/res/js/admin/lib/data-table/dataTables.buttons.min.js"></script>
        <script src="${pageContext.request.contextPath}/res/js/admin/lib/data-table/buttons.bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/res/js/admin/lib/data-table/jszip.min.js"></script>
        <script src="${pageContext.request.contextPath}/res/js/admin/lib/data-table/vfs_fonts.js"></script>
        <script src="${pageContext.request.contextPath}/res/js/admin/lib/data-table/buttons.html5.min.js"></script>
        <script src="${pageContext.request.contextPath}/res/js/admin/lib/data-table/buttons.print.min.js"></script>
        <script src="${pageContext.request.contextPath}/res/js/admin/lib/data-table/buttons.colVis.min.js"></script>
        <script src="${pageContext.request.contextPath}/res/js/admin/init/datatables-init.js"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                $('#bootstrap-data-table-export').DataTable();
            });
        </script>
    </body>
</html>