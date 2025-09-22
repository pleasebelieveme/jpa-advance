package com.sparta.jpaadvance.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Setter
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;

    // 원투매니 속성 중 fetch 디폴트 lazy(지연로딩)
    // 뒤가 Many이면 리스트로 조회를 하게 되기에 지연로딩이 디폴트
    @OneToMany(mappedBy = "user")
    private List<Food> foodList = new ArrayList<>();
}