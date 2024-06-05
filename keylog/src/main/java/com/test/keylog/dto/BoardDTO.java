package com.test.keylog.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardDTO {
    private String id;
    private String userid;
    private String content;
    private String title;
    private String regdate;
    private String viesCnt;
    private String reportCnt;
    private String likeCnt;
    private String scrapCnt;
}
