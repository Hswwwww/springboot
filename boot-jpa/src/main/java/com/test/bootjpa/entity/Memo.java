package com.test.bootjpa.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Getter
@ToString
@Table(name="tblMemo")
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Memo {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE , generator = "memo_seq_generator") // > 이게 오라클 정책을 따른다느느..?
    @SequenceGenerator(name = "memo_seq_generator" , sequenceName = "seqMemo", allocationSize = 1)
    private Long seq;

    private String memo;
    private LocalDate regdate;
    private Long aseq;


}

