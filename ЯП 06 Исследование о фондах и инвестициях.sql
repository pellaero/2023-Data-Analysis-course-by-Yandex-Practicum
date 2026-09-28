/*	Исследование данных о фондах и инвестициях.
В базе данных хранится информация о венчурных фондах и инвестициях в компании-стартапы. 
Венчурные фонды — это финансовые организации, которые могут позволить себе высокий риск и инвестировать в компании с инновационной бизнес-идеей или разработанной новой технологией, то есть в стартапы. Цель венчурных фондов — в будущем получить значительную прибыль, которая в разы превысит размер их трат на инвестиции в компанию. Если стартап подорожает, венчурный фонд может получить долю в компании или фиксированный процент от её выручки. 
Чтобы процесс финансирования стал менее рискованным, его делят на стадии — раунды. Тот или иной раунд зависит от того, какого уровня развития достигла компания. 
Первые этапы — предпосевной и посевной раунды. Предпосевной раунд предполагает, что компания как таковая ещё не создана и находится в стадии замысла. Следующий — посевной — раунд знаменует рост проекта: создатели компании разрабатывают бизнес-модель и привлекают инвесторов. 
Если компании требуется ментор или наставник — она привлекает бизнес-ангела. Бизнес-ангелы — инвесторы, которые помимо финансовой поддержки предлагают экспертную помощь. Такой раунд называют ангельским. 
Когда стартап становится компанией с проверенной бизнес-моделью и начинает зарабатывать самостоятельно, предложений инвесторов становится больше. Это раунд A, а за ним следуют и другие: B, C, D — на этих этапах компания активно развивается и готовится к IPO. 
Иногда выделяют венчурный раунд — финансирование, которое могло поступить от венчурного фонда на любом этапе: начальном или более позднем. 

Для анализа дана БД, в составе которой 7 таблиц:

01. Таблица "ACQUSITION" (информация о покупках одних компаний другими)
1. первичный ключ id — идентификатор или уникальный номер покупки;
2. внешний ключ acquiring_company_id — ссылается на таблицу company — идентификатор компании-покупателя, то есть той, что покупает другую компанию;
3. внешний ключ acquired_company_id — ссылается на таблицу company — идентификатор компании, которую покупают;
4. term_code — способ оплаты сделки:
        cash — наличными;
        stock — акциями компании;
        cash_and_stock — смешанный тип оплаты: наличные и акции.
5. price_amount — сумма покупки в долларах;
6. acquired_at — дата совершения сделки;
7. created_at — дата и время создания записи в таблице;
8. updated_at — дата и время обновления записи в таблице.

02. Таблица "COMPANY" (информация о компаниях-стартапах)
1. первичный ключ id — идентификатор, или уникальный номер компании;
2. name — название компании;
3. category_code — категория деятельности компании, например:
        news — специализируется на работе с новостями;
        social — специализируется на социальной работе.
4. status — статус компании:
        acquired — приобретена;
        operating — действует;
        ipo — вышла на IPO;
        closed — перестала существовать.
5. founded_at — дата основания компании;
6. closed_at — дата закрытия компании, которую указывают в том случае, если компании больше не существует;
7. domain — домен сайта компании;
8. network_username — профиль фонда в корпоративной сети биржи;
9. country_code — код страны, например, USA для США, GBR для Великобритании;
10. investment_rounds — число раундов, в которых компания участвовала как инвестор;
11. funding_rounds — число раундов, в которых компания привлекала инвестиции;
12. funding_total — сумма привлечённых инвестиций в долларах;
13. milestones — количество важных этапов в истории компании;
14. created_at — дата и время создания записи в таблице;
15. updated_at — дата и время обновления записи в таблице.

03. Таблица "EDUCATION" (уровень образования сотрудников компаний)
1. первичный ключ id — уникальный номер записи с информацией об образовании;
2. внешний ключ person_id — ссылается на таблицу people — идентификатор человека, информация о котором представлена в записи;
3. degree_type — учебная степень, например:
        BA — Bachelor of Arts — бакалавр гуманитарных наук;
        MS — Master of Science — магистр естественных наук.
4. instituition — учебное заведение, название университета;
5. graduated_at — дата завершения обучения, выпуска;
6. created_at — дата и время создания записи в таблице;
7. updated_at — дата и время обновления записи в таблице.

04. Таблица "FUND" (информация о венчурных фондах)
первичный ключ id — уникальный номер венчурного фонда;
name — название венчурного фонда;
founded_at — дата основания фонда;
domain — домен сайта фонда;
network_username — профиль фонда в корпоративной сети биржи;
country_code — код страны фонда;
investment_rounds — число инвестиционных раундов, в которых фонд принимал участие;
invested_companies — число компаний, в которые инвестировал фонд;
milestones — количество важных этапов в истории фонда;
created_at — дата и время создания записи в таблице;
updated_at — дата и время обновления записи в таблице.

05. Таблица "FUNDING_ROUND" (информация о раундах инвестиций)
первичный ключ id — уникальный номер инвестиционного раунда;
внешний ключ company_id — ссылается на таблицу company — уникальный номер компании, участвовавшей в инвестиционном раунде;
funded_at — дата проведения раунда;
funding_round_type — тип инвестиционного раунда, например:
venture — венчурный раунд;
angel — ангельский раунд;
series_a — раунд А.
raised_amount — сумма инвестиций, которую привлекла компания в этом раунде в долларах;
pre_money_valuation — предварительная, проведённая до инвестиций оценка стоимости компании в долларах;
participants — количество участников инвестиционного раунда;
is_first_round — является ли этот раунд первым для компании;
is_last_round — является ли этот раунд последним для компании;
created_at — дата и время создания записи в таблице;
updated_at — дата и время обновления записи в таблице.

06. Таблица "INVESTMENT" (информация об инвестициях венчурных фондов в компании-стартапы)
первичный ключ id — уникальный номер инвестиции;
внешний ключ funding_round_id — ссылается на таблицу funding_round — уникальный номер раунда инвестиции;
внешний ключ company_id — ссылается на таблицу company — уникальный номер компании-стартапа, в которую инвестируют;
внешний ключ fund_id — ссылается на таблицу fund — уникальный номер фонда, инвестирующего в компанию-стартап;
created_at — дата и время создания записи в таблице;
updated_at — дата и время обновления записи в таблице.

07. Таблица "PEOPLE" (информация о сотрудниках компаний-стартапов)
первичный ключ id — уникальный номер сотрудника;
first_name — имя сотрудника;
last_name — фамилия сотрудника;
внешний ключ company_id — ссылается на таблицу company — уникальный номер компании-стартапа;
network_username — профиль фонда в корпоративной сети биржи;
created_at — дата и время создания записи в таблице;
updated_at — дата и время обновления записи в таблице.
*/

-- 1. Посчитайте, сколько компаний закрылось.

SELECT COUNT(id)
FROM company
WHERE status = 'closed';

-- 2. Отобразите количество привлечённых средств для новостных компаний США. Используйте данные из таблицы company. Отсортируйте таблицу по убыванию значений в поле funding_total .

SELECT funding_total
FROM company
WHERE category_code = 'news' AND country_code = 'USA'
ORDER BY funding_total DESC;

-- 3. Найдите общую сумму сделок по покупке одних компаний другими в долларах. Отберите сделки, которые осуществлялись только за наличные с 2011 по 2013 год включительно. 

SELECT SUM(price_amount)
FROM acquisition
WHERE term_code = 'cash' AND 
EXTRACT (YEAR FROM acquired_at) IN (2011,2012,2013);

-- 4. Отобразите имя, фамилию и названия аккаунтов людей в поле network_username, у которых названия аккаунтов начинаются на 'Silver'.

SELECT first_name, last_name, twitter_username
FROM people
WHERE twitter_username LIKE ('Silver%');

-- 5. Выведите на экран всю информацию о людях, у которых названия аккаунтов в поле network_username содержат подстроку 'money', а фамилия начинается на 'K'.

SELECT *
FROM people
WHERE twitter_username LIKE ('%money%') AND last_name LIKE ('K%');

-- 6. Для каждой страны отобразите общую сумму привлечённых инвестиций, которые получили компании, зарегистрированные в этой стране. Страну, в которой зарегистрирована компания, можно определить по коду страны. Отсортируйте данные по убыванию суммы.

SELECT country_code, SUM(funding_total)
FROM company
GROUP BY country_code
ORDER BY SUM(funding_total) DESC;

-- 7. Составьте таблицу, в которую войдёт дата проведения раунда, а также минимальное и максимальное значения суммы инвестиций, привлечённых в эту дату. Оставьте в итоговой таблице только те записи, в которых минимальное значение суммы инвестиций не равно нулю и не равно максимальному значению.

SELECT funded_at, MIN(raised_amount), MAX(raised_amount)
FROM funding_round
GROUP BY funded_at
HAVING MIN(raised_amount) !=0 AND MIN(raised_amount) != MAX(raised_amount);

-- 8. Создайте поле с категориями:
-- Для фондов, которые инвестируют в 100 и более компаний, назначьте категорию high_activity.
-- Для фондов, которые инвестируют в 20 и более компаний до 100, назначьте категорию middle_activity.
-- Если количество инвестируемых компаний фонда не достигает 20, назначьте категорию low_activity.
-- Отобразите все поля таблицы fund и новое поле с категориями.

SELECT *,
    CASE
           WHEN invested_companies > 100 THEN 'high_activity'
           WHEN invested_companies BETWEEN 20 AND 100 THEN 'middle_activity'
           WHEN invested_companies < 20 THEN 'low_activity'
       END
FROM fund;

-- 9. Для каждой из категорий, назначенных в предыдущем задании, посчитайте округлённое до ближайшего целого числа среднее количество инвестиционных раундов, в которых фонд принимал участие. Выведите на экран категории и среднее число инвестиционных раундов. Отсортируйте таблицу по возрастанию среднего.

SELECT 
       CASE
           WHEN invested_companies>=100 THEN 'high_activity'
           WHEN invested_companies>=20 THEN 'middle_activity'
           ELSE 'low_activity'
       END AS activity,
       ROUND(AVG(investment_rounds))

FROM fund
GROUP BY activity
ORDER BY ROUND(AVG(investment_rounds));

-- 10. Проанализируйте, в каких странах находятся фонды, которые чаще всего инвестируют в стартапы.
-- Для каждой страны посчитайте минимальное, максимальное и среднее число компаний, в которые инвестировали фонды этой страны, основанные с 2010 по 2012 год включительно. Исключите страны с фондами, у которых минимальное число компаний, получивших инвестиции, равно нулю. 
-- Выгрузите 10 самых активных стран-инвесторов: отсортируйте таблицу по среднему количеству компаний от большего к меньшему. Затем добавьте сортировку по коду страны в лексикографическом порядке.

SELECT
        country_code,
        MIN(invested_companies),
        MAX(invested_companies),
        AVG(invested_companies)

FROM fund
WHERE
        EXTRACT (YEAR FROM founded_at) BETWEEN 2010 AND 2012
GROUP BY country_code
HAVING MIN(invested_companies) != 0
ORDER BY AVG(invested_companies) DESC, country_code
LIMIT 10;

-- 11. Отобразите имя и фамилию всех сотрудников стартапов. Добавьте поле с названием учебного заведения, которое окончил сотрудник, если эта информация известна.

SELECT people.first_name, people.last_name, instituition

FROM people AS people
LEFT OUTER JOIN education AS educat ON people.id = educat.person_id;

-- 12. Для каждой компании найдите количество учебных заведений, которые окончили её сотрудники. Выведите название компании и число уникальных названий учебных заведений. Составьте топ-5 компаний по количеству университетов.

SELECT c.name, COUNT(DISTINCT instituition)
FROM company AS c
LEFT OUTER JOIN people AS p ON c.id = p.company_id
LEFT OUTER JOIN education AS e ON p.id = e.person_id
GROUP BY c.id
ORDER BY COUNT(DISTINCT instituition) DESC
LIMIT 5;

-- 13. Составьте список с уникальными названиями закрытых компаний, для которых первый раунд финансирования оказался последним.

SELECT DISTINCT name
FROM company AS c
LEFT OUTER JOIN funding_round AS fr ON c.id = fr.company_id
WHERE c.status = 'closed'
AND fr.is_first_round = 1
AND fr.is_last_round = 1
GROUP BY name;

-- 14. Составьте список уникальных номеров сотрудников, которые работают в компаниях, отобранных в предыдущем задании.

SELECT DISTINCT p.id
FROM people AS p
WHERE p.company_id IN
                        (SELECT c.id
                        FROM company AS c
                        JOIN funding_round AS fr ON c.id = fr.company_id
                        WHERE STATUS ='closed'
                        AND is_first_round = 1
                        AND is_last_round = 1
                        GROUP BY c.id);

-- 15. Составьте таблицу, куда войдут уникальные пары с номерами сотрудников из предыдущей задачи и учебным заведением, которое окончил сотрудник.

SELECT
        p.id,
        e.instituition

FROM people AS p
INNER JOIN education AS e ON p.id = e.person_id

WHERE p.company_id IN
     (SELECT c.id
                        FROM company AS c
                        LEFT JOIN funding_round AS fr ON c.id = fr.company_id
                        WHERE STATUS ='closed'
                        AND is_first_round = 1
                        AND is_last_round = 1
                        GROUP BY c.id)
                        
GROUP BY p.id, e.instituition;

-- 16. Посчитайте количество учебных заведений для каждого сотрудника из предыдущего задания. При подсчёте учитывайте, что некоторые сотрудники могли окончить одно и то же заведение дважды.

SELECT p.id,
COUNT(e.instituition)
FROM people AS p
LEFT JOIN education AS e ON p.id = e.person_id
WHERE p.company_id IN
(SELECT c.id
FROM company AS c
JOIN funding_round AS fr ON c.id = fr.company_id
WHERE STATUS ='closed'
AND is_first_round = 1
AND is_last_round = 1
GROUP BY c.id)
GROUP BY p.id
HAVING COUNT(DISTINCT e.instituition) >0;

-- 17. Дополните предыдущий запрос и выведите среднее число учебных заведений (всех, не только уникальных), которые окончили сотрудники разных компаний. Нужно вывести только одну запись, группировка здесь не понадобится.

WITH draft AS
(SELECT
            p.id,
            COUNT(e.instituition)
 
FROM people AS p
LEFT JOIN education AS e ON p.id = e.person_id
WHERE p.company_id IN
                    (SELECT c.id
                    FROM company AS c
                    JOIN funding_round AS fr ON c.id = fr.company_id
                    WHERE STATUS ='closed'
                    AND is_first_round = 1
                    AND is_last_round = 1
                    GROUP BY c.id)
GROUP BY p.id
HAVING COUNT(DISTINCT e.instituition) >0)

SELECT AVG(COUNT)

FROM draft;

-- 18. Выведите среднее число учебных заведений (всех, не только уникальных), которые окончили сотрудники Facebook (сервис, запрещённый на территории РФ).

WITH draft AS
(SELECT p.id, COUNT(e.instituition)
 
FROM people AS p
LEFT JOIN education AS e ON p.id = e.person_id
LEFT JOIN company AS c ON p.company_id = c.id
WHERE c.name = 'Facebook'
GROUP BY p.id
HAVING COUNT(DISTINCT e.instituition) >0)

SELECT AVG(COUNT)

FROM draft;

-- 19. Составьте таблицу из полей:
-- name_of_fund — название фонда;
-- name_of_company — название компании;
-- amount — сумма инвестиций, которую привлекла компания в раунде.
-- В таблицу войдут данные о компаниях, в истории которых было больше шести важных этапов, а раунды финансирования проходили с 2012 по 2013 год включительно.

SELECT
            f.name AS name_of_fund,
            c.name AS name_of_company,
            fr.raised_amount AS amount
 
FROM fund AS f
LEFT JOIN investment AS i ON f.id = i.fund_id
LEFT JOIN funding_round AS fr ON i.funding_round_id = fr.id
LEFT JOIN company AS c ON fr.company_id = c.id

WHERE c.milestones > 6
AND EXTRACT(YEAR FROM CAST(fr.funded_at AS date)) BETWEEN 2012 AND 2013;

-- 20. Выгрузите таблицу, в которой будут такие поля:
-- название компании-покупателя;
-- сумма сделки;
-- название компании, которую купили;
-- сумма инвестиций, вложенных в купленную компанию;
-- доля, которая отображает, во сколько раз сумма покупки превысила сумму вложенных в компанию инвестиций, округлённая до ближайшего целого числа.
-- Не учитывайте те сделки, в которых сумма покупки равна нулю. Если сумма инвестиций в компанию равна нулю, исключите такую компанию из таблицы. 
-- Отсортируйте таблицу по сумме сделки от большей к меньшей, а затем по названию купленной компании в лексикографическом порядке.
-- Ограничьте таблицу первыми десятью записями.

WITH
acquiring AS
                    (SELECT c.name AS buyer,
                    a.price_amount AS price,
                    a.id AS KEY
                    FROM acquisition AS a
                    LEFT JOIN company AS c ON a.acquiring_company_id = c.id
                    WHERE a.price_amount > 0),
acquired AS
                    (SELECT c.name AS acquisition,
                    c.funding_total AS investment,
                    a.id AS KEY
                    FROM acquisition AS a
                    LEFT JOIN company AS c ON a.acquired_company_id = c.id
                    WHERE c.funding_total > 0)

SELECT acqn.buyer,
acqn.price,
acqd.acquisition,
acqd.investment,
ROUND(acqn.price / acqd.investment) AS uplift

FROM acquiring AS acqn
JOIN acquired AS acqd ON acqn.KEY = acqd.KEY
ORDER BY price DESC, acquisition
LIMIT 10;

-- 21. Выгрузите таблицу, в которую войдут названия компаний из категории social, получившие финансирование с 2010 по 2013 год включительно. Проверьте, что сумма инвестиций не равна нулю. Выведите также номер месяца, в котором проходил раунд финансирования.

SELECT
        c.name,
        EXTRACT(MONTH FROM funded_at)
FROM company AS c
LEFT OUTER JOIN funding_round AS fr ON c.id = fr.company_id
WHERE c.category_code = 'social'
AND EXTRACT (YEAR FROM funded_at) BETWEEN 2010 AND 2013
AND fr.raised_amount !=0;

-- 22. Отберите данные по месяцам с 2010 по 2013 год, когда проходили инвестиционные раунды. Сгруппируйте данные по номеру месяца и получите таблицу, в которой будут поля:
-- номер месяца, в котором проходили раунды;
-- количество уникальных названий фондов из США, которые инвестировали в этом месяце;
-- количество компаний, купленных за этот месяц;
-- общая сумма сделок по покупкам в этом месяце.

SELECT
        table1.months,
        table1.fondy,
        table2.startups,
        table2.total_sum
FROM
    (SELECT
        EXTRACT (MONTH FROM funded_at) AS months,
        COUNT(DISTINCT name) AS fondy
        FROM fund AS fund
        LEFT OUTER JOIN investment AS i on fund.id = i.fund_id
        LEFT OUTER JOIN funding_round AS fr ON i.funding_round_id = fr.id
        WHERE EXTRACT (YEAR FROM funded_at) BETWEEN 2010 AND 2013
        AND country_code = 'USA' 
        GROUP BY EXTRACT (MONTH FROM funded_at)) AS table1

LEFT OUTER JOIN
    (SELECT
        EXTRACT(MONTH FROM CAST(acquired_at AS DATE)) AS months,
        COUNT (acquired_company_id) AS startups,
        SUM (price_amount) AS total_sum
        FROM acquisition AS a
        WHERE EXTRACT(YEAR FROM CAST(acquired_at AS DATE)) BETWEEN 2010 AND 2013
        GROUP BY EXTRACT(MONTH FROM CAST(acquired_at AS DATE))) AS table2 ON table1.months = table2.months;

-- 23. Составьте сводную таблицу и выведите среднюю сумму инвестиций для стран, в которых есть стартапы, зарегистрированные в 2011, 2012 и 2013 годах. Данные за каждый год должны быть в отдельном поле. Отсортируйте таблицу по среднему значению инвестиций за 2011 год от большего к меньшему.

WITH
table2011 AS
    (SELECT country_code, AVG(funding_total) AS year_2011
    FROM company
    WHERE EXTRACT(YEAR FROM founded_at) = 2011
    GROUP BY country_code),

table2012 AS 
    (SELECT country_code, AVG(funding_total) AS year_2012
    FROM company
    WHERE EXTRACT(YEAR FROM founded_at) = 2012
    GROUP BY country_code),

table2013 AS
    (SELECT country_code, AVG(funding_total) AS year_2013
    FROM company
    WHERE EXTRACT(YEAR FROM founded_at) = 2013
    GROUP BY country_code)

SELECT
        table2011.country_code,
        table2011.year_2011,
        table2012.year_2012,
        table2013.year_2013

FROM table2011
INNER JOIN table2012 ON table2011.country_code = table2012.country_code
INNER JOIN table2013 ON table2012.country_code = table2013.country_code

ORDER BY table2011.year_2011 DESC;