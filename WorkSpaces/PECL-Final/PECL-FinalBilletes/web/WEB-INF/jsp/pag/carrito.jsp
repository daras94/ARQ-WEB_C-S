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
        <title>Carrito de la Compra</title>
        <meta name="description" content="Carrito de la Compra">
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
                                    <strong class="card-title">Listado Cesta</strong>
                                </div>
                                <div class="card-body">
                                    <form action="${pageContext.request.contextPath}/pag/removevuelocarrito" method="get" novalidate="novalidate">
                                        <table id="bootstrap-data-table" class="table table-striped table-bordered">
                                            <col>
                                            <col>
                                            <col width="80">
                                            <col width="80">
                                            <col width="40">
                                            <col width="40">
                                            <col width="40">
                                            <thead>
                                                <tr>
                                                    <th>Origen</th>
                                                    <th>Destino</th>
                                                    <th>EUR</th>
                                                    <th>Fecha</th>
                                                    <th>Nº</th>
                                                    <th>#</th>
                                                    <th>PAY</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    float total = 0;
                                                    if (carro != null) {
                                                        ArrayList<String[]> carrito = carro.getProductos((Connection) pageContext.getServletContext().getAttribute("conexion"));
                                                        for (int i = 0; i < carrito.size(); i++) {
                                                            String num_bille = carrito.get(i)[4];
                                                            out.append("<tr").append("").append(">");
                                                            for (int j = 0; j < (carrito.get(i).length - 2); j++) {
                                                                out.append("<td>").append(carrito.get(i)[j]).append(((j == 2) ? " <i class='fa fa-eur'></i>" : "")).append("</td>");
                                                            }
                                                            out.append("<td>").append(num_bille).append(" <i class='fa fa-ticket'></i></td>");
                                                            String id_vuelo = carrito.get(i)[5];
                                                            out.append("<td>");
                                                            out.append("<button type='submit' class='btn btn-outline-danger btn-sm' name='id-vuelo' value='" + id_vuelo + "'><i class='fa fa-minus'></i></button>");
                                                            out.append("</td>");
                                                            out.append("<td><a class='btn btn-outline-info btn-sm' href='" + path_url + "/client/payoneflycarrito?id-vuelo=" + id_vuelo +"' role='button'><i class='fa fa-credit-card'></i></a></td>");
                                                            out.append("</tr>");
                                                            total += Float.valueOf(carrito.get(i)[2]) * Float.valueOf(num_bille);
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
                                                <h2 class="text-light display-6">Carrito de Viajes</h2>
                                                <p>Proyect GR4-Tr@vel</p>
                                            </div>
                                        </div>
                                    </div>
                                    <ul class="list-group list-group-flush">
                                        <li class="list-group-item">
                                            <b><a>Nº vuelos:<span class="badge badge-warning pull-right r-activity"><%=String.valueOf(num_vuelos)%> <i class='fa fa-fighter-jet'></i></span></a></b>
                                        </li>
                                        <li class="list-group-item">
                                            <b><a>IVA:<span class="badge badge-warning pull-right r-activity">21 %</span></a></b>
                                        </li>
                                        <li class="list-group-item">
                                            <b><a>Total Bruto:<span class="badge badge-warning pull-right r-activity"><%= total  %> <i class='fa fa-eur'></i></span></a></b>
                                        </li>
                                        <li class="list-group-item">
                                            <b><a>Total (IVA 21%):<span class="badge badge-warning pull-right r-activity"><%= total + ((total * 21)/100) %> <i class='fa fa-eur'></i></span></a></b>
                                        </li>
                                    </ul>
                                </section>
                            </aside>
                            <a class="btn btn-success btn-lg btn-block" href="${pageContext.request.contextPath}/client/payfullflycarrito" role="button">Validar y Pagar</a>
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