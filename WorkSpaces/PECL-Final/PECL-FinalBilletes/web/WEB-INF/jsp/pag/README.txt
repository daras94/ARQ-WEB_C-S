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
sin nigun tipo de login en la aplicacion web.        

Todos los recursos creados bajo este directorio seran ascecibles sin nigun tipo
de logueo previo en el sistema.


    - Todos los jsp y subdirectorios con jspps que se cren en esta ruta seran 
      mapeados por la aplicacion con el nombre de los directorio y subdirecto-
      rios des la carpeta "client" de forma que si tenemos el siguiente arbol
      de directorios:

        + pag/
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
      
        - http://localhost:8080/PECL-FinalBilletes/pag/dir1/p1.html
        - http://localhost:8080/PECL-FinalBilletes/pag/dir1/p2.html

        - http://localhost:8080/PECL-FinalBilletes/pag/dir2/p11.html
        - http://localhost:8080/PECL-FinalBilletes/pag/dir2/p21.html


    o NOTA: Aunque la ficheros sean .jsp la propiedad del framerwork Spring MVC
            5.1.2 esque su disparcher tal y como lo he configurado mapeara todos 
            los jsp con la extension .html pero seguiran siendo ficheros jsp en 
            el servidor pero de cara al cliente se hacderan como si se llamara a
            un recurso html cuando en realidad es un recurso jsp, la salvedad es
            que para llamara un recurso jsp desde otro jsp se deve hacer con la 
            extension .html y no .jsp
        

                                                                           
                                          
                                                                           
                                                                           
