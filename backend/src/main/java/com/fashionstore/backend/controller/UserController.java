package com.fashionstore.backend.controller;

import com.fashionstore.backend.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/user")
public class UserController {

    @Autowired
    private UserService userService;

    @PostMapping("/register")
    public Map<String, Object> registerUser(@RequestBody Map<String, String> body) {

        String name = body.get("name");
        String email = body.get("email");
        String password = body.get("password");

        return userService.registerUser(name, email, password);
    }

    @PostMapping("/login")
    public Map<String, Object> loginUser(@RequestBody Map<String, String> body) {

        String email = body.get("email");
        String password = body.get("password");

        return userService.loginUser(email, password);
    }

    @PostMapping("/admin")
    public Map<String, Object> adminLogin(@RequestBody Map<String,String> body){
        return userService.adminLogin(
                body.get("email"),
                body.get("password")
        );
    }

    @PostMapping("/forgot-password")
    public Map<String, Object> forgotPassword(@RequestBody Map<String, String> body) {
        return userService.forgotPassword(body.get("email"));
    }

    @PostMapping("/reset-password")
    public Map<String, Object> resetPassword(@RequestBody Map<String, String> body) {
        return userService.resetPassword(
                body.get("token"),
                body.getOrDefault("newPassword", body.get("password")),
                body.get("confirmPassword"));
    }

    @PostMapping("/profile")
    public Map<String, Object> getProfile(HttpServletRequest request) {
        Long userId = Long.parseLong(request.getAttribute("userId").toString());
        return userService.getProfile(userId);
    }

    @PostMapping("/update-profile")
    public Map<String, Object> updateProfile(
            HttpServletRequest request,
            @RequestBody Map<String, String> body) {
        Long userId = Long.parseLong(request.getAttribute("userId").toString());
        return userService.updateProfile(
                userId,
                body.get("firstName"),
                body.get("lastName"),
                body.get("email"),
                body.get("address"),
                body.get("ward"),
                body.get("district"),
                body.get("city"),
                body.get("phone"));
    }

    @PostMapping("/change-password")
    public Map<String, Object> changePassword(
            HttpServletRequest request,
            @RequestBody Map<String, String> body) {
        Long userId = Long.parseLong(request.getAttribute("userId").toString());
        return userService.changePassword(
                userId,
                body.get("currentPassword"),
                body.get("newPassword"),
                body.get("confirmPassword"));
    }
}
