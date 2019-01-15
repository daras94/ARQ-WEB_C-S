/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gr4.web.conf;

import javax.sql.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

/**
 *
 * @author david
 */
@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired PasswordEncoder passwordEncoder;
    @Autowired DataSource dataSource;
    /**
     * Valibales de query
     */
    private static final String USER_QUERY = "SELECT dni, crypt(contrasena, gen_salt('bf', 8)), enabled FROM usuarios WHERE dni=?";
    private static final String AUTH_QUERY = "SELECT dni, authority FROM authorities WHERE dni=?";
    
    /**
     * 
     * @param auth
     * @throws Exception 
     */
    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.jdbcAuthentication()
                .dataSource(dataSource)
                .passwordEncoder(passwordEncoder)
                .usersByUsernameQuery(USER_QUERY)
                .authoritiesByUsernameQuery(AUTH_QUERY);
    }
    
    /**
     * 
     * @param http
     * @throws Exception 
     */
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.authorizeRequests()
                .antMatchers("/res/**", "/*", "/pag/**").permitAll() 
                .antMatchers("/admin/**").hasRole("ADMIN")
                .antMatchers("/client/**").hasRole("USER")
                //.anyRequest().authenticated()
                .and()
            .formLogin()
                /*.loginPage("/index.html")
                .usernameParameter("username")
                .passwordParameter("password")
                .permitAll()*/
                .and()
            .logout()      
                .logoutSuccessUrl("/index.html?logout")
                .and()
                .exceptionHandling()
                //.authenticationEntryPoint(unauthorizedEntryPoint())
                //.accessDeniedPage("/403")
                .and()
            ;
    }
    /**
     * 
     * @return 
     */
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
    
    @Bean(name = "dataSource")
    public DriverManagerDataSource dataSource() {
        DriverManagerDataSource driverManagerDataSource = new DriverManagerDataSource();
        driverManagerDataSource.setDriverClassName("org.postgresql.Driver");
        driverManagerDataSource.setUrl("jdbc:postgresql://localhost:5432/PECLWeb");
        driverManagerDataSource.setCatalog("public");
        driverManagerDataSource.setUsername("web_generic");
        driverManagerDataSource.setPassword("1234");
        return driverManagerDataSource;
    }

}
