# SQL-for-studing

## УРОВЕНЬ 1 

      1.	Дана схема базы данных в виде следующих отношений. 
      С помощью операторов SQL создать логическую структуру соответствующих таблиц для хранения в СУБД
      используя известные средства поддержания целостности (NOT NULL, UNIQUE, и т.д.).
      Обосновать выбор типов данных и используемые средства поддержания целостности. 
      При выборе подходящих типов данных  использовать информацию о конкретных значениях полей БД 

```SQL
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
```


      2.  Ввести в ранее созданные таблицы конкретные данные (см. прил. 1). 
      Использовать скрипт-файл из операторов INSERT или вспомогательную утилиту .

```SQL
INSERT INTO "НАНИМАТЕЛЬ" ("ИДЕНТИФИКАТОР", "НАЗВАНИЕ", "МЕСТО РАСПОЛОЖЕНИЯ", "ЛЬГОТА, %")
VALUES (001, 'Рога и копыта',            'Приморск',    0),
       (002, 'ГАЗ',                      'Н. Новгород', 20),
       (003, 'Станкостроительный завод', 'Одесса',      2),
       (004, 'КИНАП',                    'Одесса',      2),
       (005, 'КРАЗ',                     'Кременчук',   2),
       (006, 'п\я 12687-у',              'Саранск',     10);

INSERT INTO "БЮРО НАЙМА" ("ИДЕНТИФИКАТОР", "НОМЕР", "АДРЕС КОНТОРЫ", "ПЛАТА ЗА УСЛУГИ, %")
VALUES (001, 'N5',  'Н. Новгород',   4),
       (002, 'N4',  'Москва',        3),
       (003, 'N12', 'Киев',          11),
       (004, 'N6',  'Н. Новгород',   3),
       (005, 'N8',  'Одесса',        9);

INSERT INTO "ПРОФЕССИИ" ("ИДЕНТИФИКАТОР", "НАЗВАНИЕ", "СТОИМОСТЬ НАЙМА, РУБ", "КОЛИЧЕСТВО", "МЕСТО ПРЕЖНЕЙ РАБОТЫ")
VALUES (001, 'Кровельщик',   10000, 7,  'Саранск'),
       (002, 'Слесарь',      15000, 6,  'Кременчуг'),
       (003, 'Счетовод',     25000, 10, 'Москва'),
       (004, 'Фрезеровщик',  20000, 7,  'Одесса'),
       (005, 'Программист',  40000, 8,  'Киев'),
       (006, 'Автоводитель', 25000, 3,  'Приморск'),
       (007, 'Шлифовальщик', 17000, 5,  'Одесса');

INSERT INTO "ТРУДОВОЙ ДОГОВОР" ("НОМЕР ДОГОВОРА", "ДАТА", "НАНИМАТЕЛЬ", "БЮРО НАЙМА", "ПРОФЕССИЯ", "КОЛИЧЕСТВО ВАКАНСИЙ", "ОПЛАТА, РУБ")
VALUES  (00127,     'Январь',   003,    004,    006,    1,  25000),
        (00128,     'Февраль',  006,    002,    001,    2,  20000),
        (00129,     'Март',     001,    003,    004,    1,  20000),
        (00130,     'Апрель',   002,    001,    007,    2,  34000),
        (00131,     'Апрель',   004,    004,    006,    1,  25000),
        (00132,     'Апрель',   006,    004,    001,    1,  10000),
        (00133,     'Май',      005,    002,    005,    3,  120000),
        (00134,     'Май',      003,    003,    002,    3,  45000),
        (00135,     'Май',      003,    004,    001,    1,  10000),
        (00136,     'Июнь',     004,    001,    003,    4,  100000),
        (00137,     'Июнь',     001,    002,    002,    3,  45000),
        (00138,     'Июнь',     001,    003,    007,    1,  17000),
        (00139,     'Июнь',     005,    004,    001,    2,  20000),
        (00140,     'Июнь',     003,    005,    002,    1,  15000),
        (00141,     'Июнь',     003,    005,    002,    1,  15000),
        (00142,     'Июнь',     004,    002,    006,    1,  25000),
        (00143,     'Сентябрь', 002,    002,    007,    2,  34000);
```

      3.  Используя оператор SELECT создать запрос для вывода всех строк каждой таблицы.
      Проверить правильность ввода. 
      При необходимости произвести коррекцию значений операторами INSERT, UPDATE

```SQL
SELECT * FROM НАНИМАТЕЛЬ;
```
![screenshot 1](https://github.com/SidNotSus/SQL-for-studing/raw/main/images/s1.jpg)

```SQL
SELECT * FROM "БЮРО НАЙМА";
```
![screenshot 2](https://github.com/SidNotSus/SQL-for-studing/raw/main/images/s2.jpg)

```SQL
SELECT * FROM ПРОФЕССИИ;
```
![screenshot 3](https://github.com/SidNotSus/SQL-for-studing/raw/main/images/s3.jpg)

```SQL
SELECT * FROM "ТРУДОВОЙ ДОГОВОР";
```
![screenshot 4](https://github.com/SidNotSus/SQL-for-studing/raw/main/images/s4.jpg)

      4.  Создать запросы для вывода:

      a)	названий всех нанимателей, вместе с местом их расположения;      
```SQL
SELECT "НАЗВАНИЕ", "МЕСТО РАСПОЛОЖЕНИЯ"
FROM НАНИМАТЕЛЬ;
```
![screenshot 5](https://github.com/SidNotSus/SQL-for-studing/raw/main/images/s5.jpg)

      b)	всех номеров бюро найма;
```SQL
SELECT "НОМЕР"
FROM "БЮРО НАЙМА";
```
![screenshot 6](https://github.com/SidNotSus/SQL-for-studing/raw/main/images/s6.jpg)

      c)	всех различных предоставленных профессий вместе с их количеством.
```SQL
SELECT DISTINCT "НАЗВАНИЕ", "КОЛИЧЕСТВО"
FROM "ПРОФЕССИИ";
```
![screenshot 7](https://github.com/SidNotSus/SQL-for-studing/raw/main/images/s7.jpg)


      5.  Создать запросы для получения инорфмации о:

      a)	названии и месте расположения нанимателей, имеющих льготу менее 8%;
```SQL
SELECT "НАЗВАНИЕ", "МЕСТО РАСПОЛОЖЕНИЯ"
FROM НАНИМАТЕЛЬ
WHERE "ЛЬГОТА, %" < 8
```
![screenshot 8](https://github.com/SidNotSus/SQL-for-studing/raw/main/images/s8.jpg)

      b)	профессиях, имеющих стоиомость найма более 10000руб. для которых Москва не была местом прежней работы;
```SQL
SELECT "НАЗВАНИЕ"
FROM ПРОФЕССИИ
WHERE "СТОИМОСТЬ НАЙМА, РУБ" > 10000 AND "МЕСТО ПРЕЖНЕЙ РАБОТЫ" != "Москва"
```
![screenshot 9](https://github.com/SidNotSus/SQL-for-studing/raw/main/images/s9.jpg)

      c)	Названиях  и расположении нанимателей, в названии которых присутствует слово “завод” и имеющих льготы.
            Вывод результатов организовать по названию и убыванию льгот.
```SQL
SELECT "НАЗВАНИЕ", "МЕСТО РАСПОЛОЖЕНИЯ"
FROM НАНИМАТЕЛЬ
WHERE lower("НАЗВАНИЕ") LIKE lower('%завод%')
  AND "ЛЬГОТА, %" != 0
ORDER BY "НАЗВАНИЕ", "ЛЬГОТА, %" DESC
```
![screenshot 10](https://github.com/SidNotSus/SQL-for-studing/raw/main/images/s10.jpg)

      6.	Для каждого трудового договора вывести следующие данные:
            a)	название нанимателя, дату, название бюро найма;
            b)	дату, название бюро найма, название и количество заказанных профессий.

      7.	Определить:
            a)	дату, номер договора, название предприятий заказавших автоводителей или сделавших заказ на общую сумму не менее 14000руб.
            b)	номера тех бюро найма вместе с адресами, которые предоставляли услуги организациям со льготами менее 7% после февраля месяца;
            c)	предприятия, расположенные в любом городе, кроме Москвы, которые пользовались услугами бюро найма с платой за услуги более 3%;
            d)	данные по заказу специальностей, у которых не изменился адрес работы. Включить данные о стоимости и отсортировать по возрастанию. 

      8.	Создать запрос для модификации всех значений столбца с суммарной величиной оплаты заказа, чтобы он содержал истинную сумму, оплачиваемую нанимателем ( с учетом льгот). Вывести новые значения.

      9.	Расширить таблицу с данными о заказах столбцом, содержащим величину платы за услуги, получаемую бюро найма. Создать запрос для ввода конкретных значений во все строки таблицы покупок.

УРОВЕНЬ 2


10.	Используя операцию IN (NOT IN)  реализовать следующие запросы:
      a)	определить бюро найма, которые заключали договора с нанимателями из Н.Новгрода;
      b)	найти профессии, которые не требовались нанимателям с размером льгот менее 10%;
      c)	запросы заданий 7.а, 7.b.

11.	Используя операции ALL-ANY реализовать следующие запросы:
      a)	на рабочих каких профессий заключались договора с максимальным количеством рабочих мест;
      b)	найти нанимателя, заключившего самый дорогой договор с бюро найма из чужого города;
      c)	запрос задания 7.c;
      d)	найти профессию с максимальной стоимостью среди тех, которые заказывали предприятия из Н.Новгрода

12.	Используя операцию UNION получить места расположения предприятий-заказчиков и бюро найма.

13.	Используя операцию EXISTS ( NOT EXISTS ) реализовать нижеследующие запросы. В случае, если для текущего состояния БД запрос будет выдавать пустое множество строк, требуется указать какие добавления в БД необходимо провести.
      a)	найти профессии, заказывавшиеся всеми предприятиями не из Приморска;
      b)	найти такие бюро найма, которые участвовали в заключении договоров на все профессии со стоимостью найма более 15000руб.
      c)	какие бюро найма не заключали договора на профессии, рабочие которых не изменили своего адреса работы;
      d)	определить нанимателей, которые производили все заказы стоимостью не менее 100000руб. в апреле месяце.

14.	Реализовать запросы с использованием аггрегатных функций:
      a)	определить средний размер платы за услуги для тех бюро найма, которые заключали договор со всеми предприятиями из Одессы;
      b)	найти суммарную стоимость всех заключенных договоров;
      c)	определить число различных профессий, заказанных до января предприятиями Н.Новгорода;
      d)	найти среднее число заказываемых вакансий для профессий со стоимостью более 20000.

15.	Используя средства группировки реализовать следующие запросы:
      a)	получить для каждой пары “предприятие-бюро найма” суммарную величину стоимости заключенных договоров;
      b)	найти для каждого бюро найма общее число договоров, вывести данные для тех бюро найма, где число договоров больше двух;
      c)	определить для каждого города, где размещаются предприятия, количество предприятий;
      d)	получить для каждого месяца и бюро найма суммарную величину стоимости договоров, вывести только те значения, где суммарная стоимость более 200000.

