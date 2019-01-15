<%-- 
    Document   : end-pay
    Created on : 15-ene-2019, 18:42:32
    Author     : david
--%>

<%@page import="gr4.web.util.Comprar"%>
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
                        <li>
                            <a href="${pageContext.request.contextPath}/pag/data-vuelos.html">
                                <i class="menu-icon fa fa-fighter-jet"></i>Vuelos
                            </a>
                        </li>
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
                            case "1":
                                out.append(" - Se ha eliminado vuelo del la cesta de la compra satisfactoriamente.");
                                break;
                            case "0":
                                out.append(" - La validacion del billete fue correcta.");
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
                                            <col width="80">
                                            <col width="80">
                                            <col width="40">
                                            <thead>
                                                <tr>
                                                    <th>Origen</th>
                                                    <th>Destino</th>
                                                    <th>EUR</th>
                                                    <th>Fecha</th>
                                                    <th>Nº</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    float total_bruto = 0, total_robado = 0;
                                                    ArrayList<String[]> compras = (ArrayList<String[]>) session.getAttribute("billete");
                                                    if (compras != null) {
                                                        ArrayList<String[]> carrito = new Comprar((Connection) pageContext.getServletContext().getAttribute("conexion")).getCompras(compras);
                                                        for (int i = 0; i < carrito.size(); i++) {
                                                            out.append("<tr").append("").append(">");
                                                            for (int j = 0; j < (carrito.get(i).length - 1); j++) {
                                                                out.append("<td>").append(carrito.get(i)[j]).append(((j == 2) ? " <i class='fa fa-eur'></i>" : "")).append("</td>");
                                                            }
                                                            total_bruto += Float.valueOf(carrito.get(i)[2]) * Float.valueOf(carrito.get(i)[4]);
                                                            total_robado += Float.valueOf(carrito.get(i)[5]);
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
                                                <h2 class="text-light display-6">Factura</h2>
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
                                            <b><a>Total Bruto:<span class="badge badge-warning pull-right r-activity"><%= total_bruto%> <i class='fa fa-eur'></i></span></a></b>
                                        </li>
                                        <li class="list-group-item">
                                            <b><a>Total (IVA 21%):<span class="badge badge-warning pull-right r-activity"><%= total_bruto + ((total_bruto * 21) / 100)%> <i class='fa fa-eur'></i></span></a></b>
                                        </li>
                                        <li class="list-group-item">
                                            <b><a>Total Final (IVA 21% + Tasas Aeropuerto):<span class="badge badge-warning pull-right r-activity"><%=total_robado%> <i class='fa fa-eur'></i></span></a></b>
                                        </li>
                                    </ul>
                                </section>
                            </aside>
                            <form action="${pageContext.request.contextPath}/client/obternerbillete" method="get">
                                <div class="card">
                                    <div class="card-header">
                                        <strong class="card-title">Credit Card Number</strong>
                                    </div>
                                    <div class="card-body">
                                        <!-- Credit Card -->
                                        <div id="pay-invoice">
                                            <div class="card-body">
                                                <div class="form-group text-center">
                                                    <ul class="list-inline">
                                                        <li class="list-inline-item"><i class="text-muted fa fa-cc-visa fa-2x"></i></li>
                                                        <li class="list-inline-item"><i class="fa fa-cc-mastercard fa-2x"></i></li>
                                                        <li class="list-inline-item"><i class="fa fa-cc-amex fa-2x"></i></li>
                                                        <li class="list-inline-item"><i class="fa fa-cc-discover fa-2x"></i></li>
                                                    </ul>
                                                </div>
                                                <div class="form-group">
                                                    <div class="input-group">
                                                        <div class="input-group-addon">
                                                            <i class="fa fa-credit-card"></i>
                                                        </div>
                                                        <input id="cc" name="cc" type="text" pattern="[0-9]{13,16}" class="form-control" required=>
                                                    </div>
                                                    <small class="form-text text-muted">ex. 9999999999999999</small>
                                                </div>
                                            </div>
                                        </div>
                                    </div> <!-- .card -->
                                </div><!--/.col-->
                                <button type="submit" class="btn btn-success btn-lg btn-block">Obterner Billetes</button>
                            </form>
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