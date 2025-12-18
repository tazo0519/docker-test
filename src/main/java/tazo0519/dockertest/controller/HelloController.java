package tazo0519.dockertest.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class HelloController {

    private final RedisTemplate<String, String> redisTemplate;

    @GetMapping
    public String hello() {
        redisTemplate.opsForValue().set("hello", "world");
        return "Hello Docker World!";
    }
}
