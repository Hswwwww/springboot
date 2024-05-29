package com.test.bootthymeleaf.controller;

import com.test.bootthymeleaf.dto.AddressDTO;
import com.test.bootthymeleaf.mapper.AddressMapper;
import lombok.Getter;
import org.apache.logging.log4j.message.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

@Controller
public class ThymeleafController {

    private final AddressMapper addressMapper;
    private final MessageSource messageSource;

    @Autowired
    public ThymeleafController(AddressMapper addressMapper , MessageSource messageSource) {
        this.addressMapper = addressMapper;
        this.messageSource = messageSource;

    }


    @GetMapping(value="/m01.do")
    public String m01(Model model) {

        //단일값 전달
        int num = addressMapper.num();
        String txt = addressMapper.txt();

        //객체 전달
        AddressDTO dto = addressMapper.get();
        Map<String,Integer> map = new HashMap<>();
        map.put("kor",100);
        map.put("eng",90);
        map.put("mat",80);

        model.addAttribute("num", num);
        model.addAttribute("txt", txt);
        model.addAttribute("dto", dto);
        model.addAttribute("map", map);
        return "m01";
    }


    @GetMapping(value="/m02.do")
    public String m02(Model model) {

        //스프링 메시지, Spring Message
        //- 프로젝트내에서 자주 사용되는(반복적인) 문자열
        //- 다국어 지원 > 웹페이지 한장에 한국어버전 영어버전 일본버전..  > 문자열만 다 뻬서 적용

        //- src/main/resource > "messages.properties"

        //스프링 메시지
        System.out.println(messageSource.getMessage("language", null, Locale.JAPAN));
        System.out.println(messageSource.getMessage("item.desc", new Object[] {"하나","둘"}, Locale.JAPAN));

        return "m02";
    }

    @GetMapping(value="/m03.do")
    public String m03(Model model) {

        //- 연산자
        int a = 10;
        int b = 3;

        model.addAttribute("a",a);
        model.addAttribute("b",b);

        return "m03";
    }

    @GetMapping(value="/m04.do")
    public String m04(Model model) {

        model.addAttribute("num",addressMapper.num());
        model.addAttribute("txt",addressMapper.txt());
        model.addAttribute("color","cornflowerblue");

        return "m04";
    }

    @GetMapping(value="/m05.do")
    public String m05(Model model) {

        // 콘텐츠 조작(시작태그~끝태그 사이)
        //- PCDATA 조작
        //- 자식 태그 조작
        //-innerText(textContent)
        //-innerHTML

        String txt1 ="홍길동입니다.";
        String txt2= "<b>홍길동</b>입니다.";
        String name="홍길동";

        model.addAttribute("txt1",txt1);
        model.addAttribute("txt2",txt2);
        model.addAttribute("name",name);

        return "m05";
    }



    /*

    @GetMapping(value="/m.do")
    public String m(Model model) {

        return "m";
    }

     */


}
