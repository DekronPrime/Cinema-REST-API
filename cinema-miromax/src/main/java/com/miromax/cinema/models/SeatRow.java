package com.miromax.cinema.models;

import com.miromax.cinema.models.enums.SeatType;
import jakarta.persistence.*;
import lombok.*;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "seat_rows")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class SeatRow {
    @Id
    @GeneratedValue
    private Long id;

    @ManyToOne
    @JoinColumn(name = "hall_id", nullable = false)
    private Hall hall;

    @Column(name = "number", nullable = false)
    private Integer number;
    @Column(name = "type", nullable = false)
    @Enumerated(EnumType.STRING)
    private SeatType type;
    @Column(name = "capacity", nullable = false)
    private Integer capacity;
    @Column(name = "price", nullable = false)
    private Integer price;
}