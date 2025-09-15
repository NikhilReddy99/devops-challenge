package com.example.user;
import org.springframework.web.bind.annotation.*;
import java.util.Map;
@RestController
public class Controller {
  @GetMapping("/")
  public Map<String,String> hello(){ return Map.of("status","ok"); }
}
