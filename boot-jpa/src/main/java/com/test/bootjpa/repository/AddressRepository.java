package com.test.bootjpa.repository;

import com.test.bootjpa.entity.Address;
import org.springframework.data.jpa.repository.JpaRepository;

//JpaRespository<엔티티, 인티티 @Id 자료형>
public interface AddressRepository extends JpaRepository<Address, Long> {

}
