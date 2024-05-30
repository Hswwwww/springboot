package com.test.bootjpa.controller;

import com.test.bootjpa.entity.Address;
import com.test.bootjpa.repository.AddressRepository;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.Optional;

@Controller
@RequiredArgsConstructor
public class AddressController {

    private final AddressRepository addressRepository;

    @GetMapping("/m01.do")
    public String m01(Model model){
        //[C]RUD
        //- 레코드 추가하기
        //- 추가할 레코드의 정보 > 엔티티 객체를 생성하기
        Address address = Address.builder()
                .name("꿀꿀이")
                .age(5)
                .address("서울특별시 강남구 역삼동 한돈 빌딩")
                .gender("m")
                .build();

        Address result = addressRepository.save(address); //

        model.addAttribute("address", Address.toDTO(result));

        return "result_dto";


    }


    @GetMapping("/m02.do")
    public String m02(Model model) {
        //C[R]UD
        //- 1개의 레코드 가져오기
        //addressRepository.getById(56L);
        Optional<Address> address = addressRepository.findById(54L); // null일때 코드 에러발생 안하게 해줌..

//        if(address.isPresent()){
//            model.addAttribute("address", Address.toDTO(address.get()));
//        }

        address.ifPresent(value -> model.addAttribute("address", Address.toDTO(value)));

        return "result_dto";
    }

    @GetMapping("/m03.do")
    public String m03(Model model) {
        //CU[R]D
        //- 레코드 수정하기
        //1. 생성 후 수정
        //2. 검색 후 수정

//        Address address = Address.builder()
//                .seq(56L)
//                .name("꿀꿀이")
//                .age(5)
//                .address("서울특별시 강남구 역삼동 한돈 빌딩 8층")
//                .gender("m")
//                .build();

        Address address = addressRepository.findById(56L).get();
        address.updateAddress("서울특별시 강동구", 6);

        Address result = addressRepository.save(address);

        model.addAttribute("address", Address.toDTO(result));

        System.out.println(addressRepository);

        return "result_dto";
    }

    @GetMapping("/m04.do")
    public String m04(Model model) {
        //CUR[D]
        //- 레코드 삭제하기

        //Address address = addressRepository.findById(56L).get();

        Address address = Address.builder()
                .seq(55L)
                .build();
        addressRepository.delete(address);

        return "result_dto";
    }
}
