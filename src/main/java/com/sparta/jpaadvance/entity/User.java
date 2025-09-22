package com.sparta.jpaadvance.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.action.internal.OrphanRemovalAction;

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
    // 영속성전이 cascade.persist, 삭제할 시는 cascade.remove
    // orphanRomoval의 디폴트는 false이고 cascade.remove의 옵션과 비슷하나 orphanremoval은 연관관계만 끊겨도 삭제된다
    // @ManyToOne은 orphanRemoval이 없다 -> Many이기에 연관관계가 설정된 레코드가 있을 수 있기 때문에
    @OneToMany(mappedBy = "user",  cascade = CascadeType.PERSIST, orphanRemoval = true)
    private List<Food> foodList = new ArrayList<>();

    public void addFoodList(Food food) {
        this.foodList.add(food);
        food.setUser(this); // 외래 키 설정
    }
}