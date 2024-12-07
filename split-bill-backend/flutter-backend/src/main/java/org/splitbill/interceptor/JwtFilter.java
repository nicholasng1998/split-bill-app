package org.splitbill.interceptor;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Slf4j
public class JwtFilter extends OncePerRequestFilter {

    private final String secretKey;

    public JwtFilter(String secretKey) {
        this.secretKey = secretKey;
    }
    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        String requestUrl = getRequestUrl(request);
        log.info("User request: " + requestUrl);
        filterChain.doFilter(request, response);
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
