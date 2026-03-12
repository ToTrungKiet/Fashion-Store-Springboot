package com.fashionstore.backend.config;

import com.fashionstore.backend.security.JwtAuthFilter;

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

    public SecurityConfig(JwtAuthFilter jwtAuthFilter) {
        this.jwtAuthFilter = jwtAuthFilter;
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {

        http
                .cors(cors -> {
                })
                .csrf(csrf -> csrf.disable())

                .authorizeHttpRequests(auth -> auth

                        // ===== PUBLIC =====
                        .requestMatchers("/api/user/login").permitAll()
                        .requestMatchers("/api/user/register").permitAll()
                        .requestMatchers("/api/user/admin").permitAll()

                        .requestMatchers("/api/product/list").permitAll()
                        .requestMatchers("/api/product/single").permitAll()

                        // ===== USER + ADMIN =====
                        .requestMatchers("/api/user/profile").hasAnyAuthority("ROLE_USER", "ROLE_ADMIN")
                        .requestMatchers("/api/user/update-profile").hasAnyAuthority("ROLE_USER", "ROLE_ADMIN")
                        .requestMatchers("/api/cart/**").hasAnyAuthority("ROLE_USER")
                        .requestMatchers("/api/order/place").hasAnyAuthority("ROLE_USER")
                        .requestMatchers("/api/order/user-orders").hasAnyAuthority("ROLE_USER")

                        // ===== ADMIN =====
                        .requestMatchers("/api/product/add").hasAuthority("ROLE_ADMIN")
                        .requestMatchers("/api/product/update").hasAuthority("ROLE_ADMIN")
                        .requestMatchers("/api/product/remove").hasAuthority("ROLE_ADMIN")

                        .requestMatchers("/api/order/list").hasAuthority("ROLE_ADMIN")
                        .requestMatchers("/api/order/status").hasAuthority("ROLE_ADMIN")

                        .anyRequest().authenticated())

                // USER FILTER
                .addFilterBefore(jwtAuthFilter, UsernamePasswordAuthenticationFilter.class);

        return http.build();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}