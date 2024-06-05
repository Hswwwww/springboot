package com.test.keylog.controller;

import com.test.keylog.dto.BoardDTO;
import com.test.keylog.dto.UserDTO;
import com.test.keylog.mapper.AddressMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class MyBatisController {

    private final AddressMapper addressMapper;




    @GetMapping(value="/")
    public String boardList(Model model ) {
        List<BoardDTO> boardList =  addressMapper.view();

        model.addAttribute("boardList", boardList);

        return "index";
    }


    @GetMapping(value="/mypage.do")
    public String myPage(Model model , @RequestParam("userid") String userid) {
        UserDTO mypage =  addressMapper.mypage(userid);

        model.addAttribute("mypage", mypage);

        return "mypage";
    }

    @GetMapping(value="/create")
    public String create(Model model) {

        return "";
        
    }

}
