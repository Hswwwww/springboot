package com.test.bootsecurity.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration //빈등록!
@EnableWebSecurity // 시큐리티가 동작하는 환경설정
public class SecurityConfig {


    @Bean
    public BCryptPasswordEncoder bCryptPasswordEncoder() {
            // 사용자가 로그인할떄 패스워드를 인코딩하여 집어넣어주는 역할 > 왜? 인코딩해야하니까..
        return new BCryptPasswordEncoder();
    }
    //대부분의 시큐리티 설정을 한다.
    @Bean
     public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {





        //URI 허가
        http.authorizeRequests(auth -> auth
                //순서가 중요 위에 설정한 애가 절대적
//                .requestMatchers("/").permitAll()
//                .requestMatchers("/login").permitAll()
//                .requestMatchers("/loginok").permitAll()
                .requestMatchers("/", "/login").permitAll()
                .requestMatchers("/join", "/joinok").permitAll()
                .anyRequest().authenticated() // 나머지 경로 > 인증 받은 사용자에게만 허용

        );

        //개발 시 > CSRF 비활성화
        http.csrf(auth -> auth.disable()); //잠시 토큰을 안넘겨도 csrf에러가 안뜸!


        //커스텀 로그인 페이지
        http.formLogin(auth -> auth
                .loginPage("/login") //로그인 폼 페이지 URL
                .loginProcessingUrl("/loginok").permitAll() // action주소는 우리가 안만들고 sprinf이 해줌
        );




        return http.build();
     }

}









