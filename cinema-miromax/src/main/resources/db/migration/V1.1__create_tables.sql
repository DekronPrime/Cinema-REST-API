CREATE TABLE actors
(
    id           BIGINT      NOT NULL
        CONSTRAINT actors_pk PRIMARY KEY,
    first_name   VARCHAR(50) NOT NULL,
    middle_name  VARCHAR(50),
    last_name    VARCHAR(50) NOT NULL,
    portrait_url TEXT        NOT NULL,
    popularity   SMALLINT    NOT NULL CHECK ( popularity BETWEEN 0 AND 3 ),
    country_id   BIGINT      NOT NULL
);

CREATE TABLE bookings
(
    id           BIGINT       NOT NULL
        CONSTRAINT bookings_pk PRIMARY KEY,
    session_id   BIGINT       NOT NULL,
    user_id      BIGINT       NOT NULL,
    total_price  INTEGER      NOT NULL,
    booked_seats jsonb        NOT NULL,
    created_at   TIMESTAMP    NOT NULL DEFAULT now(),
    updated_at   TIMESTAMP    NOT NULL DEFAULT now(),
    status       VARCHAR(255) NOT NULL DEFAULT 'PENDING' CHECK ( status in ('PENDING', 'CONFIRMED', 'CANCELLED') )
);

CREATE TABLE cities
(
    id         BIGINT       NOT NULL PRIMARY KEY,
    name       VARCHAR(100) NOT NULL
        CONSTRAINT cities_name_uq UNIQUE,
    country_id BIGINT       NOT NULL
);

CREATE TABLE comments
(
    id         BIGINT       NOT NULL
        CONSTRAINT comments_pk PRIMARY KEY,
    user_id    BIGINT       NOT NULL,
    movie_id   BIGINT       NOT NULL,
    content    TEXT         NOT NULL,
    written_at TIMESTAMP    NOT NULL DEFAULT now(),
    updated_at TIMESTAMP    NOT NULL DEFAULT now(),
    likes      INTEGER,
    dislikes   INTEGER,
    status     VARCHAR(255) NOT NULL DEFAULT 'UNVERIFIED' CHECK ( status in ('UNVERIFIED', 'APPROVED', 'SPAM', 'VIOLATION', 'DELETED') )
);

create table countries
(
    id       BIGINT       NOT NULL
        CONSTRAINT countries_pk PRIMARY KEY,
    code     VARCHAR(3)   NOT NULL
        CONSTRAINT countries_code_uq UNIQUE,
    name     VARCHAR(100) NOT NULL
        CONSTRAINT countries_name_uq UNIQUE,
    flag_url TEXT         NOT NULL
);

CREATE TABLE directors
(
    id           BIGINT      NOT NULL
        CONSTRAINT directors_pk PRIMARY KEY,
    first_name   VARCHAR(50) NOT NULL,
    middle_name  VARCHAR(50),
    last_name    VARCHAR(50) NOT NULL,
    portrait_url TEXT        NOT NULL,
    country_id   BIGINT      NOT NULL
);

CREATE TABLE genres
(
    id   BIGINT      NOT NULL
        CONSTRAINT genres_pk PRIMARY KEY,
    name varchar(50) NOT NULL
        CONSTRAINT genres_name_uq UNIQUE
);

CREATE TABLE halls
(
    id          BIGINT       NOT NULL
        CONSTRAINT halls_pk PRIMARY KEY,
    location_id BIGINT       NOT NULL,
    name        VARCHAR(50),
    type        VARCHAR(255) NOT NULL CHECK ( type in ('DEFAULT', 'MIXED', 'ONYX') ),
    created_at  TIMESTAMP    NOT NULL DEFAULT now(),
    updated_at  TIMESTAMP    NOT NULL DEFAULT now()
);

CREATE TABLE locations
(
    id            BIGINT       NOT NULL
        CONSTRAINT locations_pk PRIMARY KEY,
    city_id       BIGINT       NOT NULL,
    shopping_mall VARCHAR(255) NOT NULL,
    address       VARCHAR(255) NOT NULL,
    details       TEXT,
    created_at    TIMESTAMP    NOT NULL DEFAULT now(),
    updated_at    TIMESTAMP    NOT NULL DEFAULT now()
);

CREATE TABLE movies
(
    id                BIGINT           NOT NULL
        CONSTRAINT movies_pk PRIMARY KEY,
    title_ukr         VARCHAR(255)     NOT NULL,
    title_original    VARCHAR(255)     NOT NULL,
    poster_url        TEXT             NOT NULL,
    year              INTEGER          NOT NULL,
    dub_language      VARCHAR(255)     NOT NULL DEFAULT 'UKRAINIAN' CHECK ( dub_language in ('UKRAINIAN', 'ENGLISH') ),
    country_id        BIGINT           NOT NULL,
    age_limit         VARCHAR(255)     NOT NULL CHECK ( age_limit in
                                                        ('0+', '2+', '4+', '6+', '8+', '10+',
                                                         '12+', '14+', '16+', '18+') ),
    duration          INTEGER          NOT NULL,
    imdb_rating       DOUBLE PRECISION NOT NULL,
    description       TEXT             NOT NULL,
    trailer_url       TEXT             NOT NULL,
    format            VARCHAR(255)     NOT NULL DEFAULT '2D' CHECK ( format in ('2D', '3D') ),
    likes             INTEGER,
    dislikes          INTEGER,
    start_rental_date DATE             NOT NULL,
    final_rental_date DATE             NOT NULL,
    created_at        TIMESTAMP        NOT NULL DEFAULT now(),
    updated_at        TIMESTAMP        NOT NULL DEFAULT now(),
    status            VARCHAR(255)     NOT NULL DEFAULT 'ACTIVE' CHECK ( status in ('EXPIRED', 'ACTIVE', 'UPCOMING') )
);

CREATE TABLE seat_rows
(
    id       BIGINT       NOT NULL
        CONSTRAINT seat_rows_pk PRIMARY KEY,
    hall_id  BIGINT       NOT NULL,
    number   INTEGER      NOT NULL,
    type     VARCHAR(255) NOT NULL DEFAULT 'DEFAULT' CHECK ( type in ('DEFAULT', 'LUXURY') ),
    capacity INTEGER      NOT NULL,
    price    INTEGER      NOT NULL
);

CREATE TABLE sessions
(
    id             BIGINT       NOT NULL
        CONSTRAINT sessions_pk PRIMARY KEY,
    movie_id       BIGINT       NOT NULL,
    hall_id        BIGINT       NOT NULL,
    start_time     TIMESTAMP    NOT NULL,
    end_time       TIMESTAMP    NOT NULL,
    prices         INTEGER[]    NOT NULL,
    occupied_seats jsonb                 DEFAULT '{}'::jsonb,
    created_at     TIMESTAMP    NOT NULL DEFAULT now(),
    updated_at     TIMESTAMP    NOT NULL DEFAULT now(),
    status         VARCHAR(255) NOT NULL DEFAULT 'UPCOMING' CHECK ( status in ('EXPIRED', 'ACTIVE', 'UPCOMING'))
);

CREATE TABLE users
(
    id            BIGINT       NOT NULL
        CONSTRAINT users_pk PRIMARY KEY,
    first_name    VARCHAR(50)  NOT NULL,
    last_name     VARCHAR(50)  NOT NULL,
    email         VARCHAR(100) NOT NULL
        CONSTRAINT users_email_uq UNIQUE,
    password_hash TEXT         NOT NULL,
    phone         VARCHAR(25)  NOT NULL
        CONSTRAINT users_phone_uq UNIQUE,
    role          VARCHAR(255) NOT NULL DEFAULT 'GUEST' CHECK ( role in ('GUEST', 'MODERATOR', 'ADMIN') ),
    avatar_url    TEXT         NOT NULL,
    register_at   TIMESTAMP    NOT NULL DEFAULT now(),
    last_login_at TIMESTAMP    NOT NULL DEFAULT now(),
    status        VARCHAR(255) NOT NULL DEFAULT 'UNVERIFIED' CHECK ( status in ('UNVERIFIED', 'ACTIVE', 'DELETED') )
);

CREATE TABLE movie_actors
(
    movie_id BIGINT NOT NULL,
    actor_id BIGINT NOT NULL,
    CONSTRAINT movie_actors_pk PRIMARY KEY (movie_id, actor_id)
);

CREATE TABLE movie_directors
(
    movie_id    BIGINT NOT NULL,
    director_id BIGINT NOT NULL,
    CONSTRAINT movie_directors_pk PRIMARY KEY (movie_id, director_id)
);

CREATE TABLE movie_genres
(
    movie_id BIGINT NOT NULL,
    genre_id BIGINT NOT NULL,
    CONSTRAINT movie_genres_pk PRIMARY KEY (movie_id, genre_id)
);