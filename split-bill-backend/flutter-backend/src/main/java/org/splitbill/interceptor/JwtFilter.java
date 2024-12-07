package org.splitbill.interceptor;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import lombok.extern.slf4j.Slf4j;
import org.splitbill.feign.UserFeignService;
import org.splitbill.model.UserModel;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.GenericFilterBean;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;

@Slf4j
public class JwtFilter extends GenericFilterBean {
    private static final String AUTH_TOKEN = "auth-token";

    private final String secretKey;
    private final UserFeignService userFeignService;

    public JwtFilter(String secretKey, UserFeignService userFeignService) {
        this.secretKey = secretKey;
        this.userFeignService = userFeignService;
    }
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain) throws IOException, ServletException {
        log.info("doFilter first");
        HttpServletRequest httpServletRequest = (HttpServletRequest) servletRequest;

        String authToken = httpServletRequest.getHeader(AUTH_TOKEN);

        Claims claims = Jwts.parserBuilder()
                .setSigningKey(secretKey.getBytes())
                .build()
                .parseClaimsJws(authToken)
                .getBody();

        String username = claims.getSubject();
        UserModel userModel = this.userFeignService.getUser(username);

        UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken = new UsernamePasswordAuthenticationToken(
                username,
                userModel.getPassword(),
                new ArrayList<GrantedAuthority>(Collections.singletonList(new SimpleGrantedAuthority("ROLE_USER")))
        );
        usernamePasswordAuthenticationToken.setDetails(username);
        SecurityContextHolder.getContext().setAuthentication(usernamePasswordAuthenticationToken);

        String requestUrl = getRequestUrl(httpServletRequest);
        log.info("requestUrl: {}", requestUrl);
        chain.doFilter(servletRequest, servletResponse);
    }

    private String getRequestUrl(HttpServletRequest request) {
        StringBuffer url = request.getRequestURL();
        String queryString = request.getQueryString();
        if (queryString != null) {
            url.append("?").append(queryString);
        }
        return url.toString();
    }

}
