/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gr4.web.conf;

import java.io.File;
import java.nio.charset.Charset;
import java.util.Arrays;
import java.util.List;
import javax.servlet.ServletContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

/**
 *
 * @author david
 */
@Configuration
@EnableWebMvc
@ComponentScan(basePackages = {"gr4.web.controller"})
public class WebMvcConfig implements WebMvcConfigurer {

    /**
     * Variables globales-
     */
    private static final Charset UTF_8     = Charset.forName("UTF-8");
    private static final int CACHE_PERIOD  = 31556926;
    private static final String JSP_FOLDER = "/WEB-INF/jsp/";
    
    /**
     * Declaracion de variables globales.
     */
    @Autowired
    private ServletContext servletContext;
    
    /**
     * 
     * @param registry 
     */
    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        for (final File fileEntry : new File(servletContext.getRealPath(JSP_FOLDER)).listFiles()) {
            String file_name = fileEntry.getName();
            if (fileEntry.isDirectory()) {
                new Object() {
                    void getResourses(ViewControllerRegistry registry, File folder) {
                        for (final File sub_fileEntry : folder.listFiles()) {
                            if (sub_fileEntry.isDirectory()) {
                                this.getResourses(registry, sub_fileEntry);
                            } else if (sub_fileEntry.isFile()) {
                                String file_name = sub_fileEntry.getName();
                                if (file_name.contains(".jsp")) {
                                    file_name = folder.getName() + "/" + file_name.substring(0, file_name.indexOf(".jsp"));
                                    registry.addViewController("/" + file_name + ".html").setViewName(file_name);
                                }
                            }
                        }
                    }
                }.getResourses(registry, fileEntry);
            } else if (fileEntry.isFile()) {
                if (file_name.contains(".jsp")) {
                    file_name = file_name.substring(0, file_name.indexOf(".jsp"));
                    registry.addViewController("/" + file_name + ".html").setViewName(file_name);
                    
                }
            }
        }  
        registry.setOrder(Ordered.HIGHEST_PRECEDENCE);
    }

    /**
     * 
     * @param configurer 
     */
    @Override
    public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
        configurer.enable();
    }

    /**
     * 
     * @param converters 
     */
    @Override
    public void configureMessageConverters(List<HttpMessageConverter<?>> converters) {
        StringHttpMessageConverter stringConverter = new StringHttpMessageConverter();
        stringConverter.setSupportedMediaTypes(Arrays.asList(new MediaType("text", "plain", UTF_8)));
        converters.add(stringConverter);
        //Cual quier otro conversion debe de añadirse aqui.
    }

    /**
     * 
     * @param registry 
     */
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/assets/**").addResourceLocations("classpath:/META-INF/resources/webjars/").setCachePeriod(CACHE_PERIOD);
        registry.addResourceHandler("/res/**").addResourceLocations("/WEB-INF/res/").setCachePeriod(CACHE_PERIOD);     
        // Los demas recursos web que se defina deveran ser añadido a continuacion de la misma manera que se a hecho anteriormente.
    }

    /**
     * 
     * @return 
     */
    @Bean
    public InternalResourceViewResolver viewResolver() {
        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
        resolver.setViewClass(org.springframework.web.servlet.view.JstlView.class);
        resolver.setContentType("text/html");
        resolver.setPrefix("/WEB-INF/jsp/");
        resolver.setSuffix(".jsp");
        return resolver;
    }
}
