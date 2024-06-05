package com.test.keylog.mapper;

import com.test.keylog.dto.BoardDTO;
import com.test.keylog.dto.UserDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper // baen이 됨
public interface AddressMapper {

    String time();

    List<BoardDTO> view();


    UserDTO mypage(String userid);
}
