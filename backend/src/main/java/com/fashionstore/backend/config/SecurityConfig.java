package com.fashionstore.backend.config;

import com.fashionstore.backend.security.JwtAuthFilter;
import com.fashionstore.backend.security.JwtAuthAdminFilter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.*;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
public class SecurityConfig {

    @Autowired
    private JwtAuthFilter jwtAuthFilter;
    @Autowired
    private JwtAuthAdminFilter jwtAuthAdminFilter;

    public SecurityConfig(JwtAuthFilter jwtAuthFilter,
                          JwtAuthAdminFilter jwtAuthAdminFilter) {
        this.jwtAuthFilter = jwtAuthFilter;
        this.jwtAuthAdminFilter = jwtAuthAdminFilter;
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {

        http
            .cors(cors -> {})
            .csrf(csrf -> csrf.disable())

            .authorizeHttpRequests(auth -> auth

                // ===== PUBLIC =====
                .requestMatchers("/api/user/login").permitAll()
                .requestMatchers("/api/user/register").permitAll()
                .requestMatchers("/api/user/admin").permitAll()

                .requestMatchers("/api/product/list").permitAll()
                .requestMatchers("/api/product/single").permitAll()

                // ===== USER =====
                .requestMatchers("/api/user/profile").authenticated()
                .requestMatchers("/api/user/update-profile").authenticated()

                .requestMatchers("/api/cart/**").authenticated()

                .requestMatchers("/api/order/place").authenticated()
                .requestMatchers("/api/order/user-orders").authenticated()

                // ===== ADMIN =====
                .requestMatchers("/api/product/add").authenticated()
                .requestMatchers("/api/product/update").authenticated()
                .requestMatchers("/api/product/remove").authenticated()

                .requestMatchers("/api/order/list").authenticated()
                .requestMatchers("/api/order/status").authenticated()

                .anyRequest().authenticated()
            )

            // USER FILTER
            .addFilterBefore(jwtAuthFilter, UsernamePasswordAuthenticationFilter.class)

            // ADMIN FILTER
            .addFilterBefore(jwtAuthAdminFilter, JwtAuthFilter.class);

        return http.build();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}