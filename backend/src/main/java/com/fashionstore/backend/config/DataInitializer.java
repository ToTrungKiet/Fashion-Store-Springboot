// package com.fashionstore.backend.config;

// import com.fashionstore.backend.entity.Role;
// import com.fashionstore.backend.entity.User;
// import com.fashionstore.backend.repository.RoleRepository;
// import com.fashionstore.backend.repository.UserRepository;

// import org.springframework.boot.CommandLineRunner;
// import org.springframework.context.annotation.Bean;
// import org.springframework.context.annotation.Configuration;
// import org.springframework.security.crypto.password.PasswordEncoder;

// @Configuration
// public class DataInitializer {

//     @Bean
//     CommandLineRunner initAdmin(
//             UserRepository userRepository,
//             RoleRepository roleRepository,
//             PasswordEncoder passwordEncoder) {

//         return args -> {

//             if (userRepository.findByEmail("admin@fashionstore.com").isEmpty()) {

//                 Role adminRole = roleRepository.findByName("ROLE_ADMIN")
//                         .orElseThrow(() -> new RuntimeException("ROLE_ADMIN không tồn tại"));

//                 User admin = new User();
//                 admin.setName("Admin");
//                 admin.setEmail("admin@fashionstore.com");
//                 admin.setPassword(passwordEncoder.encode("123456@Zz"));

//                 admin.getRoles().add(adminRole);

//                 userRepository.save(admin);

//                 System.out.println("Admin account created!");
//             }
//         };
//     }
// }