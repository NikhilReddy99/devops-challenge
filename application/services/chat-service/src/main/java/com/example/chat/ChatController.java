package com.example.chat;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import java.util.Map;
@Controller
public class ChatController {
  @MessageMapping("/chat")
  @SendTo("/topic/messages")
  public String handle(Map<String,Object> payload) {
    Object content = payload.getOrDefault("content", "");
    return content.toString();
  }
}
