package splitbill.util;

import org.springframework.util.StringUtils;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;

public class AuthUtil {

    private static final String USERNAME = "username";
    private static final String ANONYMOUS_USER = "nicholas2";

    public static String getUsername() {
        RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();
        HttpServletRequest req;
        if (requestAttributes != null) {
            req = ((ServletRequestAttributes) requestAttributes).getRequest();
            return req.getHeader(USERNAME);
        } else {
            return ANONYMOUS_USER;
        }
    }
}
