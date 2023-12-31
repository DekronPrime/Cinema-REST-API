package com.miromax.cinema.models;

import com.miromax.cinema.models.enums.AgeLimit;
import com.miromax.cinema.models.enums.DubLanguage;
import com.miromax.cinema.models.enums.Format;
import com.miromax.cinema.models.enums.Status;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "movies")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class Movie {
    @Id
    @GeneratedValue
    private Long id;
    @Column(name = "title_ukr", nullable = false)
    private String titleUkr;
    @Column(name = "title_original", nullable = false)
    private String titleOriginal;
    @Column(name = "poster_url", nullable = false)
    private String posterUrl;
    @Column(name = "year", nullable = false)
    private Integer year;

    @ManyToMany(mappedBy = "movies", cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    private List<Genre> genres = new ArrayList<>();

    @Column(name = "dub_language", nullable = false)
    @Enumerated(EnumType.STRING)
    private DubLanguage dubLanguage;

    @ManyToOne
    @JoinColumn(name = "country_id", nullable = false)
    private Country country;

    @ManyToMany(mappedBy = "movies", cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    public List<Director> directors = new ArrayList<>();

    @Column(name = "age_limit", nullable = false)
    @Enumerated(EnumType.STRING)
    private AgeLimit ageLimit;
    @Column(name = "duration", nullable = false)
    private Integer duration;
    @Column(name = "imdb_rating", nullable = false)
    private Double imdbRating;
    @Column(name = "description", nullable = false)
    private String description;
    @Column(name = "trailer_url", nullable = false)
    private String trailerUrl;
    @Column(name = "format", nullable = false)
    @Enumerated(EnumType.STRING)
    private Format format;
    @Column(name = "likes", nullable = false)
    private Integer likes;
    @Column(name = "dislikes", nullable = false)
    private Integer dislikes;

    @ManyToMany(mappedBy = "movies", cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    private List<Actor> actors = new ArrayList<>();

    @OneToMany(mappedBy = "movie", cascade = CascadeType.ALL)
    private List<Comment> comments = new ArrayList<>();

    @Column(name = "start_rental_date", nullable = false)
    private LocalDate startRentalDate;
    @Column(name = "final_rental_date", nullable = false)
    private LocalDate finalRentalDate;
    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @OneToMany(mappedBy = "movie", cascade = CascadeType.ALL)
    private List<Session> sessions = new ArrayList<>();

    @Column(name = "status", nullable = false)
    @Enumerated(EnumType.STRING)
    private Status status;

    public void addComment(Comment comment) {
        comment.setMovie(this);
        comments.add(comment);
    }

    public void addSession(Session session) {
        session.setMovie(this);
        sessions.add(session);
    }
}