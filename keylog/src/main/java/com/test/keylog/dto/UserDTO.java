package com.test.keylog.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class UserDTO {

    private String id;
    private String password;
    private String name;
    private String nickname;
    private String tel;
    private String address;
    private String state;
    private String userLevel;
    private String score;
    private String userImg;
    private String reportCnt;
    private String likeCnt;
    private String scraCnt;
    private String followCnt;
    private String followingCnt;

}
