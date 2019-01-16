<%-- 
    Document   : data-journey
    Created on : 15-ene-2019, 0:03:50
    Author     : david
--%>
<%@page import="gr4.web.util.Trayectos"%>
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
        <title>Ver/Gestionar Trayectos</title>
        <meta name="description" content="Ver/Gestionar Trayectos">
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
                <%
                    String status = request.getParameter("status");
                    if (status != null) {
                        out.append("<div class='sufee-alert alert with-close alert-info alert-dismissible fade show'>");
                        out.append("<span class='badge badge-pill badge-info'>");
                        out.append((status != "-1") ? "Success" : "Out").append("!!!");
                        out.append("</span>");
                        if (status != "-1") {
                            out.append(" - El aeropuerto fue eliminado corectamente");
                        } else {
                            out.append(" - Algo Fallo Al eliminar el aeropuerto.");
                        }
                        out.append("<button type='button' class='close' data-dismiss='alert' aria-label='Close'>");
                        out.append("<span aria-hidden='true'>&times;</span>");
                        out.append("</button>");
                        out.append("</div>");
                    }
                %>
                <div class="animated fadeIn">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card">
                                <div class="card-header">
                                    <strong class="card-title">Trayectos</strong>
                                </div>
                                <div class="card-body">
                                    <table id="bootstrap-data-table" class="table table-striped table-bordered">
                                        <col>
                                        <col>
                                        <col width="80">
                                        <col width="80">
                                        <col width="120">
                                        <col width="40">
                                        <thead>
                                            <tr>
                                                <th>Aeropuerto Origen</th>
                                                <th>Aeropuerto Destino</th>
                                                <th>Pecio</th>
                                                <th>Fecha</th>
                                                <th>Nº Plazas</th>
                                                <th>######</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                Connection con = (Connection) pageContext.getServletContext().getAttribute("conexion");
                                                ArrayList<String[]> journey = new Trayectos(con).getTrayectos();
                                                for (int i = 0; i < journey.size(); i++) {
                                                    out.append("<tr>");
                                                    for (int j = 0; j < (journey.get(i).length  - 1); j++) {
                                                        out.append("<td>").append(journey.get(i)[j]).append(((j == 2)? " <i class='fa fa-eur'></i>" : "")).append("</td>");
                                                    }
                                                    out.append("<td><a class='btn btn-danger btn-sm' href='");
                                                    out.append(path_url).append("/admin/deletejourney?id-viaje=").append(journey.get(i)[5]);
                                                    out.append("' role='button'>Borrar <i class='fa fa-eraser'></i></a></td>");
                                                    out.append("</tr>");
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div><!-- .animated -->
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