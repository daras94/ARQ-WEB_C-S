/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gr4.web.controller;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.HandlerMapping;

/**
 *
 * @author david
 */
@Controller
public class disparchParentMapping {
    
    @Autowired
    private ServletContext servletContext;

    @RequestMapping(value = {"/{dir}"}, method = {RequestMethod.GET, RequestMethod.POST})
    public void foo(@PathVariable("dir") String dir, HttpServletResponse reponse) {
        final String path =  servletContext.getContextPath();
        try {
            switch (dir) {
                case "admin":
                    reponse.sendRedirect(path.concat("/admin/dashboard.html"));
                    break;
                case "client":
                    reponse.sendRedirect(path.concat("/client/profile.html"));
                    break;
                case "pag":
                    reponse.sendRedirect(path.concat("/redirect.jsp"));
                    break;
            }
        } catch (IOException ex) {
            Logger.getLogger(disparchParentMapping.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
