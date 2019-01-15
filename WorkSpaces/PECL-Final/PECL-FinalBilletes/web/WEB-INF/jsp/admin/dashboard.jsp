<%-- 
    Document   : dashboard
    Created on : 05-ene-2019, 13:20:50
    Author     : david
--%>
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
            <div class="breadcrumbs">
                <div class="breadcrumbs-inner">
                    <div class="row m-0">
                        <div class="col-sm-4">
                            <div class="page-header float-left">
                                <div class="page-title">
                                    <h1>Dashboard</h1>
                                </div>
                            </div>
                        </div>   
                        <div class="col-sm-8">
                            <div class="page-header float-right">
                                <div class="page-title">
                                    <ol class="breadcrumb text-right">
                                        <%
                                            ServletContext ctx = pageContext.getServletContext();
                                            String[] path = ctx.getContextPath().split("/");
                                            for (int i = 1; i < path.length; i++) {
                                                if (i == 1) {
                                                    out.append("<li").append((i == path.length) ? "class='active'" : "").append("><a href=''>/</a></li>");
                                                } else {
                                                    out.append("<li").append((i == path.length) ? "class='active'" : "").append("><a href=''>");
                                                    out.append(path[i]).append("</a>");
                                                    out.append("</li>");
                                                }
                                            }
                                        %>
                                    </ol>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /#header -->
            <!-- Content -->
            <div class="content">

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
    </body>
</html>