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

    @OneToMany(mappedBy = "user") // 외래키 주인의 필드를 mappedBy 값으로 지정(Food클래스의 user필드)
    private List<Food> foodList = new ArrayList<>();

    public void addFoodList(Food food) {
        this.foodList.add(food);
        food.setUser(this); // 외래 키(연관 관계) 설정
    }
}