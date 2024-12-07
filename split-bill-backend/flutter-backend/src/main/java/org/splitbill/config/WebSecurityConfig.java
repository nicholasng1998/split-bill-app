package org.splitbill.config;

import lombok.RequiredArgsConstructor;
import org.splitbill.feign.UserFeignService;
import org.splitbill.interceptor.JwtFilter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

    @Value("${jwt.secret.key}")
    private String jwtSecretKey;

    private final CustomAuthenticationProvider customAuthenticationProvider;
    private final CustomLoginSuccessHandler customLoginSuccessHandler;
    private final UserFeignService userFeignService;

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.authenticationProvider(this.customAuthenticationProvider);
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
                .csrf().disable()
                .formLogin()
                .loginProcessingUrl("/api/login")
                .successHandler(this.customLoginSuccessHandler)
                .failureHandler(new CustomLoginFailureHandler())
                .and()
                .logout()
                .logoutUrl("/api/logout")
                .logoutSuccessHandler(new CustomLogoutSuccessHandler())
                .and()
                .authorizeRequests()
                .antMatchers("/**").permitAll()
                .and()
                .sessionManagement()
                .sessionCreationPolicy(SessionCreationPolicy.STATELESS);

        http.addFilterBefore(this.jwtFilter(), UsernamePasswordAuthenticationFilter.class);
    }

    @Bean
    public JwtFilter jwtFilter() {
        return new JwtFilter(this.jwtSecretKey, this.userFeignService);
    }


}
