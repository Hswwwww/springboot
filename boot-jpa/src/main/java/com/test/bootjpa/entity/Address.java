package com.test.bootjpa.entity;

import com.test.bootjpa.dto.AddressDTO;
import jakarta.persistence.*;
import lombok.*;

import java.util.List;

//Entity
//- 데이터베이스의 테이블과 연결된 객체
@Entity
@Getter
@ToString
@Table(name="tblAddress") //tbl_address
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Address {
// 우리눈에는 자바지만 jpa개념에서는 address테이블이다. > 지금 테이블 만드는 중..

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE , generator = "address_seq_generator") // > 이게 오라클 정책을 따른다느느..?
    @SequenceGenerator(name = "address_seq_generator" , sequenceName = "seqAddress", allocationSize = 1)
    private Long seq;

    private String name;
    private Integer age;
    private String address;
    private String gender;


    @OneToMany
    @JoinColumn(name="aseq")
    private List<Memo> memo;


    public static AddressDTO toDTO(Address address){
        //엔티티 > DTO
        return AddressDTO.builder()
                .seq(address.getSeq())
                .name(address.getName())
                .age(address.getAge())
                .address(address.getAddress())
                .gender(address.getGender())
                .build();
    }

    public void updateAddress(String address, Integer age){
        this.address = address;
        this.age = age;
    }



}










