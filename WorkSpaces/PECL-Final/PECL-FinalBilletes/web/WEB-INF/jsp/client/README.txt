################################################################################
        _______                             __  __       __           
       |       \                           |  \|  \     /  \          
       | $$$$$$$\  ______    ______    ____| $$| $$\   /  $$  ______  
       | $$__| $$ /      \  |      \  /      $$| $$$\ /  $$$ /      \ 
       | $$    $$|  $$$$$$\  \$$$$$$\|  $$$$$$$| $$$$\  $$$$|  $$$$$$\
       | $$$$$$$\| $$    $$ /      $$| $$  | $$| $$\$$ $$ $$| $$    $$
       | $$  | $$| $$$$$$$$|  $$$$$$$| $$__| $$| $$ \$$$| $$| $$$$$$$$
       | $$  | $$ \$$     \ \$$    $$ \$$    $$| $$  \$ | $$ \$$     \
        \$$   \$$  \$$$$$$$  \$$$$$$$  \$$$$$$$ \$$      \$$  \$$$$$$$
                         
################################################################################
En esta carapeta devera ir todos aquellos JSP que seran visibles a la navegacion
habiendose logueado como un cliente con un usuario que pose ROLE_USER en la BD.  

El disparch ha sido configurado con el Framework Spring Security 5.1.2 y todos 
los recusos que sean creados en este directorio solo seran ascecibles con pre-
vio logueo en la aplicacion y una vez logueado solo sera visibles si el usuario
pose la corespondiente rol de usuario. 

    - Todos los jsp y subdirectorios con jspps que se cren en esta ruta seran 
      mapeados por la aplicacion con el nombre de los directorio y subdirecto-
      rios des la carpeta "client" de forma que si tenemos el siguiente arbol
      de directorios:

        + client/
            |
            | + dir1/
            |    |
            |    | + p1.jsp
            |    | + p2.jsp
            |
            | + dir1/
                 |
                 | + p11.jsp
                 | + p21.jsp

      la ruta de aceso a los recursos en la aplicacion web quedaria de la sigui-
      enten forma:
      
        - http://localhost:8080/PECL-FinalBilletes/client/dir1/p1.html
        - http://localhost:8080/PECL-FinalBilletes/client/dir1/p2.html

        - http://localhost:8080/PECL-FinalBilletes/client/dir2/p11.html
        - http://localhost:8080/PECL-FinalBilletes/client/dir2/p21.html


    o NOTA: Aunque la ficheros sean .jsp la propiedad del framerwork Spring MVC
            5.1.2 esque su disparcher tal y como lo he configurado mapeara todos 
            los jsp con la extension .html pero seguiran siendo ficheros jsp en 
            el servidor pero de cara al cliente se hacderan como si se llamara a
            un recurso html cuando en realidad es un recurso jsp, la salvedad es
            que para llamara un recurso jsp desde otro jsp se deve hacer con la 
            extension .html y no .jsp
        

                                                                           
