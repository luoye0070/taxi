import com.sec.PersonAuthority
import grails.converters.JSON

import javax.servlet.http.HttpServletResponse

import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

import org.springframework.security.authentication.AccountExpiredException
import org.springframework.security.authentication.CredentialsExpiredException
import org.springframework.security.authentication.DisabledException
import org.springframework.security.authentication.LockedException
import org.springframework.security.core.context.SecurityContextHolder as SCH
import org.springframework.security.web.WebAttributes
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.web.authentication.WebAuthenticationDetails
import org.springframework.security.core.Authentication

import com.OnlineListener
import com.sec.Person

class LoginController {
    def authenticationTrustResolver
    def authenticationManager
    def springSecurityService
    /**
     * Dependency injection for the authenticationTrustResolver.
     */

    /**
     * Dependency injection for the springSecurityService.
     */

    /**
     * Default action; redirects to 'defaultTargetUrl' if logged in, /login/auth otherwise.
     */
    def index = {
        if (springSecurityService.isLoggedIn()) {
            redirect uri: SpringSecurityUtils.securityConfig.successHandler.defaultTargetUrl
        }
        else {
            redirect action: 'auth', params: params
        }
    }

    /**
     * Show the login page.
     */
    def auth = {

        def config = SpringSecurityUtils.securityConfig

        if (springSecurityService.isLoggedIn()) {
            redirect uri: config.successHandler.defaultTargetUrl
            return
        }

        String view = 'auth'
        String postUrl = "${request.contextPath}${config.apf.filterProcessesUrl}"

        render view: view, model: [postUrl: postUrl,
                rememberMeParameter: config.rememberMe.parameter]
    }

    /**
     * The redirect action for Ajax requests.
     */
    def authAjax = {
        response.setHeader 'Location', SpringSecurityUtils.securityConfig.auth.ajaxLoginFormUrl
        response.sendError HttpServletResponse.SC_UNAUTHORIZED
    }

    /**
     * Show denied page.
     */
    def denied = {
        if (springSecurityService.isLoggedIn() &&
                authenticationTrustResolver.isRememberMe(SCH.context?.authentication)) {
            // have cookie but the page is guarded with IS_AUTHENTICATED_FULLY
            redirect action: 'full', params: params
        }
    }

    /**
     * Login page for users with a remember-me cookie but accessing a IS_AUTHENTICATED_FULLY page.
     */
    def full = {
        def config = SpringSecurityUtils.securityConfig
        render view: 'auth', params: params,
                model: [hasCookie: authenticationTrustResolver.isRememberMe(SCH.context?.authentication),
                        postUrl: "${request.contextPath}${config.apf.filterProcessesUrl}"]
    }

    /**
     * Callback after a failed login. Redirects to the auth page with a warning message.
     */
    def authfail = {

        def username = session[UsernamePasswordAuthenticationFilter.SPRING_SECURITY_LAST_USERNAME_KEY]
        String msg = ''
        def exception = session[WebAttributes.AUTHENTICATION_EXCEPTION]
        if (exception) {
            if (exception instanceof AccountExpiredException) {
                msg = g.message(code: "springSecurity.errors.login.expired")
            }
            else if (exception instanceof CredentialsExpiredException) {
                msg = g.message(code: "springSecurity.errors.login.passwordExpired")
            }
            else if (exception instanceof DisabledException) {
                msg = g.message(code: "springSecurity.errors.login.disabled")
            }
            else if (exception instanceof LockedException) {
                msg = g.message(code: "springSecurity.errors.login.locked")
            }
            else {
                msg = g.message(code: "springSecurity.errors.login.fail")
            }
        }

        if (springSecurityService.isAjax(request)) {
            render([error: msg] as JSON)
        }
        else {
            flash.message = msg
            redirect action: 'auth', params: params
        }
    }

    /**
     * The Ajax success redirect url.
     */
    def ajaxSuccess = {
        render([success: true, username: springSecurityService.authentication.name] as JSON)
    }

    /**
     * The Ajax denied redirect url.
     */
    def ajaxDenied = {
        render([error: 'access denied'] as JSON)
    }


    def pri_auth = {

        def username = params.j_username
        def password = params.j_password.encodeAsSHA256()
        if(!username)
            return
        def rets = Person.findByUsername(username)
        if(rets&&rets.password==password)
        {
            UsernamePasswordAuthenticationToken authRequest = new UsernamePasswordAuthenticationToken(username, params.j_password);
            WebAuthenticationDetails webdetails=new WebAuthenticationDetails(request);
            authRequest.setDetails(webdetails);
            Authentication auth1=authenticationManager.doAuthentication(authRequest);
            SCH.getContext().setAuthentication(auth1);

            if(auth1.isAuthenticated())
            {

                def logip
                if (request.getHeader("X-Forwarded-For"))
                    logip = request.getHeader("X-Forwarded-For")
                if(!logip)
                    logip = request.getHeader("X-Real-IP")
                if(!logip)
                    logip = request.getHeader("WL-Proxy-Client-IP")
                if(!logip)
                    logip = request.getRemoteAddr();

                def logobj = []
                if(session?.uid)
                {
                    OnlineListener.loginlist.remove(session.uid)
                }
//
                logobj =
                    [
                            id:springSecurityService?.currentUser?.id,
                            ip:logip
                    ]
                session?.uid = logobj



                render([success: true, username: username] as JSON)
            }
            else
            {
                render([success: false, username: username] as JSON)
            }
        }
        else{
            render([success: false, username: username] as JSON)
        }
    }
}
