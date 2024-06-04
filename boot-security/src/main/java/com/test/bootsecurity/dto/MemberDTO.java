package com.test.bootsecurity.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberDTO {

    // 회원가입할떄 사용자 내용을 전달해주고, 로그인할떄 입력받은 정보를 전달해주는 역할 밖에 없음, 출력 하진 않음..

    private String username;
    private String password;
    private String role;


}
