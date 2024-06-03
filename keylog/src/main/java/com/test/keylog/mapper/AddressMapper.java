package com.test.keylog.mapper;

import com.test.keylog.dto.BoardDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper // baen이 됨
public interface AddressMapper {

    String time();

    List<BoardDTO> view();
}
