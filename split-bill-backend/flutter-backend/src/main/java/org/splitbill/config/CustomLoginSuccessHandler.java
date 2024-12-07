package org.splitbill.config;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Service;

import javax.crypto.SecretKey;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.SecureRandom;
import java.util.Base64;
import java.util.Date;

@Slf4j
@Service
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {

    @Value("${jwt.secret.key}")
    private String secretKey;
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException {
        log.info("onAuthenticationSuccess");
        String username = (String) authentication.getPrincipal();
        log.info("username: " + username);
        String sessionToken = generateToken(username);

        response.getWriter().write(generateResponseModel(sessionToken));
        response.setContentType(MediaType.APPLICATION_JSON_VALUE);
        response.setStatus(HttpServletResponse.SC_OK);
    }

    private String generateResponseModel(String token) throws JsonProcessingException {
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.configure(SerializationFeature.WRITE_DATE_KEYS_AS_TIMESTAMPS, false);
        objectMapper.registerModule(new JavaTimeModule());
        return objectMapper.writeValueAsString(token);
    }

    private String generateToken(String username) {
        long nowMillis = System.currentTimeMillis();
        long expMillis = nowMillis + 86400000; // Token expires in 24 hours
        Date exp = new Date(expMillis);

        log.info("secretKey: " + this.secretKey);
        SecretKey key = Keys.hmacShaKeyFor(this.secretKey.getBytes());
        return Jwts.builder()
                .setSubject(username)
                .setIssuedAt(new Date())
                .setExpiration(exp)
                .signWith(key, SignatureAlgorithm.HS512)
                .compact();
    }

    /**
     * For one time use only*/
    public String generateKey() {
        SecureRandom random = new SecureRandom();
        byte[] keyBytes = new byte[64]; // 512-bit key
        random.nextBytes(keyBytes);
        return Base64.getEncoder().encodeToString(keyBytes);
    }

}
