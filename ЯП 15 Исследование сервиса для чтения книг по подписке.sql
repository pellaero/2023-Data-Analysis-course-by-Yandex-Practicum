/*Выпускной проект. Исследование сервиса для чтения книг по подписке

СОДЕРЖАНИЕ

Шаг 1. Загрузка данных и получение общей информации

Шаг 2. Книги
2.1. Проверка на дубликаты
2.2. Распределение книг по году издания
2.3. *Сколько книг вышло после 1 января 2000 года
2.4. Букинистика и раритетные издания (1952-2001 гг.)
2.5. Ядро контента (2002-2006 гг.)
2.6. Контент после падения (2007-2020 гг.)
2.7. Пагинация книг
2.8. Жанры и переиздания
2.9. Профилирование книжных сегментов
2.10. Есть ли связь между объёмом книги (страницы) и средним рейтингом?
2.11. Какие книги имеют наибольший разброс оценок (высокая дисперсия)? Что их объединяет?
2.12. Сегментация книг: хиты, недооценённые, переоценённые, аутсайдеры

Шаг 3. Авторы
3.1. Список авторов
3.2. *Автор с самой высокой средней оценкой книг
3.3. Сезонность в публикации авторов (по месяцам)
3.4. Авторы и поляризация контента
3.5. Какие авторы сменили издательства и как это влияет на метрики их книг?

Шаг 4. Издательства
4.1. *Издательство с наибольшим числом книг толще 50 страниц
4.2. Какое издательство имеет наивысший средний рейтинг выпущенных книг?
4.3. Какие годы были наиболее продуктивны для издательств по количеству выпущенных книг?
4.4. Активные игроки на рунке книгоиздания

Шаг 5. Поведение пользователей
5.1. Проверка на разрывы в последовательности review_id и rating_id
5.2. Следы пользовательской активности как маркеры хронологических рамок существования приложения
5.3. Базовый профиль активности пользователя по id-интервалам
5.4. Анализ тренда: пользователь ускоряется, стагнирует или «остывает»?
5.5. Глобальная динамика платформы по id-таймлайну
5.6. Сколько пользователей активны во всех 10 периодах?
5.7. Количественная оценка вклада ядра пользователей
5.8. Пересечение книг у ядра пользователей и остальных пользователей
5.9. Перекрёстный анализ: рецензируют ли ядро пользователей и регулярные пользователи одни и те же книги?
5.10. Сегментация пользователей по паттерну id-интервалов
5.11. Распределение рейтингов
5.12. *Средний рейтинг и количество отзывов для каждой книги
5.13. Корреляция между рейтингом и длиной отзыва (посимвольно)
5.14. Распределение отзывов и средний рейтинг у каждой книги
5.15. Книги, которые пользователи оставили без отзывов
5.16. *Среднее количество отзывов от пользователей, которые поставили больше 48 оценок
5.17. Распределение отзывов
5.18. Аудит качества текстового контента: проверка на естественность
5.19. Анализ частотности вхождения слов в отзывах
5.20. Закон Ципфа

Шаг 6. Выводы. Ценностное предложение

ОПИСАНИЕ ПРОЕКТА
Коронавирус застал мир врасплох, изменив привычный порядок вещей. В свободное время жители городов больше не выходят на улицу, не посещают кафе и торговые центры. 
Зато стало больше времени для книг. Это заметили стартаперы — и бросились создавать приложения для тех, кто любит читать. 
Ваша компания решила быть на волне и купила крупный сервис для чтения книг по подписке. Ваша первая задача как аналитика — проанализировать базу данных, 
в которой содержится информация о книгах, издательствах, авторах, а также пользовательские обзоры книг. Эти данные помогут сформулировать ценностное предложение для нового продукта.
Символом * в содержании отмечены обязательные пункты исследования, установленные исходным проектным заданием.
Отдельный блок исследования (пп. 5.18.-5.20 включительно) посвящён верификации качества пользовательских отзывов — мы проверяем, 
насколько текстовый контент пригоден для содержательного анализа и формирования ценностного предложения.

ОПИСАНИЕ ДАННЫХ

01. Наименование таблицы: books
Содержание таблицы: данные о книгах
Наименование признака 	Описание признака
    book_id 	        идентификатор книги
    author_id 	        идентификатор автора
    title 	            название книги
    num_pages 	        количество страниц
    publication_date 	дата публикации книги
    publisher_id 	    идентификатор издателя

02. Наименование таблицы: authors
Содержание таблицы: данные об авторах
Наименование признака 	Описание признака
    author_id 	        идентификатор автора
    author 	            имя автора

03. Наименование таблицы: publishers
Содержание таблицы: данные об издательствах
Наименование признака 	Описание признака
    publisher_id 	    идентификатор издательства
    publisher 	        название издательства

04. Наименование таблицы: ratings
Содержание таблицы: данные о пользовательских оценках книг
Наименование признака 	Описание признака
    rating_id 	        идентификатор оценки
    book_id 	        идентификатор книги
    username 	        имя пользователя, оставившего оценку
    rating 	            оценка книги

05. Наименование таблицы: reviews
Содержание таблицы: данные о пользовательских обзорах на книги
Наименование признака 	Описание признака
    review_id 	        идентификатор обзора
    book_id 	        идентификатор книги
    username 	        имя пользователя, написавшего обзор
    text 	            текст обзора
*/

/* ПАРАМЕТРЫ ПОДКЛЮЧЕНИЯ К БАЗЕ ДАННЫХ

СУБД:          PostgreSQL (Managed Service for PostgreSQL, Яндекс Облако)
Хост:          rc1b-wcoijxj3yxfsf3fs.mdb.yandexcloud.net
Порт:          6432
База данных:   data-analyst-final-project-db
Пользователь:  praktikum_student
Пароль:        Sdf4$2;d-d30pp
SSL:           required (sslmode=require)

 Подключение выполняется на уровне SQL-клиента:
   • В DBeaver: создать новое соединение PostgreSQL с этими параметрами
   • В psql (командная строка):
     psql "host=rc1b-wcoijxj3yxfsf3fs.mdb.yandexcloud.net port=6432 
           dbname=data-analyst-final-project-db user=praktikum_student 
           sslmode=require"
   • В pgAdmin: создать Server → Connection с этими параметрами, 
     вкладка SSL → SSL mode = Require
*/

-- ============================================================================
-- ШАГ 1. ЗАГРУЗКА ДАННЫХ И ПОЛУЧЕНИЕ ОБЩЕЙ ИНФМОРМАЦИИ
-- ============================================================================

-- 1.1. Ознакомление с данными: первые 5 строк каждой таблицы

SELECT * FROM books LIMIT 5;
SELECT * FROM authors LIMIT 5;
SELECT * FROM publishers LIMIT 5;
SELECT * FROM ratings LIMIT 5;
SELECT * FROM reviews LIMIT 5;

-- 1.2. Количество строк в каждой таблице

SELECT 'books' AS table_name, COUNT(*) AS row_count FROM books
UNION ALL
SELECT 'authors', COUNT(*) FROM authors
UNION ALL
SELECT 'publishers', COUNT(*) FROM publishers
UNION ALL
SELECT 'ratings', COUNT(*) FROM ratings
UNION ALL
SELECT 'reviews', COUNT(*) FROM reviews
ORDER BY table_name;


-- 1.3. Структура таблиц: имена колонок и типы данных

SELECT 
    table_name,
    column_name,
    data_type,
    is_nullable,
    ordinal_position
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name IN ('books', 'authors', 'publishers', 'ratings', 'reviews')
ORDER BY table_name, ordinal_position;

-- 1.4. Проверка на пропуски (NULL-значения) в каждой таблице

-- Таблица books
SELECT 
    'books' AS table_name,
    COUNT(*) AS total_rows,
    COUNT(*) - COUNT(book_id) AS null_book_id,
    COUNT(*) - COUNT(author_id) AS null_author_id,
    COUNT(*) - COUNT(title) AS null_title,
    COUNT(*) - COUNT(num_pages) AS null_num_pages,
    COUNT(*) - COUNT(publication_date) AS null_publication_date,
    COUNT(*) - COUNT(publisher_id) AS null_publisher_id
FROM books;

-- Таблица authors
SELECT 
    'authors' AS table_name,
    COUNT(*) AS total_rows,
    COUNT(*) - COUNT(author_id) AS null_author_id,
    COUNT(*) - COUNT(author) AS null_author
FROM authors;

-- Таблица publishers
SELECT 
    'publishers' AS table_name,
    COUNT(*) AS total_rows,
    COUNT(*) - COUNT(publisher_id) AS null_publisher_id,
    COUNT(*) - COUNT(publisher) AS null_publisher
FROM publishers;

-- Таблица ratings
SELECT 
    'ratings' AS table_name,
    COUNT(*) AS total_rows,
    COUNT(*) - COUNT(rating_id) AS null_rating_id,
    COUNT(*) - COUNT(book_id) AS null_book_id,
    COUNT(*) - COUNT(username) AS null_username,
    COUNT(*) - COUNT(rating) AS null_rating
FROM ratings;

-- Таблица reviews
SELECT 
    'reviews' AS table_name,
    COUNT(*) AS total_rows,
    COUNT(*) - COUNT(review_id) AS null_review_id,
    COUNT(*) - COUNT(book_id) AS null_book_id,
    COUNT(*) - COUNT(username) AS null_username,
    COUNT(*) - COUNT(text) AS null_text
FROM reviews;

-- 1.5. Сводная информация по всем таблицам

SELECT 
    table_name,
    row_count,
    column_count
FROM (
    SELECT 'books' AS table_name, 
           (SELECT COUNT(*) FROM books) AS row_count,
           (SELECT COUNT(*) FROM information_schema.columns 
            WHERE table_name = 'books' AND table_schema = 'public') AS column_count
    UNION ALL
    SELECT 'authors', 
           (SELECT COUNT(*) FROM authors),
           (SELECT COUNT(*) FROM information_schema.columns 
            WHERE table_name = 'authors' AND table_schema = 'public')
    UNION ALL
    SELECT 'publishers', 
           (SELECT COUNT(*) FROM publishers),
           (SELECT COUNT(*) FROM information_schema.columns 
            WHERE table_name = 'publishers' AND table_schema = 'public')
    UNION ALL
    SELECT 'ratings', 
           (SELECT COUNT(*) FROM ratings),
           (SELECT COUNT(*) FROM information_schema.columns 
            WHERE table_name = 'ratings' AND table_schema = 'public')
    UNION ALL
    SELECT 'reviews', 
           (SELECT COUNT(*) FROM reviews),
           (SELECT COUNT(*) FROM information_schema.columns 
            WHERE table_name = 'reviews' AND table_schema = 'public')
) AS summary
ORDER BY table_name;

-- ============================================================================
-- ШАГ 2. КНИГИ
-- ============================================================================

-- 2.1. Проверка на дубликаты
-- Необходимо провести проверку на наличие в каталоге из 1000 книг присутствие одной и той же книги в разных изданиях (твёрдый переплёт vs мягкий, разные годы публикации).
-- Потенциально это может существенно изменить картину: если 20% каталога — переиздания, реальный размер уникального фонда составляет 800 книг.

-- проверка на дубликаты книг по названию и автору

WITH book_duplicates AS (
    -- группируем книги по названию и автору, считаем количество записей
    SELECT 
        b.title,
        a.author,
        COUNT(*) AS duplicate_count,
        ARRAY_AGG(b.book_id) AS book_ids,
        ARRAY_AGG(b.num_pages) AS pages_variants,
        ARRAY_AGG(b.publication_date) AS publication_dates,
        ARRAY_AGG(p.publisher) AS publishers
    FROM books b
    JOIN authors a ON b.author_id = a.author_id
    JOIN publishers p ON b.publisher_id = p.publisher_id
    GROUP BY b.title, a.author
    HAVING COUNT(*) > 1  -- только книги, которые встречаются более одного раза
)
SELECT 
    title,
    author,
    duplicate_count,
    book_ids,
    pages_variants,
    publication_dates,
    publishers
FROM book_duplicates
ORDER BY duplicate_count DESC, title;

-- 2.2. Распределение ассортимента книг по году издания

SELECT 
        EXTRACT(YEAR FROM publication_date::date)::INTEGER AS year, 
        COUNT(*) AS count_books,                                                    -- в абсолютных значениях
        ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM books), 2) AS pct_of_total   -- в относительных значениях с округлением до двух знаков после запятой
FROM books
GROUP BY year
ORDER BY year DESC;

-- 2.3. *Сколько книг вышло после 1 января 2000 года

SELECT
    COUNT(book_id) AS cnt_book_after_01_01_2000,  -- в абсолютных значениях
    ROUND(100.0 * COUNT(book_id) / NULLIF((SELECT COUNT(*) FROM books), 0), 2) AS pct_book_after_01_01_2000 -- в относительных значениях с округлением до двух знаков после запятой
FROM books
WHERE publication_date::date >= '2000-01-01';

-- 2.4. Букинистика и раритетные издания (1952-2001 гг.)

SELECT 
    a.author AS author_name,
    b.title AS book_title,
    EXTRACT(YEAR FROM b.publication_date)::INT AS publication_year,
    b.num_pages,
    p.publisher AS publisher_name
FROM books b
JOIN authors a ON b.author_id = a.author_id
LEFT JOIN publishers p ON b.publisher_id = p.publisher_id
WHERE b.publication_date IS NOT NULL
  AND EXTRACT(YEAR FROM b.publication_date) BETWEEN 1952 AND 2001
ORDER BY publication_year DESC
LIMIT 50;

-- 2.5. Ядро контента (2002-2006 гг.)

SELECT 
    a.author AS author_name,
    b.title AS book_title,
    EXTRACT(YEAR FROM b.publication_date)::INT AS publication_year,
    b.num_pages,
    p.publisher AS publisher_name
FROM books b
JOIN authors a ON b.author_id = a.author_id
LEFT JOIN publishers p ON b.publisher_id = p.publisher_id
WHERE b.publication_date IS NOT NULL
  AND EXTRACT(YEAR FROM b.publication_date) BETWEEN 2002 AND 2006
ORDER BY publication_year DESC
LIMIT 50;

-- 2.6. Контент после падения (2007-2020 гг.)

SELECT 
    a.author AS author_name,
    b.title AS book_title,
    EXTRACT(YEAR FROM b.publication_date)::INT AS publication_year,
    b.num_pages,
    p.publisher AS publisher_name
FROM books b
JOIN authors a ON b.author_id = a.author_id
LEFT JOIN publishers p ON b.publisher_id = p.publisher_id
WHERE b.publication_date IS NOT NULL
  AND EXTRACT(YEAR FROM b.publication_date) >= 2007
ORDER BY publication_year DESC
LIMIT 50;

-- 2.7. Пагинация книг

-- распределение книг по количеству страниц, бинаризация - 50 страниц

SELECT 
    FLOOR(num_pages / 50) * 50 AS cnt_pages,
    COUNT(book_id) AS cnt_books,                                     -- в абсолютных значениях
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS pct_books  -- в относительных значениях
FROM books
GROUP BY FLOOR(num_pages / 50)
ORDER BY cnt_pages;

-- серийные издания

SELECT 
    a.author AS author_name,
    b.title AS book_title,
    EXTRACT(YEAR FROM b.publication_date)::INT AS publication_year,
    b.num_pages,
    p.publisher AS publisher_name
FROM books b
JOIN authors a ON b.author_id = a.author_id
LEFT JOIN publishers p ON b.publisher_id = p.publisher_id
WHERE b.publication_date IS NOT NULL
  AND b.title LIKE '%#%'
ORDER BY b.title DESC
LIMIT 25;

-- 2.8. Жанры и переиздания
-- нарезка на жанры (исходя из названий и авторов, которые себя уже зарекомендовали в том или ином жанре)

SELECT 
  b.book_id,
  b.title,
  a.author,
  
  -- === типология жанров (title + author как ключ) ===
  CASE
    -- графические новеллы / комиксы / манга
    WHEN LOWER(b.title) LIKE '%graphic novel%' 
      OR LOWER(b.title) LIKE '%comics%' 
      OR LOWER(b.title) LIKE '%manga%' 
      OR LOWER(b.title) LIKE '%bleach%' 
      OR LOWER(b.title) LIKE '%fullmetal%' 
      OR LOWER(b.title) LIKE '%death note%' 
      OR LOWER(b.title) LIKE '%tsubasa%' 
      OR LOWER(b.title) LIKE '%walking dead%' 
      OR LOWER(b.title) LIKE '%fables%' 
      OR LOWER(b.title) LIKE '%sandman%' 
      OR LOWER(b.title) LIKE '%batman%' 
      OR LOWER(b.title) LIKE '%marvel%' 
      THEN 'Graphic Novel / Comics'
    
    -- детективы / триллеры / мистика
    WHEN LOWER(b.title) LIKE '%murder%' 
      OR LOWER(b.title) LIKE '%detective%' 
      OR LOWER(b.title) LIKE '%mystery%' 
      OR LOWER(b.title) LIKE '%thriller%' 
      OR LOWER(b.title) LIKE '%poirot%' 
      OR LOWER(b.title) LIKE '%marple%' 
      OR LOWER(b.title) LIKE '%alex cross%' 
      OR LOWER(b.title) LIKE '%harry bosch%' 
      OR LOWER(b.title) LIKE '%scarpetta%' 
      OR LOWER(b.title) LIKE '%anita blake%' 
      OR LOWER(b.title) LIKE '%women''s murder club%' 
      OR LOWER(b.title) LIKE '%stephanie plum%' 
      -- авторские ключи для детективов
      OR LOWER(a.author) LIKE '%christie%' 
      OR LOWER(a.author) LIKE '%conan doyle%' 
      OR LOWER(a.author) LIKE '%patterson%' 
      OR LOWER(a.author) LIKE '%cornwell%' 
      OR LOWER(a.author) LIKE '%graham%' 
      OR LOWER(a.author) LIKE '%perry%' 
      THEN 'Detective / Thriller / Mystery'
    
    -- фэнтези / вампиры / паранормальное
    WHEN LOWER(b.title) LIKE '%vampire%' 
      OR LOWER(b.title) LIKE '%werewolf%' 
      OR LOWER(b.title) LIKE '%fantasy%' 
      OR LOWER(b.title) LIKE '%magic%' 
      OR LOWER(b.title) LIKE '%dragon%' 
      OR LOWER(b.title) LIKE '%witch%' 
      OR LOWER(b.title) LIKE '%black dagger%' 
      OR LOWER(b.title) LIKE '%hollows%' 
      OR LOWER(b.title) LIKE '%wheel of time%' 
      OR LOWER(b.title) LIKE '%game of thrones%' 
      OR LOWER(b.title) LIKE '%discworld%' 
      OR LOWER(b.title) LIKE '%percy jackson%' 
      OR LOWER(b.title) LIKE '%twilight%' 
      -- авторские ключи для фэнтези
      OR LOWER(a.author) LIKE '%tolkien%' 
      OR LOWER(a.author) LIKE '%martin%' 
      OR LOWER(a.author) LIKE '%jordan%' 
      OR LOWER(a.author) LIKE '%pratchett%' 
      OR LOWER(a.author) LIKE '%gaiman%' 
      OR LOWER(a.author) LIKE '%roth%' 
      OR LOWER(a.author) LIKE '%maas%' 
      OR LOWER(a.author) LIKE '%ward%' 
      THEN 'Fantasy / Paranormal / Vampire Romance'
    
    -- научная фантастика
    WHEN LOWER(b.title) LIKE '%science fiction%' 
      OR LOWER(b.title) LIKE '%sci-fi%' 
      OR LOWER(b.title) LIKE '%space%' 
      OR LOWER(b.title) LIKE '%cyberpunk%' 
      OR LOWER(b.title) LIKE '%robot%' 
      OR LOWER(b.title) LIKE '%foundation%' 
      OR LOWER(b.title) LIKE '%dune%' 
      OR LOWER(b.title) LIKE '%hyperion%' 
      OR LOWER(b.title) LIKE '%ender%' 
      OR LOWER(b.title) LIKE '%snow crash%' 
      -- авторские ключи для научной фантастики
      OR LOWER(a.author) LIKE '%asimov%' 
      OR LOWER(a.author) LIKE '%herbert%' 
      OR LOWER(a.author) LIKE '%simmons%' 
      OR LOWER(a.author) LIKE '%gibson%' 
      OR LOWER(a.author) LIKE '%stephenson%' 
      THEN 'Science Fiction'
    
    -- классика / переиздания
    WHEN LOWER(b.title) LIKE '%classics%' 
      OR LOWER(b.title) LIKE '%collected works%' 
      OR LOWER(b.title) LIKE '%anthology%' 
      OR LOWER(b.title) LIKE '%omnibus%' 
      OR LOWER(b.title) LIKE '%reprint%' 
      OR LOWER(b.title) LIKE '%complete works%' 
      OR LOWER(b.title) LIKE '%complete tales%' 
      OR LOWER(b.title) LIKE '%complete stories%' 
      OR LOWER(b.title) LIKE '%shakespeare%' 
      OR LOWER(b.title) LIKE '%austen%' 
      OR LOWER(b.title) LIKE '%dickens%' 
      OR LOWER(b.title) LIKE '%orwell%' 
      -- авторские ключи для классики
      OR LOWER(a.author) LIKE '%shakespeare%' 
      OR LOWER(a.author) LIKE '%austen%' 
      OR LOWER(a.author) LIKE '%dickens%' 
      OR LOWER(a.author) LIKE '%tolstoy%' 
      OR LOWER(a.author) LIKE '%dostoevsky%' 
      OR LOWER(a.author) LIKE '%bronte%' 
      OR LOWER(a.author) LIKE '%orwell%' 
      OR LOWER(a.author) LIKE '%hemingway%' 
      OR LOWER(a.author) LIKE '%twain%' 
      THEN 'Classics / Reprints / Anthology'
    
    -- искусство / дизайн / справочники
    WHEN LOWER(b.title) LIKE '%art%' 
      OR LOWER(b.title) LIKE '%design%' 
      OR LOWER(b.title) LIKE '%illustrated%' 
      OR LOWER(b.title) LIKE '%palette%' 
      OR LOWER(b.title) LIKE '%color%' 
      OR LOWER(b.title) LIKE '%colour%' 
      OR LOWER(b.title) LIKE '%history of art%' 
      OR LOWER(b.title) LIKE '%guide to%' 
      THEN 'Art / Design / Reference'
    
    -- детская литература / young adult
    WHEN LOWER(b.title) LIKE '%children%' 
      OR LOWER(b.title) LIKE '%kids%' 
      OR LOWER(b.title) LIKE '%teen%' 
      OR LOWER(b.title) LIKE '%young adult%' 
      OR LOWER(b.title) LIKE '%picture book%' 
      OR LOWER(b.title) LIKE '%golden book%' 
      OR LOWER(b.title) LIKE '%dr. seuss%' 
      OR LOWER(b.title) LIKE '%pippi%' 
      OR LOWER(b.title) LIKE '%matilda%' 
      OR LOWER(b.title) LIKE '%charlotte''s web%' 
      OR LOWER(b.title) LIKE '%little house%' 
      OR LOWER(b.title) LIKE '%anne of green%' 
      OR LOWER(b.title) LIKE '%nancy drew%' 
      OR LOWER(b.title) LIKE '%harry potter%' 
      -- авторские ключи для детской литературы
      OR LOWER(a.author) LIKE '%seuss%' 
      OR LOWER(a.author) LIKE '%dahl%' 
      OR LOWER(a.author) LIKE '%rowling%' 
      OR LOWER(a.author) LIKE '%riordan%' 
      OR LOWER(a.author) LIKE '%collins%' 
      OR LOWER(a.author) LIKE '%meyer%' 
      THEN 'Children / Young Adult'
    
    -- романтика / женская проза
    WHEN LOWER(b.title) LIKE '%romance%' 
      OR LOWER(b.title) LIKE '%love story%' 
      OR LOWER(b.title) LIKE '%romantic%' 
      OR LOWER(b.title) LIKE '%wedding%' 
      OR LOWER(b.title) LIKE '%chick lit%' 
      OR LOWER(b.title) LIKE '%shopaholic%' 
      OR LOWER(b.title) LIKE '%something borrowed%' 
      OR LOWER(b.title) LIKE '%sisterhood%' 
      THEN 'Romance / Women''s Fiction'
    
    -- нон-фикшн / мемуары / история
    WHEN LOWER(b.title) LIKE '%memoir%' 
      OR LOWER(b.title) LIKE '%biography%' 
      OR LOWER(b.title) LIKE '%autobiography%' 
      OR LOWER(b.title) LIKE '%history%' 
      OR LOWER(b.title) LIKE '%true story%' 
      OR LOWER(b.title) LIKE '%non-fiction%' 
      OR LOWER(b.title) LIKE '%essay%' 
      OR LOWER(b.title) LIKE '%chronicle%' 
      OR LOWER(b.title) LIKE '%travel%' 
      OR LOWER(b.title) LIKE '%world war%' 
      THEN 'Non-Fiction / Memoir / History'
    
    -- самопомощь / бизнес / психология
    WHEN LOWER(b.title) LIKE '%self-help%' 
      OR LOWER(b.title) LIKE '%productivity%' 
      OR LOWER(b.title) LIKE '%habits%' 
      OR LOWER(b.title) LIKE '%success%' 
      OR LOWER(b.title) LIKE '%wealth%' 
      OR LOWER(b.title) LIKE '%business%' 
      OR LOWER(b.title) LIKE '%leadership%' 
      OR LOWER(b.title) LIKE '%psychology%' 
      OR LOWER(b.title) LIKE '%emotional intelligence%' 
      OR LOWER(b.title) LIKE '%how to%' 
      OR LOWER(b.title) LIKE '%7 habits%' 
      OR LOWER(b.title) LIKE '%getting things done%' 
      THEN 'Self-Help / Business / Psychology'
    
    -- кулинария / лайфстайл
    WHEN LOWER(b.title) LIKE '%cookbook%' 
      OR LOWER(b.title) LIKE '%recipe%' 
      OR LOWER(b.title) LIKE '%cooking%' 
      OR LOWER(b.title) LIKE '%food%' 
      OR LOWER(b.title) LIKE '%kitchen%' 
      OR LOWER(b.title) LIKE '%chef%' 
      OR LOWER(b.title) LIKE '%baking%' 
      OR LOWER(b.title) LIKE '%eat pray love%' 
      THEN 'Cooking / Lifestyle'
    
    -- историческая проза / приключения
    WHEN LOWER(b.title) LIKE '%historical fiction%' 
      OR LOWER(b.title) LIKE '%adventure%' 
      OR LOWER(b.title) LIKE '%pirate%' 
      OR LOWER(b.title) LIKE '%voyage%' 
      OR LOWER(b.title) LIKE '%saga%' 
      OR LOWER(b.title) LIKE '%epic%' 
      OR LOWER(b.title) LIKE '%kingdom%' 
      OR LOWER(b.title) LIKE '%throne%' 
      OR LOWER(b.title) LIKE '%crown%' 
      OR LOWER(b.title) LIKE '%sword%' 
      THEN 'Historical Fiction / Adventure'
    
    -- литературная проза / драма
    WHEN LOWER(b.title) LIKE '%literary fiction%' 
      OR LOWER(b.title) LIKE '%drama%' 
      OR LOWER(b.title) LIKE '%tragedy%' 
      OR LOWER(b.title) LIKE '%comedy%' 
      OR LOWER(b.title) LIKE '%play%' 
      OR LOWER(b.title) LIKE '%theatre%' 
      THEN 'Literary Fiction / Drama'
    
    -- не определено
    ELSE 'Unclassified / General Fiction'
  END AS inferred_genre,

  -- === дополнительные метки ===
  CASE 
    WHEN LOWER(b.title) LIKE '%#%' 
      OR LOWER(b.title) LIKE '%book %' 
      OR LOWER(b.title) LIKE '%vol.%' 
      OR LOWER(b.title) LIKE '%part %' 
      THEN true 
    ELSE false 
  END AS is_series,
  
  CASE 
    WHEN LOWER(b.title) LIKE '%reprint%' 
      OR LOWER(b.title) LIKE '%edition%' 
      OR LOWER(b.title) LIKE '%anniversary%' 
      OR LOWER(b.title) LIKE '%collector%' 
      THEN true 
    ELSE false 
  END AS is_reprint,
  
  CASE 
    WHEN LOWER(b.title) LIKE '%illustrated%' 
      OR LOWER(b.title) LIKE '%graphic%' 
      OR LOWER(b.title) LIKE '%visual%' 
      OR LOWER(b.title) LIKE '%art book%' 
      THEN true 
    ELSE false 
  END AS is_illustrated,
  
  CASE 
    WHEN b.num_pages < 200 THEN 'лёгкое чтение'
    WHEN b.num_pages BETWEEN 200 AND 400 THEN 'золотой стандарт'
    ELSE 'фундаментальный труд' 
  END AS volume_category

FROM books b
LEFT JOIN authors a ON b.author_id = a.author_id
ORDER BY b.title
LIMIT 50;

-- 2.9. Профилирование книжных сегментов

-- создадим сводную таблицу, которая позволит сравнить три эпохи каталога по всем ключевым бизнес-параметрам: 
-- кто издавал, какой был объём, насколько активно читатели оценивали и рецензировали книги, и какая доля контента была «сериальной» (удерживающей)

WITH categorized AS (
  SELECT 
    b.book_id,
    b.author_id,
    b.title,
    b.num_pages,
    b.publication_date,
    b.publisher_id,
    EXTRACT(YEAR FROM b.publication_date) AS pub_year,
    CASE 
      WHEN EXTRACT(YEAR FROM b.publication_date) BETWEEN 1952 AND 2001 THEN 'Букинистика и раритетные издания (1952-2001)'
      WHEN EXTRACT(YEAR FROM b.publication_date) BETWEEN 2002 AND 2006 THEN 'Ядро контента (2002-2006)'
      WHEN EXTRACT(YEAR FROM b.publication_date) BETWEEN 2007 AND 2020 THEN 'Контент после падения (2007-2020)'
      ELSE 'Вне рубрикатора'
    END AS segment
  FROM books b
  WHERE b.publication_date IS NOT NULL
),
-- агрегируем рейтинги и отзывы заранее
book_stats AS (
  SELECT 
    b.book_id,
    COUNT(DISTINCT r.rating_id) AS rating_cnt,
    AVG(r.rating) AS avg_rating,
    COUNT(DISTINCT rv.review_id) AS review_cnt,
    AVG(LENGTH(rv.text)) AS avg_review_len
  FROM books b
  LEFT JOIN ratings r ON b.book_id = r.book_id
  LEFT JOIN reviews rv ON b.book_id = rv.book_id
  GROUP BY b.book_id
),
enriched AS (
  SELECT 
    c.segment,
    c.book_id,
    c.author_id,
    c.publisher_id,
    c.num_pages,
    c.title,
    c.pub_year,
    COALESCE(bs.rating_cnt, 0) AS rating_cnt,
    bs.avg_rating,
    COALESCE(bs.review_cnt, 0) AS review_cnt,
    bs.avg_review_len,
    -- классификация по объёму
    CASE 
      WHEN c.num_pages IS NULL THEN 'unknown'
      WHEN c.num_pages < 200 THEN 'light_reading'
      WHEN c.num_pages BETWEEN 200 AND 400 THEN 'gold_standard'
      WHEN c.num_pages > 400 THEN 'fundamental_work'
      ELSE 'unknown'
    END AS volume_category,
    -- ключи, обозначающие серийное издание
    CASE 
      WHEN LOWER(c.title) LIKE '%#%' 
        OR LOWER(c.title) LIKE '%book %' 
        OR LOWER(c.title) LIKE '%vol.%' 
        OR LOWER(c.title) LIKE '%part %' 
        THEN true 
      ELSE false 
    END AS is_series
  FROM categorized c
  LEFT JOIN book_stats bs ON c.book_id = bs.book_id
)
SELECT 
  segment,
  -- базовые метрики
  COUNT(*) AS total_books,
  COUNT(DISTINCT author_id) AS unique_authors,
  COUNT(DISTINCT publisher_id) AS unique_publishers,
  
  -- объёмные характеристики
  MIN(num_pages) AS min_pages,
  ROUND(AVG(num_pages), 1) AS avg_pages,
  MAX(num_pages) AS max_pages,
  
  -- распределение по категориям объёма
  SUM(CASE WHEN volume_category = 'light_reading' THEN 1 ELSE 0 END) AS cnt_light_reading,
  SUM(CASE WHEN volume_category = 'gold_standard' THEN 1 ELSE 0 END) AS cnt_gold_standard,
  SUM(CASE WHEN volume_category = 'fundamental_work' THEN 1 ELSE 0 END) AS cnt_fundamental_work,
  
  -- рейтинги
  ROUND(AVG(CASE WHEN rating_cnt > 0 THEN avg_rating END), 2) AS avg_rating,
  ROUND(AVG(rating_cnt), 2) AS avg_ratings_per_book,
  ROUND(100.0 * COUNT(CASE WHEN rating_cnt > 0 THEN 1 END) / NULLIF(COUNT(*), 0), 2) AS pct_rated,
  
  -- обзоры
  ROUND(AVG(CASE WHEN review_cnt > 0 THEN avg_review_len END), 1) AS avg_review_len,
  ROUND(AVG(review_cnt), 2) AS avg_review_per_book,
  ROUND(100.0 * COUNT(CASE WHEN review_cnt > 0 THEN 1 END) / NULLIF(COUNT(*), 0), 2) AS pct_reviewed,
  
  -- серийные издания
  SUM(CASE WHEN is_series = true THEN 1 ELSE 0 END) AS cnt_series,
  ROUND(100.0 * SUM(CASE WHEN is_series = true THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0), 2) AS pct_series

FROM enriched
GROUP BY segment
ORDER BY MIN(pub_year);

-- 2.10. Есть ли связь между объёмом книги (страницы) и средним рейтингом?
-- Исследовательская гипотеза: читатели выше ценят лаконичность или, наоборот, фундаментальность.
-- распределение книг по количеству страниц, шаг бинаризации страниц: 50, + средняя оценка книг в каждом интервале

SELECT 
    FLOOR(b.num_pages / 50) * 50 AS cnt_pages,
    COUNT(DISTINCT b.book_id) AS cnt_books,                                      -- в абсолютных значениях
    ROUND(COUNT(DISTINCT b.book_id) * 100.0 / (SELECT COUNT(*) FROM books), 2) AS pct_books,  -- в относительных значениях
    ROUND(AVG(r.rating), 2) AS avg_rating                                       -- средняя оценка книг этого объема
FROM books b
LEFT JOIN ratings r ON b.book_id = r.book_id
GROUP BY FLOOR(b.num_pages / 50)
ORDER BY cnt_pages;

-- 2.11. Какие книги имеют наибольший разброс оценок (высокая дисперсия)? Что их объединяет?
-- Выявление поляризующего контента — триггеры дискуссий.

-- средняя оценка и среднее число отзывов по сегментам
WITH rating_agg AS (
    -- Предварительно считаем среднюю оценку ПО КАЖДОЙ книге
    SELECT book_id, AVG(rating) AS avg_rating
    FROM ratings
    GROUP BY book_id
),
review_agg AS (
    -- Предварительно считаем количество отзывов ПО КАЖДОЙ книге
    SELECT book_id, COUNT(*) AS review_count
    FROM reviews
    GROUP BY book_id
),
books_segmented AS (
    SELECT 
        book_id,
        CASE 
            WHEN num_pages < 200 THEN 1
            WHEN num_pages BETWEEN 200 AND 400 THEN 2
            ELSE 3
        END AS sort_order,
        CASE 
            WHEN num_pages < 200 THEN 'до 200 стр.'
            WHEN num_pages BETWEEN 200 AND 400 THEN '200–400 стр.'
            ELSE '400+ стр.'
        END AS page_segment
    FROM books
)
SELECT 
    bs.page_segment,
    ROUND(AVG(ra.avg_rating)::numeric, 2) AS avg_rating_per_book,
    ROUND(AVG(COALESCE(rv.review_count, 0))::numeric, 2) AS avg_reviews_per_book,
    COUNT(bs.book_id) AS total_books
FROM books_segmented bs
LEFT JOIN rating_agg ra ON bs.book_id = ra.book_id
LEFT JOIN review_agg rv ON bs.book_id = rv.book_id
GROUP BY bs.sort_order, bs.page_segment
ORDER BY bs.sort_order;

-- 2.12. Сегментация книг: хиты, недооценённые, переоценённые, аутсайдеры
-- матрица «популярность × качество»

WITH book_stats AS (
    -- базовые метрики по каждой книге
    SELECT 
        b.book_id,
        b.title,
        a.author AS author_name,
        COUNT(r.rating_id) AS ratings_count,
        ROUND(AVG(r.rating)::numeric, 2) AS avg_rating
    FROM books b
    JOIN authors a ON b.author_id = a.author_id
    LEFT JOIN ratings r ON b.book_id = r.book_id
    GROUP BY b.book_id, b.title, a.author
    HAVING COUNT(r.rating_id) >= 10  -- минимум 10 оценок для статзначимости
),
thresholds AS (
    -- расчёт медианных порогов (естественная точка разделения)
    SELECT 
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY ratings_count) AS median_ratings,
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY avg_rating) AS median_rating
    FROM book_stats
),
segmented AS (
    -- классификация по матрице "популярность × качество"
    SELECT 
        bs.*,
        CASE 
            WHEN bs.ratings_count >= t.median_ratings AND bs.avg_rating >= t.median_rating 
                THEN 'Хиты'
            WHEN bs.ratings_count < t.median_ratings AND bs.avg_rating >= t.median_rating 
                THEN 'Недооценённые'
            WHEN bs.ratings_count >= t.median_ratings AND bs.avg_rating < t.median_rating 
                THEN 'Переоценённые'
            ELSE 'Аутсайдеры'
        END AS segment
    FROM book_stats bs
    CROSS JOIN thresholds t
),
segment_summary AS (
    -- агрегация по сегментам + топ-3 книги в каждом
    SELECT 
        segment,
        COUNT(*) AS books_count,
        ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS segment_share_pct,
        ROUND(AVG(ratings_count)::numeric, 1) AS avg_ratings_per_book,
        ROUND(AVG(avg_rating)::numeric, 2) AS avg_segment_rating,
        ROUND(MIN(avg_rating)::numeric, 2) AS min_rating,
        ROUND(MAX(avg_rating)::numeric, 2) AS max_rating,
        ROUND(MIN(ratings_count)::numeric, 0) AS min_ratings,
        ROUND(MAX(ratings_count)::numeric, 0) AS max_ratings
    FROM segmented
    GROUP BY segment
)

-- финальный вывод: сводка по сегментам
SELECT * FROM segment_summary
ORDER BY 
    CASE segment
        WHEN 'Хиты' THEN 1
        WHEN 'Недооценённые' THEN 2
        WHEN 'Переоценённые' THEN 3
        WHEN 'Аутсайдеры' THEN 4
    END;

-- примеры книг в каждом сегменте

WITH book_stats AS (
    SELECT 
        b.book_id,
        b.title,
        a.author AS author_name,
        COUNT(r.rating_id) AS ratings_count,
        ROUND(AVG(r.rating)::numeric, 2) AS avg_rating
    FROM books b
    JOIN authors a ON b.author_id = a.author_id
    LEFT JOIN ratings r ON b.book_id = r.book_id
    GROUP BY b.book_id, b.title, a.author
    HAVING COUNT(r.rating_id) >= 10
),
thresholds AS (
    SELECT 
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY ratings_count) AS median_ratings,
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY avg_rating) AS median_rating
    FROM book_stats
),
segmented AS (
    SELECT 
        bs.*,
        CASE 
            WHEN bs.ratings_count >= t.median_ratings AND bs.avg_rating >= t.median_rating 
                THEN 'Хиты'
            WHEN bs.ratings_count < t.median_ratings AND bs.avg_rating >= t.median_rating 
                THEN 'Недооценённые'
            WHEN bs.ratings_count >= t.median_ratings AND bs.avg_rating < t.median_rating 
                THEN 'Переоценённые'
            ELSE 'Аутсайдеры'
        END AS segment
    FROM book_stats bs
    CROSS JOIN thresholds t
),
ranked AS (
    SELECT 
        segment,
        title,
        author_name,
        ratings_count,
        avg_rating,
        ROW_NUMBER() OVER (PARTITION BY segment ORDER BY ratings_count DESC, avg_rating DESC) AS rn
    FROM segmented
)
SELECT 
    segment AS "Сегмент",
    title AS "Книга",
    author_name AS "Автор",
    ratings_count AS "Кол-во оценок",
    avg_rating AS "Средний рейтинг"
FROM ranked
WHERE rn <= 3
ORDER BY 
    CASE segment
        WHEN 'Хиты' THEN 1
        WHEN 'Недооценённые' THEN 2
        WHEN 'Переоценённые' THEN 3
        WHEN 'Аутсайдеры' THEN 4
    END,
    rn;

-- ============================================================================
-- ШАГ 3. АВТОРЫ
-- ============================================================================

-- 3.1. Список авторов

SELECT 
    author_id,
    author AS author_name
FROM authors
ORDER BY author_name;

-- 3.2. *Автор с самой высокой средней оценкой книг
-- Поскольку в приложении присутствуют и брошюры, нам необходимо исключить их из исследования, и учесть только книги с 50 и более оценками.
-- топ-10 авторов с наивысшим средним рейтингом с нормализацией склеенных имён (берём только основного автора до первого '/')

WITH popular_books AS (
    -- отбираем книги с >= 50 оценками
    SELECT book_id
    FROM ratings
    GROUP BY book_id
    HAVING COUNT(*) >= 50
),
normalized_authors AS (
    -- нормализуем имена авторов (берём только основного до первого '/')
    SELECT 
        a.author_id,
        TRIM(SPLIT_PART(a.author, '/', 1)) AS primary_author
    FROM authors a
),
author_stats AS (
    -- считаем статистику по нормализованным авторам
    SELECT 
        na.primary_author AS author_name,
        COUNT(DISTINCT b.book_id) AS books_count,
        COUNT(r.rating_id) AS total_ratings,
        ROUND(AVG(r.rating)::numeric, 2) AS avg_rating,
        ROUND(MIN(r.rating)::numeric, 2) AS min_rating,
        ROUND(MAX(r.rating)::numeric, 2) AS max_rating
    FROM normalized_authors na
    JOIN books b ON na.author_id = b.author_id
    JOIN ratings r ON b.book_id = r.book_id
    WHERE b.book_id IN (SELECT book_id FROM popular_books)
      AND b.num_pages >= 50  -- исключаем брошюры
    GROUP BY na.primary_author
)
SELECT 
    author_name,
    books_count,
    total_ratings,
    avg_rating,
    min_rating,
    max_rating
FROM author_stats
ORDER BY avg_rating DESC, total_ratings DESC
LIMIT 10;

-- 3.3. Сезонность в публикации авторов (по месяцам)
-- Оптимизация маркетинговых кампаний и релизных стратегий.
-- сезонность публикаций для топ-20 авторов по количеству книг

WITH top_authors AS (
    -- определяем топ-20 авторов по количеству книг в каталоге
    SELECT 
        a.author_id,
        TRIM(SPLIT_PART(a.author, '/', 1)) AS primary_author,
        COUNT(b.book_id) AS total_books
    FROM authors a
    JOIN books b ON a.author_id = b.author_id
    GROUP BY a.author_id, a.author
    ORDER BY total_books DESC
    LIMIT 20
),
author_monthly_stats AS (
    -- считаем публикации по месяцам для каждого топ-автора
    SELECT 
        ta.primary_author,
        ta.total_books,
        EXTRACT(MONTH FROM b.publication_date) AS month_num,
        TO_CHAR(b.publication_date, 'Month') AS month_name,
        COUNT(b.book_id) AS books_in_month
    FROM top_authors ta
    JOIN books b ON ta.author_id = b.author_id
    WHERE b.publication_date IS NOT NULL
    GROUP BY 
        ta.primary_author,
        ta.total_books,
        EXTRACT(MONTH FROM b.publication_date),
        TO_CHAR(b.publication_date, 'Month')
)
SELECT 
    primary_author,
    total_books,
    month_num,
    month_name,
    books_in_month,
    ROUND(100.0 * books_in_month / total_books, 2) AS pct_in_month
FROM author_monthly_stats
ORDER BY primary_author, month_num;

-- 3.4. Авторы и поляризация контента
-- матрица поляризации контента

-- агрегированные метрики по категориям поляризации
WITH book_stats AS (
    SELECT 
        b.book_id,
        b.author_id,
        AVG(r.rating) AS avg_book_rating,
        STDDEV(r.rating) AS rating_stddev,
        COUNT(r.rating_id) AS ratings_count,
        COUNT(DISTINCT rv.review_id) AS reviews_count
    FROM books b
    LEFT JOIN ratings r ON b.book_id = r.book_id
    LEFT JOIN reviews rv ON b.book_id = rv.review_id
    WHERE b.num_pages >= 50
    GROUP BY b.book_id, b.author_id
    HAVING COUNT(r.rating_id) >= 10  -- минимум 10 оценок на книгу для значимости
),
book_categories AS (
    SELECT 
        book_id,
        avg_book_rating,
        rating_stddev,
        ratings_count,
        reviews_count,
        -- Категоризация каждой книги
        CASE 
            WHEN avg_book_rating >= 4.0 AND rating_stddev < 0.7 THEN 'Любимец публики'
            WHEN avg_book_rating >= 4.0 AND rating_stddev >= 0.7 THEN 'Нравится с оговорками'
            WHEN avg_book_rating < 3.5 AND rating_stddev < 0.7 THEN 'Всем не нравится'
            WHEN avg_book_rating < 3.5 AND rating_stddev >= 0.7 THEN 'Провокационный контент'
            ELSE 'Нейтральная книга'
        END AS book_category,
        -- приоритет категории для сортировки
        CASE 
            WHEN avg_book_rating < 3.5 AND rating_stddev >= 0.7 THEN 1
            WHEN avg_book_rating >= 4.0 AND rating_stddev >= 0.7 THEN 2
            WHEN avg_book_rating < 3.5 AND rating_stddev < 0.7 THEN 3
            WHEN avg_book_rating >= 4.0 AND rating_stddev < 0.7 THEN 4
            ELSE 5
        END AS category_priority
    FROM book_stats
)
SELECT 
    book_category,
    COUNT(DISTINCT book_id) AS books_count,
    ROUND(AVG(avg_book_rating)::numeric, 2) AS avg_rating,
    ROUND(AVG(rating_stddev)::numeric, 2) AS avg_stddev,
    ROUND(AVG(reviews_count)::numeric, 2) AS avg_reviews,
    ROUND(AVG(ratings_count)::numeric, 2) AS avg_ratings,
    -- дополнительные метрики для понимания масштаба
    SUM(ratings_count) AS total_ratings,
    SUM(reviews_count) AS total_reviews
FROM book_categories
GROUP BY book_category, category_priority
ORDER BY category_priority;

-- топ-10 провокационный контент (низкий рейтинг + максимальный разброс мнений)

WITH book_stats AS (
    SELECT 
        b.book_id,
        b.title,
        b.num_pages,
        b.author_id,
        AVG(r.rating) AS avg_book_rating,
        STDDEV(r.rating) AS rating_stddev,
        COUNT(r.rating_id) AS ratings_count,
        COUNT(DISTINCT rv.review_id) AS reviews_count,
        MIN(r.rating) AS min_rating,
        MAX(r.rating) AS max_rating
    FROM books b
    LEFT JOIN ratings r ON b.book_id = r.book_id
    LEFT JOIN reviews rv ON b.book_id = rv.review_id
    WHERE b.num_pages >= 50
    GROUP BY b.book_id, b.title, b.num_pages, b.author_id
    HAVING COUNT(r.rating_id) >= 10
)
SELECT 
    TRIM(SPLIT_PART(a.author, '/', 1)) AS primary_author,
    bs.title,
    bs.num_pages,
    ROUND(bs.avg_book_rating::numeric, 2) AS avg_rating,
    ROUND(bs.rating_stddev::numeric, 2) AS stddev,
    bs.ratings_count,
    bs.reviews_count,
    bs.min_rating,
    bs.max_rating
FROM book_stats bs
JOIN authors a ON bs.author_id = a.author_id
WHERE bs.avg_book_rating < 3.5 
  AND bs.rating_stddev >= 0.7
ORDER BY bs.rating_stddev DESC, bs.ratings_count DESC
LIMIT 10;

-- топ-10 нравится с оговорками (высокий рейтинг + высокий разброс)

WITH book_stats AS (
    SELECT 
        b.book_id,
        b.title,
        b.num_pages,
        b.author_id,
        AVG(r.rating) AS avg_book_rating,
        STDDEV(r.rating) AS rating_stddev,
        COUNT(r.rating_id) AS ratings_count,
        COUNT(DISTINCT rv.review_id) AS reviews_count,
        MIN(r.rating) AS min_rating,
        MAX(r.rating) AS max_rating
    FROM books b
    LEFT JOIN ratings r ON b.book_id = r.book_id
    LEFT JOIN reviews rv ON b.book_id = rv.review_id
    WHERE b.num_pages >= 50
    GROUP BY b.book_id, b.title, b.num_pages, b.author_id
    HAVING COUNT(r.rating_id) >= 10
)
SELECT 
    TRIM(SPLIT_PART(a.author, '/', 1)) AS primary_author,
    bs.title,
    bs.num_pages,
    ROUND(bs.avg_book_rating::numeric, 2) AS avg_rating,
    ROUND(bs.rating_stddev::numeric, 2) AS stddev,
    bs.ratings_count,
    bs.reviews_count,
    bs.min_rating,
    bs.max_rating
FROM book_stats bs
JOIN authors a ON bs.author_id = a.author_id
WHERE bs.avg_book_rating >= 4.0 
  AND bs.rating_stddev >= 0.7
ORDER BY bs.rating_stddev DESC, bs.ratings_count DESC
LIMIT 10;

-- топ-10 всем не нравится (низкий рейтинг + низкий разброс)

WITH book_stats AS (
    SELECT 
        b.book_id,
        b.title,
        b.num_pages,
        b.author_id,
        AVG(r.rating) AS avg_book_rating,
        STDDEV(r.rating) AS rating_stddev,
        COUNT(r.rating_id) AS ratings_count,
        COUNT(DISTINCT rv.review_id) AS reviews_count,
        MIN(r.rating) AS min_rating,
        MAX(r.rating) AS max_rating
    FROM books b
    LEFT JOIN ratings r ON b.book_id = r.book_id
    LEFT JOIN reviews rv ON b.book_id = rv.review_id
    WHERE b.num_pages >= 50
    GROUP BY b.book_id, b.title, b.num_pages, b.author_id
    HAVING COUNT(r.rating_id) >= 10
)
SELECT 
    TRIM(SPLIT_PART(a.author, '/', 1)) AS primary_author,
    bs.title,
    bs.num_pages,
    ROUND(bs.avg_book_rating::numeric, 2) AS avg_rating,
    ROUND(bs.rating_stddev::numeric, 2) AS stddev,
    bs.ratings_count,
    bs.reviews_count,
    bs.min_rating,
    bs.max_rating
FROM book_stats bs
JOIN authors a ON bs.author_id = a.author_id
WHERE bs.avg_book_rating < 3.5 
  AND bs.rating_stddev < 0.7
ORDER BY bs.avg_book_rating ASC, bs.ratings_count DESC
LIMIT 10;

-- топ-10 любимец публики (высокий рейтинг + низкий разброс)

WITH book_stats AS (
    SELECT 
        b.book_id,
        b.title,
        b.num_pages,
        b.author_id,
        AVG(r.rating) AS avg_book_rating,
        STDDEV(r.rating) AS rating_stddev,
        COUNT(r.rating_id) AS ratings_count,
        COUNT(DISTINCT rv.review_id) AS reviews_count,
        MIN(r.rating) AS min_rating,
        MAX(r.rating) AS max_rating
    FROM books b
    LEFT JOIN ratings r ON b.book_id = r.book_id
    LEFT JOIN reviews rv ON b.book_id = rv.review_id
    WHERE b.num_pages >= 50
    GROUP BY b.book_id, b.title, b.num_pages, b.author_id
    HAVING COUNT(r.rating_id) >= 10
)
SELECT 
    TRIM(SPLIT_PART(a.author, '/', 1)) AS primary_author,
    bs.title,
    bs.num_pages,
    ROUND(bs.avg_book_rating::numeric, 2) AS avg_rating,
    ROUND(bs.rating_stddev::numeric, 2) AS stddev,
    bs.ratings_count,
    bs.reviews_count,
    bs.min_rating,
    bs.max_rating
FROM book_stats bs
JOIN authors a ON bs.author_id = a.author_id
WHERE bs.avg_book_rating >= 4.0 
  AND bs.rating_stddev < 0.7
ORDER BY bs.avg_book_rating DESC, bs.ratings_count DESC
LIMIT 10;

-- топ-10 нейтральных книг (умеренные оценки + средний разброс мнений)

WITH book_stats AS (
    SELECT 
        b.book_id,
        b.title,
        b.num_pages,
        b.author_id,
        AVG(r.rating) AS avg_book_rating,
        STDDEV(r.rating) AS rating_stddev,
        COUNT(r.rating_id) AS ratings_count,
        COUNT(DISTINCT rv.review_id) AS reviews_count,
        MIN(r.rating) AS min_rating,
        MAX(r.rating) AS max_rating
    FROM books b
    LEFT JOIN ratings r ON b.book_id = r.book_id
    LEFT JOIN reviews rv ON b.book_id = rv.review_id
    WHERE b.num_pages >= 50
    GROUP BY b.book_id, b.title, b.num_pages, b.author_id
    HAVING COUNT(r.rating_id) >= 10
)
SELECT 
    TRIM(SPLIT_PART(a.author, '/', 1)) AS primary_author,
    bs.title,
    bs.num_pages,
    ROUND(bs.avg_book_rating::numeric, 2) AS avg_rating,
    ROUND(bs.rating_stddev::numeric, 2) AS stddev,
    bs.ratings_count,
    bs.reviews_count,
    bs.min_rating,
    bs.max_rating
FROM book_stats bs
JOIN authors a ON bs.author_id = a.author_id
WHERE bs.avg_book_rating >= 3.5 
  AND bs.avg_book_rating < 4.0
ORDER BY bs.ratings_count DESC, bs.rating_stddev DESC
LIMIT 10;

-- 3.5. Какие авторы сменили издательства и как это влияет на метрики их книг?
-- Анализ стратегий карьерного роста авторов. формирует следующую таблицу: автор - наименование издательства - год (книги этого автора, которую опубликовало это издательство)
-- Цель запроса - найти авторов, которые издавались: 1) только в одном издательстве - разово 2) только в одном издательстве - постоянно 3) сменили издательство со временем

-- cводная статистика по категориям авторов: колчиество по категориям и какие у них средние метрики
-- общая статистика по категориям авторов
WITH AuthorStats AS (
    SELECT 
        author_id,
        COUNT(book_id) AS total_books,
        COUNT(DISTINCT publisher_id) AS unique_publishers
    FROM books
    WHERE publication_date IS NOT NULL
    GROUP BY author_id
),
AuthorClassification AS (
    SELECT 
        author_id,
        CASE 
            WHEN unique_publishers = 1 AND total_books = 1 THEN 'Разовое издание'
            WHEN unique_publishers = 1 AND total_books > 1 THEN 'Постоянное издание'
            WHEN unique_publishers > 1 THEN 'Смена издательства'
        END AS publishing_category
    FROM AuthorStats
),
AuthorMetrics AS (
    -- считаем метрики для каждого автора
    SELECT 
        ac.author_id,
        ac.publishing_category,
        COUNT(DISTINCT b.book_id) AS books_count,
        COUNT(DISTINCT r.rating_id) AS total_ratings,
        ROUND(AVG(r.rating)::numeric, 2) AS avg_rating,
        ROUND(AVG(b.num_pages)::numeric, 0) AS avg_pages
    FROM AuthorClassification ac
    JOIN books b ON ac.author_id = b.author_id
    LEFT JOIN ratings r ON b.book_id = r.book_id
    GROUP BY ac.author_id, ac.publishing_category
)
SELECT 
    publishing_category,
    COUNT(DISTINCT author_id) AS authors_count,
    SUM(books_count) AS total_books,
    ROUND(AVG(books_count)::numeric, 1) AS avg_books_per_author,
    ROUND(AVG(avg_rating)::numeric, 2) AS avg_rating,
    ROUND(AVG(avg_pages)::numeric, 0) AS avg_pages,
    SUM(total_ratings) AS total_ratings
FROM AuthorMetrics
GROUP BY publishing_category
ORDER BY 
    CASE publishing_category
        WHEN 'Смена издательства' THEN 1
        WHEN 'Постоянное издание' THEN 2
        WHEN 'Разовое издание' THEN 3
    END;

-- рассмотрим авторов, сменивших издательство — это самая интересная категория для анализа карьерного роста
-- топ-20 авторов, менивших издательства, с хронологией их публикаций у каждого издателя

-- детализация по авторам, сменившим издательство
WITH AuthorStats AS (
    SELECT 
        author_id,
        COUNT(book_id) AS total_books,
        COUNT(DISTINCT publisher_id) AS unique_publishers
    FROM books
    WHERE publication_date IS NOT NULL
    GROUP BY author_id
    HAVING COUNT(DISTINCT publisher_id) > 1
),
AuthorPublishers AS (
    SELECT 
        au.author_id,  -- добавляем для корректной группировки
        TRIM(SPLIT_PART(au.author, '/', 1)) AS primary_author,
        pub.publisher,
        MIN(EXTRACT(YEAR FROM b.publication_date))::INT AS first_year,
        MAX(EXTRACT(YEAR FROM b.publication_date))::INT AS last_year,
        COUNT(b.book_id) AS books_with_publisher
    FROM AuthorStats ast
    JOIN books b ON ast.author_id = b.author_id
    JOIN authors au ON b.author_id = au.author_id
    JOIN publishers pub ON b.publisher_id = pub.publisher_id
    GROUP BY au.author_id, au.author, pub.publisher
)
SELECT 
    primary_author AS "Автор",
    COUNT(DISTINCT publisher) AS "Количество издательств",
    SUM(books_with_publisher) AS "Всего книг",
    STRING_AGG(
        publisher || ' (' || books_with_publisher || ' книг, ' || 
        first_year || '-' || last_year || ')', 
        ' | ' 
        ORDER BY first_year
    ) AS "Издательства и периоды"
FROM AuthorPublishers
GROUP BY author_id, primary_author
ORDER BY 
    COUNT(DISTINCT publisher) DESC,
    SUM(books_with_publisher) DESC
LIMIT 20;

-- сравнение метрик автора до и после смены издательства

-- сравнение метрик книг до и после смены издательства
WITH AuthorStats AS (
    SELECT 
        author_id,
        COUNT(DISTINCT publisher_id) AS unique_publishers
    FROM books
    WHERE publication_date IS NOT NULL
    GROUP BY author_id
    HAVING COUNT(DISTINCT publisher_id) > 1
),
FirstBookPerAuthor AS (
    -- находим самую первую книгу каждого автора
    SELECT 
        author_id,
        publisher_id AS first_publisher_id,
        MIN(publication_date) AS first_pub_date
    FROM books
    WHERE author_id IN (SELECT author_id FROM AuthorStats)
      AND publication_date IS NOT NULL
    GROUP BY author_id, publisher_id
),
AuthorFirstPublisher AS (
    -- определяем ПЕРВОЕ издательство для каждого автора (по самой ранней книге)
    SELECT DISTINCT ON (author_id)
        author_id,
        first_publisher_id
    FROM FirstBookPerAuthor
    ORDER BY author_id, first_pub_date ASC
),
BooksWithPeriod AS (
    -- помечаем каждую книгу: первое издательство или последующее
    SELECT 
        b.book_id,
        b.author_id,
        b.publisher_id,
        b.publication_date,
        CASE 
            WHEN b.publisher_id = afp.first_publisher_id THEN 'Первое издательство'
            ELSE 'Последующие издательства'
        END AS publisher_period
    FROM books b
    JOIN AuthorFirstPublisher afp ON b.author_id = afp.author_id
    WHERE b.publication_date IS NOT NULL
),
PublisherPeriodMetrics AS (
    -- считаем метрики для каждого периода
    SELECT 
        b.author_id,
        TRIM(SPLIT_PART(au.author, '/', 1)) AS primary_author,
        bp.publisher_period,
        COUNT(DISTINCT b.book_id) AS books_count,
        ROUND(AVG(r.rating)::numeric, 2) AS avg_rating,
        COUNT(r.rating_id) AS total_ratings,
        ROUND(AVG(b.num_pages)::numeric, 0) AS avg_pages
    FROM BooksWithPeriod bp
    JOIN books b ON bp.book_id = b.book_id
    JOIN authors au ON b.author_id = au.author_id
    LEFT JOIN ratings r ON b.book_id = r.book_id
    GROUP BY b.author_id, au.author, bp.publisher_period
)
SELECT 
    primary_author AS "Автор",
    MAX(CASE WHEN publisher_period = 'Первое издательство' THEN books_count END) AS "Книг у первого издателя",
    MAX(CASE WHEN publisher_period = 'Первое издательство' THEN avg_rating END) AS "Рейтинг у первого",
    MAX(CASE WHEN publisher_period = 'Последующие издательства' THEN books_count END) AS "Книг у последующих",
    MAX(CASE WHEN publisher_period = 'Последующие издательства' THEN avg_rating END) AS "Рейтинг у последующих",
    ROUND(
        MAX(CASE WHEN publisher_period = 'Последующие издательства' THEN avg_rating END) - 
        MAX(CASE WHEN publisher_period = 'Первое издательство' THEN avg_rating END), 
        2
    ) AS "Изменение рейтинга"
FROM PublisherPeriodMetrics
GROUP BY author_id, primary_author
HAVING 
    MAX(CASE WHEN publisher_period = 'Первое издательство' THEN avg_rating END) IS NOT NULL
    AND MAX(CASE WHEN publisher_period = 'Последующие издательства' THEN avg_rating END) IS NOT NULL
ORDER BY "Изменение рейтинга" DESC
LIMIT 20;

-- ============================================================================
-- ШАГ 4. ИЗДАТЕЛЬСТВА
-- ============================================================================

-- 4.1. *Издательство с наибольшим числом книг толще 50 страниц
-- 50 страниц является техническим порогом ограничения для брошюр, а нам необходимо исключить их из данного исследования. Книжные издательства vs издательства технической и справочной литературы.

-- топ-10 самых массовых издательств литературы, представленных в приложении

SELECT
    p.publisher,
    COUNT(b.book_id) AS cnt_publisher,  -- абсолютное значение
    ROUND(COUNT(b.book_id) * 100.0 / (SELECT COUNT(*) FROM books), 2) AS pct_publisher  -- относительное значение
FROM publishers p
INNER JOIN books b ON p.publisher_id = b.publisher_id
WHERE b.num_pages > 50
GROUP BY p.publisher_id, p.publisher
ORDER BY cnt_publisher DESC
LIMIT 10;

-- 4.2. Какое издательство имеет наивысший средний рейтинг выпущенных книг?
-- Оценка репутации и качества редактуры.

-- здательство с наивысшим средним рейтингом выпущенных книг
-- исключаем брошюры (<=50 страниц), учитываем только издательства с >= 3 книгами для статистической значимости

WITH book_avg_ratings AS (
    -- считаем средний рейтинг для каждой книги отдельно, чтобы избежать перемножения строк при JOIN
    SELECT 
        book_id,
        AVG(rating) AS avg_book_rating,
        COUNT(rating_id) AS ratings_count
    FROM ratings
    GROUP BY book_id
),
publisher_stats AS (
    -- агрегируем метрики по издательствам
    SELECT 
        p.publisher_id,
        p.publisher,
        COUNT(DISTINCT b.book_id) AS books_count,
        SUM(bar.ratings_count) AS total_ratings,
        ROUND(AVG(bar.avg_book_rating)::numeric, 2) AS avg_rating,
        ROUND(MIN(bar.avg_book_rating)::numeric, 2) AS min_book_rating,
        ROUND(MAX(bar.avg_book_rating)::numeric, 2) AS max_book_rating,
        ROUND(AVG(b.num_pages)::numeric, 0) AS avg_pages
    FROM publishers p
    JOIN books b ON p.publisher_id = b.publisher_id
    JOIN book_avg_ratings bar ON b.book_id = bar.book_id
    WHERE b.num_pages > 50  -- исключаем брошюры
    GROUP BY p.publisher_id, p.publisher
    HAVING COUNT(DISTINCT b.book_id) >= 3  -- минимум 3 книги у издательства
)
SELECT 
    publisher AS "Издательство",
    books_count AS "Количество книг",
    total_ratings AS "Всего оценок",
    avg_rating AS "Средний рейтинг",
    min_book_rating AS "Мин. рейтинг книги",
    max_book_rating AS "Макс. рейтинг книги",
    avg_pages AS "Средний объём (стр.)"
FROM publisher_stats
ORDER BY avg_rating DESC, total_ratings DESC
LIMIT 10;

-- 4.3. Какие годы были наиболее продуктивны для издательств по количеству выпущенных книг?
-- ретроспектива динамики издательской активности на макро-уровне

SELECT 
    EXTRACT(YEAR FROM publication_date)::INT AS pub_year,
    COUNT(book_id) AS books_count,
    COUNT(DISTINCT publisher_id) AS active_publishers,
    ROUND(AVG(num_pages)::numeric, 0) AS avg_pages,
    ROUND(100.0 * COUNT(book_id) / SUM(COUNT(book_id)) OVER (), 2) AS pct_of_total
FROM books
WHERE publication_date IS NOT NULL
  AND num_pages > 50  -- исключаем брошюры
GROUP BY EXTRACT(YEAR FROM publication_date)
ORDER BY pub_year;

-- 4.4. Активные игроки на рынке книгоиздания
/* Анализ распределения количества книг по издательствам является необходимым методологическим шагом перед определением границ «активного игрока» на рынке,
поскольку произвольный порог «топ-20» в условиях крайне неравномерной структуры каталога не отражает реальной рыночной динамики и
рискует отсечь значимых поставщиков контента или, наоборот, включить «разовых» издателей с единичными релизами. Только опираясь на статистически обоснованные перцентили, 
можно выделить сегмент издательств, которые систематически формируют фонд платформы, а не представлены случайными единичными приобретениями, что критически важно 
для построения объективной картины рыночной концентрации и выявления реальных стратегических партнёров, с которыми должны вестись переговоры о лицензировании контента.*/

-- распределение книг

WITH publisher_counts AS (
    SELECT 
        p.publisher_id,
        p.publisher,
        COUNT(b.book_id) AS book_count
    FROM publishers p
    LEFT JOIN books b ON p.publisher_id = b.publisher_id
        AND b.publication_date IS NOT NULL
        AND b.num_pages > 50
    GROUP BY p.publisher_id, p.publisher
)
SELECT 
    COUNT(*) AS "Всего издательств",
    SUM(book_count) AS "Общее число книг",
    MIN(book_count) AS "Минимум",
    MAX(book_count) AS "Максимум",
    ROUND(AVG(book_count)::numeric, 2) AS "Среднее",
    ROUND(STDDEV(book_count)::numeric, 2) AS "Стандартное отклонение",
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY book_count) AS "25-й перцентиль",
    PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY book_count) AS "Медиана (50-й)",
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY book_count) AS "75-й перцентиль",
    PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY book_count) AS "90-й перцентиль",
    PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY book_count) AS "95-й перцентиль",
    PERCENTILE_CONT(0.99) WITHIN GROUP (ORDER BY book_count) AS "99-й перцентиль"
FROM publisher_counts;

-- активные игроки

WITH top_publishers AS (
    SELECT 
        p.publisher_id,
        p.publisher,
        COUNT(b.book_id) AS total_books
    FROM publishers p
    JOIN books b ON p.publisher_id = b.publisher_id
    WHERE b.num_pages > 50
    GROUP BY p.publisher_id, p.publisher
    HAVING COUNT(b.book_id) >= 7  -- 90-й перцентиль
),
yearly_stats AS (
    SELECT 
        tp.publisher_id,
        tp.publisher,
        tp.total_books,
        EXTRACT(YEAR FROM b.publication_date)::INT AS pub_year,
        COUNT(b.book_id) AS books_in_year,
        ROUND(100.0 * COUNT(b.book_id) / tp.total_books, 2) AS pct_in_year
    FROM top_publishers tp
    JOIN books b ON tp.publisher_id = b.publisher_id
    WHERE b.publication_date IS NOT NULL
    GROUP BY tp.publisher_id, tp.publisher, tp.total_books, EXTRACT(YEAR FROM b.publication_date)
),
peak_years AS (
    SELECT DISTINCT ON (publisher_id)
        publisher_id,
        publisher,
        total_books,
        pub_year AS peak_year,
        books_in_year AS books_in_peak_year,
        pct_in_year AS pct_in_peak_year
    FROM yearly_stats
    ORDER BY publisher_id, books_in_year DESC
)
SELECT 
    publisher AS "Издательство",
    total_books AS "Всего книг",
    peak_year AS "Пиковый год",
    books_in_peak_year AS "Книг в пиковый год",
    pct_in_peak_year AS "% книг в пиковый год"
FROM peak_years
ORDER BY books_in_peak_year DESC;

-- ============================================================================
-- ШАГ 5. ПОВЕДЕНИЕ ПОЛЬЗОВАТЕЛЕЙ
-- ============================================================================

/* Важное методологическое замечание: все выводы шагов 2–4 построены исключительно на структурных метаданных (рейтинги, идентификаторы, даты) 
вне зависимости от содержательного анализа текстовых отзывов. Блок 5.18–5.20 посвящён диагностике качества текстового контента и выполняется автономно.
Пользователи электронного приложения чтения книг по подписке проявляют себя в форме рейтингов и отзывов для каждой книги. 
У нас нет временных данных, на основе которых мы могли бы дать точную характеристику пользовательского поведения за весь период существования приложения, 
однако, мы вполне можем воспользоваться двумя аналогами временных линий - автоинкрементными id для рейтингов и отзывов.
Для начала проверим последовательность присвоенных значений для этих параметров на непрерывность, чтобы выявить удалённые отзывы и удалённые рейтинги.*/

-- 5.1. Проверка на разрывы в последовательности review_id и rating_id

-- проверка на последовательность появления отзывов в приложении

WITH ordered_ids AS (
  SELECT review_id, 
         LAG(review_id) OVER (ORDER BY review_id) AS prev_id
  FROM reviews
)
SELECT prev_id + 1 AS missing_from, 
       review_id - 1 AS missing_to
FROM ordered_ids
WHERE review_id > prev_id + 1;

-- проверка на последовательность появления рейтингов в приложении

WITH ordered_ids AS (
  SELECT rating_id, 
         LAG(rating_id) OVER (ORDER BY rating_id) AS prev_id
  FROM ratings
)
SELECT prev_id + 1 AS missing_from, 
       rating_id - 1 AS missing_to
FROM ordered_ids
WHERE rating_id > prev_id + 1;

-- 5.2. Следы пользовательской активности как маркеры хронологических рамок существования приложения

-- нарезка на категории
-- вынимаем из данных последовательно информацию о книге, где отмечен самый первый / самый последний автоинкременированный id рейтинга / id отзыва / рейтинг + отзыв на одну книгу
-- первые и последние книги по году издания с рейтингами/отзывами

WITH first_rating AS (
    SELECT book_id FROM ratings ORDER BY rating_id ASC LIMIT 1
),
first_review AS (
    SELECT book_id FROM reviews ORDER BY review_id ASC LIMIT 1
),
book_info AS (
    SELECT 
        b.book_id,
        b.title,
        a.author AS author_name,
        EXTRACT(YEAR FROM b.publication_date)::INT AS publication_year
    FROM books b
    JOIN authors a ON b.author_id = a.author_id
    WHERE b.publication_date IS NOT NULL
),
rated_books AS (
    SELECT DISTINCT b.book_id, b.title, b.publication_date, a.author AS author_name
    FROM books b
    JOIN authors a ON b.author_id = a.author_id
    JOIN ratings r ON b.book_id = r.book_id
    WHERE b.publication_date IS NOT NULL
),
reviewed_books AS (
    SELECT DISTINCT b.book_id, b.title, b.publication_date, a.author AS author_name
    FROM books b
    JOIN authors a ON b.author_id = a.author_id
    JOIN reviews v ON b.book_id = v.book_id
    WHERE b.publication_date IS NOT NULL
),
both_books AS (
    SELECT rb.book_id, rb.title, rb.publication_date, rb.author_name
    FROM rated_books rb
    INNER JOIN reviewed_books rv ON rb.book_id = rv.book_id
)

-- самые первые
(
    SELECT 
        'самая первая по году издания книга с рейтингом' AS category,
        bi.title, 
        bi.author_name AS author, 
        bi.publication_year AS year
    FROM first_rating fr
    JOIN book_info bi ON fr.book_id = bi.book_id
)
UNION ALL
(
    SELECT 
        'самая первая по году издания книга с отзывом',
        bi.title, 
        bi.author_name, 
        bi.publication_year
    FROM first_review fv
    JOIN book_info bi ON fv.book_id = bi.book_id
)
UNION ALL
(
    SELECT 
        'самая первая по году издания книга с рейтингом и отзывом',
        bi.title, 
        bi.author_name, 
        bi.publication_year
    FROM first_rating fr
    JOIN first_review fv ON fr.book_id = fv.book_id
    JOIN book_info bi ON fr.book_id = bi.book_id
)

UNION ALL

-- самые последние
(
    SELECT 
        'самая последняя по году издания книга с рейтингом' AS category,
        title, 
        author_name AS author, 
        EXTRACT(YEAR FROM publication_date)::INT AS year
    FROM rated_books
    ORDER BY publication_date DESC, title
    LIMIT 1
)
UNION ALL
(
    SELECT 
        'самая последняя по году издания книга с отзывом',
        title, 
        author_name, 
        EXTRACT(YEAR FROM publication_date)::INT
    FROM reviewed_books
    ORDER BY publication_date DESC, title
    LIMIT 1
)
UNION ALL
(
    SELECT 
        'самая последняя по году издания книга с рейтингом и отзывом',
        title, 
        author_name, 
        EXTRACT(YEAR FROM publication_date)::INT
    FROM both_books
    ORDER BY publication_date DESC, title
    LIMIT 1
);

-- 5.3. Базовый профиль активности пользователя по id-интервалам
-- Создадим профили активности каждого пользователя через анализ интервалов между его последовательными отзывами, используя автоинкрементные review_id как прокси-метрику времени.
-- упорядочим отзывы и рассчитаем интервалы между ними

WITH ordered_reviews AS (
    -- упорядочивание отзывов пользователя
    SELECT 
        username,
        review_id,
        ROW_NUMBER() OVER (PARTITION BY username ORDER BY review_id) AS seq_num,
        LAG(review_id) OVER (PARTITION BY username ORDER BY review_id) AS prev_id
    FROM reviews
),
gaps AS (
    -- расчёт интервалов между отзывами
    SELECT 
        username,
        seq_num,
        review_id - prev_id AS id_gap
    FROM ordered_reviews
    WHERE prev_id IS NOT NULL
)
SELECT 
    -- агрегация профилей активности
    username,
    MAX(seq_num) + 1 AS total_reviews,   -- общее число отзывов (+1, т.к. gaps на 1 меньше)
    MIN(id_gap) AS min_gap,              -- минимальный интервал (самый "плотный" период активности)
    MAX(id_gap) AS max_gap,              -- максимальный интервал (самый длинный перерыв)
    ROUND(AVG(id_gap), 2) AS avg_gap,    -- средний интервал (общая интенсивность)
    ROUND(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY id_gap)::numeric, 2) AS median_gap  -- медианный интервал
FROM gaps
GROUP BY username
ORDER BY avg_gap ASC;

-- 5.4. Анализ тренда: пользователь ускоряется, стагнирует или «остывает»?
-- Разделим жизненный цикл пользователя на фазы по порядковому номеру отзыва и сравним интервалы.

WITH ordered_reviews AS (
    -- нумеруем отзывы пользователя по возрастанию review_id
    SELECT 
        username,
        review_id,
        ROW_NUMBER() OVER (PARTITION BY username ORDER BY review_id) AS seq,
        COUNT(*) OVER (PARTITION BY username) AS total
    FROM reviews
),
gaps_calc AS (
    -- вычисляем разницу между текущим и предыдущим review_id
    SELECT 
        username,
        seq,
        total,
        review_id - LAG(review_id) OVER (PARTITION BY username ORDER BY review_id) AS gap
    FROM ordered_reviews
),
gaps_filtered AS (
    -- теперь фильтруем: gap IS NOT NULL (первый отзыв пользователя не имеет предыдущего)
    SELECT *
    FROM gaps_calc
    WHERE gap IS NOT NULL
),
phased AS (
    -- распределяем отзывы по фазам: early / middle / late
    SELECT 
        username,
        gap,
        CASE 
            WHEN seq <= total * 0.33 THEN 'early'
            WHEN seq <= total * 0.66 THEN 'middle'
            ELSE 'late'
        END AS phase
    FROM gaps_filtered
),
user_phase_avg AS (
    -- агрегируем средние интервалы по фазам
    SELECT 
        username,
        AVG(CASE WHEN phase = 'early' THEN gap END) AS avg_gap_early,
        AVG(CASE WHEN phase = 'late' THEN gap END) AS avg_gap_late,
        COUNT(*) FILTER (WHERE phase = 'late') AS reviews_in_late_phase
    FROM phased
    GROUP BY username
    HAVING COUNT(*) >= 3  -- минимум 3 отзыва с вычисленным интервалом для надёжности
)
SELECT 
    username,
    ROUND(avg_gap_early::numeric, 1) AS avg_gap_early,
    ROUND(avg_gap_late::numeric, 1) AS avg_gap_late,
    CASE 
        WHEN avg_gap_late < avg_gap_early * 0.8 THEN 'accelerating'
        WHEN avg_gap_late > avg_gap_early * 1.3 THEN 'cooling_off'
        ELSE 'stable'
    END AS behavior_trend,
    reviews_in_late_phase
FROM user_phase_avg
WHERE avg_gap_early IS NOT NULL 
  AND avg_gap_late IS NOT NULL
ORDER BY avg_gap_late / NULLIF(avg_gap_early, 0) DESC NULLS LAST;

-- 5.5. Глобальная динамика платформы по id-таймлайну
-- Поскольку дат нет, сгруппируем отзывы по диапазонам значений review_id. Это покажет, как менялась общая активность системы.
-- Зернистость деления на хронологические группы установим на отметке 10.

-- динамика появления пользовательских отзывов

WITH chronological_periods AS (
    -- делим все отзывы на 10 равных хронологических групп
    SELECT 
        username,
        review_id,
        NTILE(10) OVER (ORDER BY review_id) AS period_num
    FROM reviews
),
user_period_activity AS (
    -- считаем активность каждого пользователя внутри периода
    SELECT 
        period_num,
        username,
        COUNT(*) AS reviews_in_period
    FROM chronological_periods
    GROUP BY period_num, username
),
period_aggregates AS (
    -- агрегируем метрики по периодам
    SELECT 
        period_num,
        SUM(reviews_in_period) AS total_reviews,
        COUNT(username) AS active_users,
        COUNT(CASE WHEN reviews_in_period >= 2 THEN 1 END) AS repeat_reviewers
    FROM user_period_activity
    GROUP BY period_num
)
SELECT 
    period_num,
    total_reviews,
    active_users,
    ROUND((total_reviews::numeric / NULLIF(active_users, 0)), 2) AS reviews_per_user,
    ROUND((100.0 * repeat_reviewers / NULLIF(active_users, 0))::numeric, 2) AS pct_repeat_reviewers
FROM period_aggregates
ORDER BY period_num;

-- 5.6. Сколько пользователей активны во всех 10 периодах?
-- анализ сквозного покрытия: сегментация аудитории по глубине вовлечённости

-- привязка отзывов к периодам
WITH user_periods AS (
    -- подзапрос для подсчёта периодов на пользователя
    SELECT 
        username,
        NTILE(10) OVER (ORDER BY review_id) AS period_num
    FROM reviews
)
-- финальная агрегация по трём ключевым метрикам 
SELECT 
    COUNT(DISTINCT username) AS total_unique_users, -- общее число уникальных пользователей, оставивших хотя бы один отзыв (размер активной аудитории)
    COUNT(DISTINCT CASE WHEN period_count = 10 THEN username END) AS users_in_all_periods, -- число пользователей, которые были активны во всех 10 периодах (лояльное ядро)
    COUNT(DISTINCT CASE WHEN period_count = 1 THEN username END) AS users_in_one_period_only -- число пользователей, которые появились на платформе только в одном периоде и больше не возвращались
FROM (
    SELECT username, COUNT(DISTINCT period_num) AS period_count
    FROM user_periods
    GROUP BY username
) AS user_coverage;

-- 5.7. Количественная оценка вклада ядра пользователей
-- необходимо оценить, какой процент отзывов даёт ядро из 26 пользователей

-- разбиваем отзывы на равные десять хронологических срезов
WITH chronological_periods AS (
    SELECT 
        username,
        NTILE(10) OVER (ORDER BY review_id) AS period_num
    FROM reviews
),
-- считаем для каждого пользователя количество периодов, в которых он был активным
user_period_counts AS (
    SELECT username, COUNT(DISTINCT period_num) AS periods_active
    FROM chronological_periods
    GROUP BY username
),
-- отбираем ядро пользователей, у которых все десять периодов - активные
core_users AS (
    SELECT username FROM user_period_counts WHERE periods_active = 10
)
-- через условное агрегирование считаем общие метрики и показатели ядра
SELECT 
    COUNT(DISTINCT r.username) AS total_users,                                          -- всего пользователей
    COUNT(DISTINCT CASE WHEN c.username IS NOT NULL THEN r.username END) AS core_users, -- пользователи ядра
    COUNT(*) AS total_reviews,                                                          -- всего отзывов
    COUNT(CASE WHEN c.username IS NOT NULL THEN 1 END) AS core_reviews,                 -- отзывы ядра
    ROUND(100.0 * COUNT(CASE WHEN c.username IS NOT NULL THEN 1 END) / COUNT(*), 1) AS core_review_pct -- ключевая метрика: процент отзывов у пользователей ядра
FROM reviews r
LEFT JOIN core_users c ON r.username = c.username;

-- 5.8. Пересечение книг у ядра пользователей и остальных пользователей
-- пишут ли представители ядра и остальные пользователи отзывы на одни и те же книги?

WITH user_period_coverage AS (
    -- считаем для каждого пользователя в скольких периодах он активен
    SELECT 
        username,
        COUNT(DISTINCT period_num) AS periods_active
    FROM (
        SELECT 
            username,
            NTILE(10) OVER (ORDER BY review_id) AS period_num
        FROM reviews
    ) AS user_periods
    GROUP BY username
),
core_users AS (
    -- выделяем ядро активных пользователей во всех 10 периодах
    SELECT username 
    FROM user_period_coverage 
    WHERE periods_active = 10
)
-- сравниваем поведение по книгам + средний рейтинг из таблицы `ratings`
SELECT 
    CASE WHEN c.username IS NOT NULL THEN 'core' ELSE 'regular' END AS segment,
    COUNT(DISTINCT r.book_id) AS unique_books_reviewed,
    COUNT(*) AS total_reviews,
    ROUND(COUNT(*)::numeric / NULLIF(COUNT(DISTINCT r.book_id), 0), 2) AS reviews_per_book,
    ROUND(AVG(rt.rating), 2) AS avg_rating  -- рейтинг берём из таблицы `ratings`
FROM reviews r
LEFT JOIN core_users c ON r.username = c.username
LEFT JOIN ratings rt 
    ON r.username = rt.username 
    AND r.book_id = rt.book_id  -- соединяем по пользователю и книге
GROUP BY 1
ORDER BY segment;

-- 5.9. Перекрёстный анализ: рецензируют ли ядро пользователей и регулярные пользователи одни и те же книги?
-- Проверить перекрытие: сколько книг рецензировали обе группы

-- считаем меру глубины вовлечённости: делим все отзывы на 10 равных хронологических периодов по возрастанию `review_id` и агрегируем по пользователям
WITH user_period_coverage AS (
    SELECT username, COUNT(DISTINCT period_num) AS periods_active
    FROM (
        SELECT username, NTILE(10) OVER (ORDER BY review_id) AS period_num
        FROM reviews
    ) t GROUP BY username
),
-- выделяем ядро активных пользователей во всех 10 периодах
core_users AS (
    SELECT username FROM user_period_coverage WHERE periods_active = 10
),
-- находим книги, которые читали пользователи ядра
core_books AS (
    SELECT DISTINCT book_id FROM reviews 
    WHERE username IN (SELECT username FROM core_users)
),
-- находим книги, которые читали все пользователи, кроме пользователей ядра
regular_books AS (
    SELECT DISTINCT book_id FROM reviews 
    WHERE username NOT IN (SELECT username FROM core_users)
)
-- финальный расчёт метрик пересечения
SELECT 
    (SELECT COUNT(*) FROM core_books) AS core_unique_books,       -- книги ядра               
    (SELECT COUNT(*) FROM regular_books) AS regular_unique_books, -- книги всех остальных пользователей
    (SELECT COUNT(*) FROM core_books INTERSECT SELECT book_id FROM regular_books) AS overlapping_books, -- общность книг: и у ядра, и у остальных пользователей
    ROUND(100.0 * (SELECT COUNT(*) FROM core_books INTERSECT SELECT book_id FROM regular_books) 
          / NULLIF((SELECT COUNT(*) FROM core_books), 0), 1) AS pct_core_in_regular,           -- какая доля книг ядра покрыта остальными пользователями + защита от деления на ноль
    ROUND(100.0 * (SELECT COUNT(*) FROM core_books INTERSECT SELECT book_id FROM regular_books) 
          / NULLIF((SELECT COUNT(*) FROM regular_books), 0), 1) AS pct_regular_in_core;        -- какая доля книг всех остальных пользователей покрыта ядром + защита от деления на ноль

-- 5.10. Сегментация пользователей по паттерну id-интервалов
-- поведенческая архитектура сообщества приложения для чтения книг: от постоянных авторов до эпизодических наблюдателей.

WITH review_gaps AS (
    -- для каждого отзыва считаем интервал до предыдущего отзыва того же пользователя
    SELECT 
        username,
        review_id,
        review_id - LAG(review_id) OVER (PARTITION BY username ORDER BY review_id) AS gap
    FROM reviews
),
user_gap_stats AS (
    -- агрегируем статистику по пользователю
    SELECT 
        username,
        COUNT(*) AS total_reviews,
        AVG(gap) AS avg_gap,
        STDDEV(gap) AS gap_stddev
    FROM review_gaps
    WHERE gap IS NOT NULL  -- исключаем первый отзыв пользователя (нет предыдущего)
    GROUP BY username
    HAVING COUNT(*) >= 2   -- минимум 2 отзыва с вычисленным интервала
),
segmented AS (
    -- присваиваем квартили активности и стабильности
    SELECT 
        username,
        total_reviews,
        avg_gap,
        gap_stddev,
        NTILE(4) OVER (ORDER BY avg_gap ASC) AS activity_quartile,      -- меньше интервал = выше активность
        NTILE(4) OVER (ORDER BY gap_stddev ASC) AS consistency_quartile -- меньше stddev = стабильнее
    FROM user_gap_stats
)
-- финальная группировка по сегментам
SELECT 
    CASE 
        WHEN activity_quartile = 1 AND consistency_quartile = 1 THEN 'Опорные авторы'
        WHEN activity_quartile = 1 AND consistency_quartile IN (3, 4) THEN 'Импульсивные авторы'
        WHEN activity_quartile IN (3, 4) AND total_reviews >= 5 THEN 'Эпизодические авторы'
        WHEN total_reviews <= 3 THEN 'Только один отзыв'
        ELSE 'Завсегдатаи'
    END AS segment,
    COUNT(*) AS user_count,
    ROUND(AVG(total_reviews)::numeric, 1) AS avg_reviews,
    ROUND(AVG(avg_gap)::numeric, 1) AS avg_system_gap,
    ROUND(AVG(gap_stddev)::numeric, 1) AS avg_gap_variability
FROM segmented
GROUP BY 
    CASE 
        WHEN activity_quartile = 1 AND consistency_quartile = 1 THEN 'Опорные авторы' --  стабильность, предсказуемость и регулярность, они всегда "на посту"
        WHEN activity_quartile = 1 AND consistency_quartile IN (3, 4) THEN 'Импульсивные авторы' -- пишут отзыв только тогда, когда книга сильно задела за живое
        WHEN activity_quartile IN (3, 4) AND total_reviews >= 5 THEN 'Эпизодические авторы' -- редкий гость на платформе
        WHEN total_reviews <= 3 THEN 'Только один отзыв'  -- один отзыв за всё время пребывания на платформе
        ELSE 'Завсегдатаи' -- оставляет отзывы ругелярно, но без фанатизма
    END
ORDER BY user_count DESC;

-- 5.11. Распределение рейтингов

SELECT 
    EXTRACT(YEAR FROM b.publication_date)::INT AS publication_year,
    COUNT(r.rating_id) AS total_ratings,
    COUNT(DISTINCT b.book_id) AS books_with_ratings,
    ROUND(COUNT(r.rating_id) * 100.0 / SUM(COUNT(r.rating_id)) OVER (), 2) AS percent_of_total,
    ROUND(AVG(r.rating), 2) AS avg_rating  -- средний рейтинг по году
FROM books b
JOIN ratings r ON b.book_id = r.book_id
WHERE b.publication_date IS NOT NULL
GROUP BY EXTRACT(YEAR FROM b.publication_date)
ORDER BY publication_year;

-- 5.12. *Средний рейтинг и количество отзывов для каждой книги
-- расчёт количества отзывов и средней пользовательской оценки в отношении каждой книги

WITH review_agg AS (
    SELECT book_id, COUNT(*) AS num_reviews
    FROM reviews
    GROUP BY book_id
),
rating_agg AS (
    SELECT book_id, ROUND(AVG(rating), 2) AS avg_rating
    FROM ratings
    GROUP BY book_id
)
SELECT 
    b.book_id,
    b.title,
    COALESCE(ra.num_reviews, 0) AS num_reviews,
    COALESCE(rt.avg_rating, 0) AS avg_rating
FROM books b
LEFT JOIN review_agg ra ON b.book_id = ra.book_id
LEFT JOIN rating_agg rt ON b.book_id = rt.book_id
ORDER BY num_reviews DESC, avg_rating DESC;

-- 5.13. Корреляция между рейтингом и длиной отзыва (посимвольно)
-- Анализ качества обратной связи: эмоциональные низкие оценки vs развёрнутые высокие.

WITH review_rating_pairs AS (
    SELECT 
        rt.rating,
        CHAR_LENGTH(r.text) AS review_length,
        LENGTH(r.text) - LENGTH(REPLACE(r.text, ' ', '')) + 1 AS word_count
    FROM reviews r
    INNER JOIN ratings rt 
        ON r.book_id = rt.book_id 
        AND r.username = rt.username
    WHERE r.text IS NOT NULL
)

-- корреляция Пирсона
SELECT 
    'Корреляция Пирсона' AS метрика,
    NULL AS рейтинг,
    ROUND(CORR(rating, review_length)::numeric, 4) AS корреляция_длина,
    ROUND(CORR(rating, word_count)::numeric, 4) AS корреляция_слова,
    COUNT(*) AS количество_пар,
    ROUND(AVG(review_length)::numeric, 1) AS средняя_длина,
    ROUND(AVG(word_count)::numeric, 1) AS средняя_количество_слов
FROM review_rating_pairs

UNION ALL

-- разбивка по уровням рейтинга
SELECT 
    'Разбивка по рейтингу',
    rating,
    ROUND(AVG(review_length)::numeric, 1),
    ROUND(AVG(word_count)::numeric, 1),
    COUNT(*),
    ROUND(MIN(review_length)::numeric, 0),
    ROUND(MAX(review_length)::numeric, 0)
FROM review_rating_pairs
GROUP BY rating
ORDER BY метрика, рейтинг;

-- 5.14. Распределение отзывов и средний рейтинг у каждой книги

WITH book_review_counts AS (
    -- для каждой книги считаем количество обзоров (из таблицы `reviews`)
    SELECT 
        b.book_id,
        COUNT(r.review_id) AS review_count
    FROM books b
    LEFT JOIN reviews r ON b.book_id = r.book_id
    GROUP BY b.book_id
),
book_avg_ratings AS (
    -- средний рейтинг для каждой книги (из таблицы `ratings`)
    SELECT 
        book_id,
        AVG(rating) AS avg_book_rating
    FROM ratings
    WHERE rating IS NOT NULL
    GROUP BY book_id
),
totals AS (
    -- общие итоги для расчёта процентов
    SELECT 
        COUNT(*) AS total_books,
        SUM(review_count) AS total_reviews
    FROM book_review_counts
),
grouped_stats AS (
    -- агрегация по количеству обзоров
    SELECT 
        brc.review_count,
        COUNT(*) AS books_count,
        SUM(brc.review_count) AS reviews_in_group,
        AVG(bar.avg_book_rating) AS avg_rating
    FROM book_review_counts brc
    LEFT JOIN book_avg_ratings bar ON brc.book_id = bar.book_id
    GROUP BY brc.review_count
)
-- финальный вывод с расчётом долей
SELECT 
    g.review_count,
    g.books_count,
    ROUND(g.books_count * 100.0 / t.total_books, 2) AS books_share_pct,
    g.reviews_in_group,
    ROUND(g.reviews_in_group * 100.0 / t.total_reviews, 2) AS reviews_share_pct,
    ROUND(g.avg_rating, 2) AS avg_rating
FROM grouped_stats g
CROSS JOIN totals t
ORDER BY g.review_count;

-- 5.15. Книги, которые пользователи оставили без отзывов

WITH review_counts AS (
    SELECT book_id, COUNT(*) AS num_reviews   -- считаем количество обзоров на книгу
    FROM reviews
    GROUP BY book_id
),
rating_avg AS (
    SELECT book_id, ROUND(AVG(rating), 2) AS avg_rating  -- считаем средний рейтинг на книгу
    FROM ratings
    GROUP BY book_id
)
SELECT 
    b.title,
    COALESCE(rc.num_reviews, 0) AS num_reviews,  -- равно нулю, если обзоров нет
    COALESCE(ra.avg_rating, 0) AS avg_rating     -- равно нулю, если оценок нет
FROM books b
LEFT JOIN review_counts rc ON b.book_id = rc.book_id
LEFT JOIN rating_avg ra ON b.book_id = ra.book_id
WHERE COALESCE(rc.num_reviews, 0) = 0            -- оставляем только книги без обзоров
ORDER BY avg_rating DESC;

-- 5.16. *Среднее количество отзывов от пользователей, которые поставили больше 48 оценок

SELECT
        ROUND(AVG(cnt_reviews), 2) AS avg_reviews
FROM (
  SELECT username, COUNT(*) AS cnt_reviews
  FROM reviews
  WHERE username IN (
    SELECT username
    FROM ratings
    GROUP BY username
    HAVING COUNT(*) > 48)
  GROUP BY username) subquery;

-- 5.17. Распределение количества отзывов

SELECT 
    review_count, 
    COUNT(*) AS books_count
FROM (
    -- подзапрос для расчёта отзывов для каждой книги
    SELECT 
        b.book_id,
        COUNT(r.review_id) AS review_count
    FROM books b
    LEFT JOIN reviews r ON b.book_id = r.book_id
    GROUP BY b.book_id
) t
-- внешний запрос для группировки книги по количеству отзывов
GROUP BY review_count
ORDER BY review_count;

-- 5.18. Аудит качества текстового контента: проверка на естественность

-- нарезка из топ-10 самых длинных и самых коротких отзывов 

WITH ranked_reviews AS (
    SELECT 
        review_id,
        book_id,
        username,
        text,
        LENGTH(text) AS text_length,
        ROW_NUMBER() OVER (ORDER BY LENGTH(text) DESC) AS rn_long,
        ROW_NUMBER() OVER (ORDER BY LENGTH(text) ASC)  AS rn_short
    FROM reviews
    WHERE text IS NOT NULL
)
SELECT review_id, book_id, username, text, text_length, 'длинные отзывы' AS category
FROM ranked_reviews
WHERE rn_long <= 10

UNION ALL

SELECT review_id, book_id, username, text, text_length, 'короткие отзывы' AS category
FROM ranked_reviews
WHERE rn_short <= 10

ORDER BY category, text_length DESC
LIMIT 50;

-- 5.19. Анализ частотности вхождения слов в отзывах

WITH words AS (
    SELECT 
        LOWER(REGEXP_REPLACE(token, '[^a-z]', '', 'g')) AS token     -- извлекаем слова, приводим их к нижнему регистру и считаем частоту
    FROM reviews
    CROSS JOIN LATERAL regexp_split_to_table(text, '\s+') AS token
    WHERE text IS NOT NULL AND LENGTH(text) > 0
),
filtered AS (
    SELECT token
    FROM words
    WHERE token <> '' AND LENGTH(token) > 1  -- убираем пустые и однобуквенные
)
SELECT 
    token,
    COUNT(*) AS cnt_token,                                           -- частота вхождения в абсолютных значениях
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS pct_token   -- доля в общем корпусе слов
FROM filtered
GROUP BY token
ORDER BY pct_token DESC
LIMIT 50;

-- 5.20. Закон Ципфа

-- первый блок расчётов: распределение частотности слов в тексте

WITH words AS (
    SELECT LOWER(REGEXP_REPLACE(word, '[^a-z]', '', 'g')) AS clean_word
    FROM reviews
    CROSS JOIN LATERAL regexp_split_to_table(text, '\s+') AS word
    WHERE text IS NOT NULL AND LENGTH(text) > 0
),
word_freq AS (
    SELECT clean_word, COUNT(*) AS freq
    FROM words
    WHERE clean_word <> '' AND LENGTH(clean_word) > 1
    GROUP BY clean_word
),
ranked AS (
    SELECT 
        clean_word,
        freq,
        SUM(freq) OVER (ORDER BY freq DESC) AS cumulative_freq
    FROM word_freq
)
SELECT 
    COUNT(*) AS words_to_80pct,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM word_freq), 1) AS pct_of_vocabulary
FROM ranked
WHERE cumulative_freq <= (SELECT SUM(freq) * 0.8 FROM word_freq);

-- второй блок расчётов: токенизация

WITH words AS (
    SELECT w.word AS word
    FROM reviews r,
         LATERAL regexp_split_to_table(r.text, '[^A-Za-z]+') AS w(word)  -- выделяем токены
    WHERE w.word <> '' 
      AND LENGTH(w.word) >= 3  -- убираем из расчётов 1- и 2-буквенные токены
      AND r.text IS NOT NULL
),
word_freq AS (
    SELECT word, COUNT(*) AS freq  -- считаем количество вхождений токена
    FROM words
    GROUP BY word
),
corpus_stats AS (
-- агрегация метрик
    SELECT                            
        COUNT(*) AS unique_words,  -- количество уникальных токенов   
        SUM(freq)  AS total_tokens,  -- суммарное количество токенов в корпусе слов
        COUNT(*) FILTER (WHERE freq = 1) AS hapax_count  -- уникальные слова, которые встречаются единожды
    FROM word_freq
)
-- итоговые расчёты
SELECT 
    unique_words,
    total_tokens,
    ROUND(total_tokens::numeric / NULLIF(unique_words, 0), 2) AS avg_freq_per_word, -- сколько раз в среднем встречается слово
    hapax_count, -- количество уникальных слов, которые встречаются единожды
    ROUND(hapax_count::numeric / NULLIF(unique_words, 0), 4) AS hapax_pct -- доля уникальных слов, которые встречаются единожды, по отношению ко всему корпусу
FROM corpus_stats;

-- ============================================================================
-- ШАГ 6. ВЫВОДЫ
-- ============================================================================

/*
Глобальное ценностное предложение: Просторы литературных вселенных для искушённых читателей

Суть позиционирования: вместо бесконечной гонки за новинками мы создали цифровую библиотеку мировых бестселлеров и культовых вселенных для вас, 
потому что вы цените время за чтением книги больше, чем свежесть обложки. Настоящая литература не стареет — она становится глубже с каждым прочтением. 
Мы трепетно относимся к репутации платформы и работаем только с проверенными издательствами.

Резюме для инвесторов и продуктовой команды: Мы не пытаемся стать заменой социальным сетям с тысячами комментариев и механических лайков. 
Мы заявляем прямо: мы — храм чтения, на виртуальных полках которого бережно хранятся лучшие и признанные образцы мировой литературы. 
В эпоху короткого контента мы продаём нашим читателям истинное удовольствие от погружения в мир литературных вселенных. 
Наше конкурентное преимущество — не новизна, а глубина. Не количество, а качество. Не хайп, а проверенная временем ценность.
Это позиционирование позволяет нам занять уникальную нишу на рынке и построить устойчивый бизнес с высокой лояльностью аудитории и предсказуемыми метриками удержания.
*/