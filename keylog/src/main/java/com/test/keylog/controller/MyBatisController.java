package com.test.keylog.controller;

import com.test.keylog.dto.BoardDTO;
import com.test.keylog.mapper.AddressMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class MyBatisController {

    private final AddressMapper addressMapper;




    @GetMapping(value="/index.do")
    public String m01(Model model ) {
        List<BoardDTO> boardList =  addressMapper.view();

        model.addAttribute("boardList", boardList);

        return "index";
    }


}
