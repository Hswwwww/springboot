package com.test.bootjpa.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter
@ToString
@Table(name="tblInfo")
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Info {

    @Id
    private Long seq;

    private String school;
    private String country;

    @OneToOne
    @JoinColumn(name="seq")
    private Address address;


}
