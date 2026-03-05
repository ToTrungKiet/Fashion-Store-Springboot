package com.fashionstore.backend.controller;

import com.fashionstore.backend.service.UserService;
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
}