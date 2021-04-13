CREATE TABLE НАНИМАТЕЛЬ
(
    ИДЕНТИФИКАТОР           SERIAL          PRIMARY KEY,
    НАЗВАНИЕ                VARCHAR(64)     NOT NULL,
    "МЕСТО РАСПОЛОЖЕНИЯ"    VARCHAR(100)    NOT NULL,
    "ЛЬГОТА, %"             SMALLINT        NOT NULL,
    CHECK ("ЛЬГОТА, %" >= 0 AND "ЛЬГОТА, %" <= 100)
);

CREATE TABLE "БЮРО НАЙМА"
(
    ИДЕНТИФИКАТОР           SERIAL          PRIMARY KEY,
    НОМЕР                   VARCHAR(5)      NOT NULL,
    "АДРЕС КОНТОРЫ"         VARCHAR(100)    NOT NULL,
    "ПЛАТА ЗА УСЛУГИ, %"    SMALLINT        NOT NULL,
    CHECK ("ПЛАТА ЗА УСЛУГИ, %" >= 0 AND "ПЛАТА ЗА УСЛУГИ, %" <= 100)
);

CREATE TABLE ПРОФЕССИИ
(
    ИДЕНТИФИКАТОР           SERIAL          PRIMARY KEY,
    НАЗВАНИЕ                VARCHAR(30)     NOT NULL,
    "СТОИМОСТЬ НАЙМА, РУБ"  INT             NOT NULL,
    КОЛИЧЕСТВО              SMALLINT        NOT NULL,
    "МЕСТО ПРЕЖНЕЙ РАБОТЫ"  VARCHAR(100),
    CHECK ("СТОИМОСТЬ НАЙМА, РУБ" > 0 AND "КОЛИЧЕСТВО" > 0)
);

CREATE TABLE "ТРУДОВОЙ ДОГОВОР"
(
    "НОМЕР ДОГОВОРА"        SERIAL          PRIMARY KEY,
    ДАТА                    VARCHAR(10)     NOT NULL,
    НАНИМАТЕЛЬ              SERIAL          NOT NULL REFERENCES НАНИМАТЕЛЬ (ИДЕНТИФИКАТОР),
    "БЮРО НАЙМА"            SERIAL          NOT NULL REFERENCES "БЮРО НАЙМА" (ИДЕНТИФИКАТОР),
    ПРОФЕССИЯ               SERIAL          NOT NULL REFERENCES ПРОФЕССИИ (ИДЕНТИФИКАТОР),
    "КОЛИЧЕСТВО ВАКАНСИЙ"   SMALLINT        NOT NULL,
    "ОПЛАТА, РУБ"           INT             NOT NULL,
    CHECK ("КОЛИЧЕСТВО ВАКАНСИЙ" > 0 AND "ОПЛАТА, РУБ" > 0)
);
