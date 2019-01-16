<%-- 
    Document   : profile
    Created on : 05-ene-2019, 13:21:10
    Author     : david
--%>

<%@page import="gr4.web.util.Perfil"%>
<%@page import="gr4.web.util.Comprar"%>
<%@page import="org.springframework.security.core.userdetails.UserDetails"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<%@page import="gr4.web.util.Billete"%>
<%-- 
    Document   : carrito
    Created on : 15-ene-2019, 12:34:24
    Author     : david
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="gr4.web.util.Trayectos"%>
<%@page import="java.sql.Connection"%>
<%@page import="gr4.web.util.Carrito"%>
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
        <title>Ela Admin - HTML5 Admin Template</title>
        <meta name="description" content="Ela Admin - HTML5 Admin Template">
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
                            <a href="${pageContext.request.contextPath}/index.html"><i class="menu-icon fa fa-laptop"></i>Inicio</a>
                        </li>
                        <%
                            String path_url = pageContext.getServletContext().getContextPath();
                            Authentication auth = null;
                            try {
                                auth = ((SecurityContext) session.getAttribute("SPRING_SECURITY_CONTEXT")).getAuthentication();
                            } catch (Exception ex) {
                                out.append("<li>");
                                out.append("<a href='" + path_url + "/pag/register.html'><i class='menu-icon fa  fa-user-md'></i>Registro</a>");
                                out.append("</li>");
                            }
                        %>
                        <li class="menu-title"> Servicios:</li>
                        <!-- /.menu-title -->
                        <li><a href="${pageContext.request.contextPath}/pag/data-vuelos.html"><i class="menu-icon fa fa-fighter-jet"></i>Vuelos</a></li>
                        <li>
                            <a href="${pageContext.request.contextPath}/pag/carrito.html">
                                <i class="menu-icon fa fa-shopping-cart"></i>Carro
                                <%
                                    Carrito carro = (Carrito) session.getAttribute("carro");
                                    int num_vuelos = 0;
                                    if (carro != null) {
                                        num_vuelos = carro.getCarro().size();
                                    }
                                    out.append("<span class='badge badge-pending'>").append(String.valueOf(num_vuelos)).append("</span>");
                                %>
                            </a>
                        </li>
                    </ul>
                </div><!-- /.navbar-collapse -->
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
                                try {
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
                                        String[] url = new String[]{(isAdmin) ? "/admin" : "/client", "/logout"};
                                        out.append("<div class='user-menu dropdown-menu'>");
                                        for (int i = 0; i < text.length; i++) {
                                            out.append("<a class='nav-link' href='").append(path_url + url[i]).append("'><i class='fa ").append(icon[i]).append("'></i>").append(text[i]).append("</a>");
                                        }
                                        out.append("<div/>");
                                    } else {
                                        out.append("<a href='").append(path_url).append(path_url).append("/login'><i class='menu-icon fa fa-laptop'></i>Iniciar Session</a>");
                                    }
                                } catch (Exception ex) {
                                    out.append("<a href='").append(path_url).append("/login'>Iniciar Session <i class='menu-icon fa fa-sign-in'></i></a>");
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
                        out.append((Integer.valueOf(status) >= 0) ? "Success" : "Out").append("!!!");
                        out.append("</span>");
                        switch (status) {
                            case "2":
                                out.append(" - El villete o billetes an sido comprados corectamente");
                                break;
                            case "1":
                                out.append(" - Se ha eliminado vuelo del la cesta de la compra satisfactoriamente.");
                                break;
                            case "0":
                                out.append(" - Se añadio el vuelo correctamente al a la cesta de la compra.");
                                break;
                            case "-1":
                                out.append(" - No se pudo añadir el vuelo al carrito.");
                                break;
                            case "-2":
                                out.append(" - No se pudo boorar el emento del carrito.");
                                break;
                            case "-3":
                                out.append(" - La session Caduco se perdio el carrito");
                                break;
                            case "-4":
                                out.append(" - No Se encontro el vuelo en el carrito algo fue mal.");
                                break;
                            case "-5":
                                out.append(" - La validacion del villete fallo no se pudo completar la compra.");
                                break;
                        }
                        out.append("<button type='button' class='close' data-dismiss='alert' aria-label='Close'>");
                        out.append("<span aria-hidden='true'>&times;</span>");
                        out.append("</button>");
                        out.append("</div>");
                    }
                %>
                <div class="animated fadeIn">
                    <div class="row">
                        <div class="col-md-8">
                            <div class="card border border-success">
                                <div class="card-header">
                                    <strong class="card-title">Card Outline</strong>
                                </div>
                                <div class="card-body">
                                    <form action="${pageContext.request.contextPath}/pag/removevuelocarrito" method="get" novalidate="novalidate">
                                        <table id="bootstrap-data-table" class="table table-striped table-bordered">
                                            <col>
                                            <col>
                                            <col width="160">
                                            <col width="40">
                                            <col width="80">
                                            <thead>
                                                <tr>
                                                    <th>Origen</th>
                                                    <th>Destino</th>
                                                    <th>Fecha Compra</th>
                                                    <th>Nº ID</th>
                                                    <th>PAY</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    float total = 0;
                                                    String username = null;
                                                    ArrayList<String[]> history = null;
                                                    Connection con = null;
                                                    try {
                                                        if (auth.isAuthenticated()) {
                                                            con = (Connection) pageContext.getServletContext().getAttribute("conexion");
                                                            Object principal = auth.getPrincipal();
                                                            if (principal instanceof UserDetails) {
                                                                username = ((UserDetails) principal).getUsername();
                                                            } else {
                                                                username = principal.toString();
                                                            }
                                                            history = new Billete(con).obtenerBilletesUsuario(username);
                                                            if (!history.isEmpty()) {
                                                                for (int i = 0; i < history.size(); i++) {
                                                                    int end_pos = history.get(i).length - 1;
                                                                    out.append("<tr>");
                                                                    for (int j = 0; j < history.get(i).length; j++) {
                                                                        out.append("<td>").append(history.get(i)[j]).append(((j == end_pos) ? " <i class='fa fa-eur'></i>" : "")).append("</td>");
                                                                    }
                                                                    out.append("</tr>");
                                                                    total += Float.valueOf(history.get(i)[end_pos]);
                                                                }
                                                            }
                                                        }
                                                    } catch (NumberFormatException ex) {

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
                                                <h2 class="text-light display-6">Perfil de Usuario</h2>
                                                <p><b>USER :</b> <%= username%></p>
                                            </div>
                                        </div>
                                    </div>
                                    <ul class="list-group list-group-flush">
                                        <li class="list-group-item">
                                            <b>
                                                <a><i class='fa fa-arrow-circle-o-right'></i> Nº Compras:
                                                    <span class="badge badge-warning pull-right r-activity">
                                                        <%=String.valueOf(new Comprar(con).countCompras(username))%> <i class='fa fa-fighter-jet'></i>
                                                    </span>
                                                </a>
                                            </b>
                                        </li>
                                        <li class="list-group-item">
                                            <b>
                                                <a><i class='fa fa-arrow-circle-o-right'></i> Total Gastado:
                                                    <span class="badge badge-warning pull-right r-activity">
                                                        <%= total%> <i class='fa fa-eur'></i>
                                                    </span>
                                                </a>
                                            </b>
                                        </li>
                                    </ul>
                                </section>
                            </aside>
                            <aside class="profile-nav alt">
                                <section class="card">
                                    <ul class="list-group list-group-flush">
                                        <%
                                            String[] user_dat = new Perfil(con).getInfoUser(username);
                                            if (user_dat.length > 0) {
                                                for (int i = 0; i < user_dat.length; i++) {
                                                    out.append("<li class='list-group-item'>");
                                                    out.append("<a><b><i class='fa fa-arrow-circle-o-right'></i> ").append((new String[]{"Nombre:", "DNI:"})[i]);
                                                    out.append("<span class='badge badge-warning pull-right r-activity'>").append(user_dat[i]).append(" </span></b></a>");
                                                    out.append("</li>");
                                                }
                                            }
                                        %>
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