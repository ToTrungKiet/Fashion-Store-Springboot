package com.fashionstore.backend.security;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
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
public class JwtAuthFilter extends OncePerRequestFilter {

    @Value("${jwt.secret}")
    private String SECRET;

    @Override
    protected void doFilterInternal(
            HttpServletRequest request,
            HttpServletResponse response,
            FilterChain filterChain) throws ServletException, IOException {

        String path = request.getRequestURI();

        if (!path.equals("/api/user/profile") &&
                !path.equals("/api/user/update-profile") &&
                !path.equals("/api/cart/get") &&
                !path.equals("/api/cart/add") &&
                !path.equals("/api/cart/update") &&
                !path.equals("/api/order/place") &&
                !path.equals("/api/order/user-orders")) {

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

            Claims claims = Jwts.parserBuilder()
                    .setSigningKey(SECRET.getBytes())
                    .build()
                    .parseClaimsJws(token)
                    .getBody();

            String userId = claims.getSubject();

            request.setAttribute("userId", userId);

            UsernamePasswordAuthenticationToken auth = new UsernamePasswordAuthenticationToken(
                    userId,
                    null,
                    new ArrayList<>());

            SecurityContextHolder.getContext().setAuthentication(auth);

            filterChain.doFilter(request, response);

        } catch (ExpiredJwtException e) {

            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.setContentType("application/json");

            response.getWriter().write(
                    "{\"success\":false,\"message\":\"Token đã hết hạn\"}");

        } catch (Exception e) {

            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.setContentType("application/json");

            response.getWriter().write(
                    "{\"success\":false,\"message\":\"" + e.getMessage() + "\"}");
        }
    }
}