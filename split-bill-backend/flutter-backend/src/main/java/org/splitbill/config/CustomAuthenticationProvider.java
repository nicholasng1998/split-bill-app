package org.splitbill.config;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.splitbill.feign.UserFeignService;
import org.splitbill.model.UserModel;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.InsufficientAuthenticationException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Collections;

@Slf4j
@Component
@RequiredArgsConstructor
public class CustomAuthenticationProvider implements AuthenticationProvider {

    private final HttpServletRequest httpServletRequest;
    private final UserFeignService userFeignService;

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        log.info("Authenticating user...");

        String username = httpServletRequest.getParameter("username");
        String pass = httpServletRequest.getParameter("password");

        if (StringUtils.isEmpty(username) || StringUtils.isEmpty(pass)) {
            throw new InsufficientAuthenticationException("Empty credential");
        }

        log.info("username: " + username);
        log.info("password: " + pass);

        UserModel userModel = userFeignService.getUser(username);
        log.info("clientCredentialModel: " + userModel);
        if (userModel == null) {
            log.info("Client credential not found.");
            return null;
        }

        if (!pass.equals(userModel.getPassword())) {
            log.info("Correct username but wrong password.");
            return null;
        }

        UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken = new UsernamePasswordAuthenticationToken(
                username,
                pass,
                new ArrayList<GrantedAuthority>(Collections.singletonList(new SimpleGrantedAuthority("ROLE_USER")))
        );

        log.info("usernamePasswordAuthenticationToken: " + usernamePasswordAuthenticationToken);
        return usernamePasswordAuthenticationToken;
    }

    @Override
    public boolean supports(Class<?> authentication) {
        log.info("support: " + (UsernamePasswordAuthenticationToken.class.isAssignableFrom(authentication)));
        return (UsernamePasswordAuthenticationToken.class.isAssignableFrom(authentication));
    }

}
