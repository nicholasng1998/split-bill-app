package org.splitbill.interceptor;

import feign.RequestInterceptor;
import feign.RequestTemplate;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.splitbill.util.AuthUtil;
import org.springframework.stereotype.Component;

@Slf4j
@Component
@RequiredArgsConstructor
public class FeignInterceptor implements RequestInterceptor {

    private static final String USERNAME = "username";

    @Override
    public void apply(RequestTemplate template) {
        template.header(USERNAME, AuthUtil.getUsername());

        log.info("-------------------------------------------");
        log.info("Request:              {}", template.path());
        log.info("Request method:       {}", template.method());
        log.info("-------------------------------------------");
    }
}
