package com.test.bootjpa.dto;

import com.test.bootjpa.entity.Address;
import lombok.*;

@Getter
@Setter
@ToString
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class AddressDTO {

    private Long seq;
    private String name;
    private Integer age;
    private String address;
    private String gender;

    public AddressDTO(String name, String address){
        this.name = name;
        this.address = address;
    }

    //JPQL 멤버
    private String city;
    private int birth;


    public static Address toEntity(AddressDTO addressDTO) {
        //DTO > Entity
        return Address.builder()
                .seq(addressDTO.getSeq())
                .name(addressDTO.getName())
                .age(addressDTO.getAge())
                .address(addressDTO.getAddress())
                .gender(addressDTO.getGender())
                .build();
    }

}


