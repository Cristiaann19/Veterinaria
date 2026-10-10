package com.example.vet.Config;

import java.time.Duration;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.web.client.RestClient;

@Configuration
public class MiapiConfig {

    @Value("${miapi.url}")
    private String miapiUrl;

    @Value("${miapi.token}")
    private String miapiToken;

    @Bean
    public RestClient miapiRestClient() {
        SimpleClientHttpRequestFactory factory = new SimpleClientHttpRequestFactory();
        factory.setConnectTimeout(Duration.ofSeconds(5));
        factory.setReadTimeout(Duration.ofSeconds(10));
        return RestClient.builder()
                .baseUrl(miapiUrl)
                .requestFactory(factory)
                .defaultHeader("Authorization", "Bearer " + miapiToken)
                .defaultHeader("Content-Type", "application/json")
                .build();
    }
}
