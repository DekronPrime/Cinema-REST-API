package com.miromax.cinema.models;

import com.miromax.cinema.models.enums.CommentStatus;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "comments")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class Comment {
    @Id
    @GeneratedValue
    private Long id;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne
    @JoinColumn(name = "movie_id", nullable = false)
    private Movie movie;

/*    @OneToMany
    private List<Comment> replies = new ArrayList<>();*/

    @Column(name = "content", nullable = false)
    private String content;
    @Column(name = "written_at", nullable = false)
    private LocalDateTime writtenAt;
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    @Column(name = "likes")
    private Integer likes;
    @Column(name = "dislikes")
    private Integer dislikes;
    @Column(name = "status", nullable = false)
    @Enumerated(EnumType.STRING)
    private CommentStatus status;
}