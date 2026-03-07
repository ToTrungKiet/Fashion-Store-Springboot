package com.fashionstore.backend.security;

import io.jsonwebtoken.Jwts;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.ArrayList;

@Component
public class JwtAuthAdminFilter extends OncePerRequestFilter {

    @Value("${jwt.secret}")
    private String SECRET;

    @Value("${admin.email}")
    private String ADMIN_EMAIL;

    @Value("${admin.password}")
    private String ADMIN_PASSWORD;

    @Override
    protected void doFilterInternal(
            HttpServletRequest request,
            HttpServletResponse response,
            FilterChain filterChain) throws ServletException, IOException {

        String path = request.getRequestURI();

        // Chỉ chạy filter với admin API
        if (!path.equals("/api/product/add") &&
                !path.equals("/api/product/update") &&
                !path.equals("/api/product/remove") &&
                !path.equals("/api/order/list") &&
                !path.equals("/api/order/status")) {

            filterChain.doFilter(request, response);
            return;
        }

        String token = request.getHeader("token");

        if (token == null) {

            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.setContentType("application/json");

            response.getWriter().write(
                    "{\"success\":false,\"message\":\"Vui lòng đăng nhập để tiếp tục !\"}");

            return;
        }

        try {

            String decoded = Jwts.parserBuilder()
                    .setSigningKey(SECRET.getBytes())
                    .build()
                    .parseClaimsJws(token)
                    .getBody()
                    .getSubject();

            if (!decoded.equals(ADMIN_EMAIL + ":" + ADMIN_PASSWORD)) {

                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                response.setContentType("application/json");

                response.getWriter().write(
                        "{\"success\":false,\"message\":\"Bạn không có quyền truy cập !\"}");

                return;
            }

            UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(
                    ADMIN_EMAIL,
                    null,
                    new ArrayList<>());

            SecurityContextHolder.getContext().setAuthentication(authentication);

            filterChain.doFilter(request, response);

        } catch (Exception e) {

            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.setContentType("application/json");

            response.getWriter().write(
                    "{\"success\":false,\"message\":\"" + e.getMessage() + "\"}");
        }
    }
}