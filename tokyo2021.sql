#Total participants per discipline:
SELECT 
	eg.Discipline, 
	eg.Total 
FROM 
	entriesgender eg
GROUP BY 
	eg.Discipline
ORDER BY 
	eg.Total desc
;


#Total medals per country (top 5 ranking), showing medals distribution:
SELECT 
	m.`Team/NOC`,
	m.Gold,
    m.Silver,
    m.Bronze,
    m.Total
FROM 
	medals m
ORDER BY 
	m.Total desc
LIMIT 5
;

#Top country per medal type:
SELECT
	concat('Most Gold: ',m.`Team/NOC`) as Country,
    max(m.Gold) as Total
FROM
	medals m
UNION
SELECT
	concat('Most Silver: ',m.`Team/NOC`) as Country,
    max(m.Silver) as Total
FROM
	medals m
UNION
SELECT
	concat('Most Bronze: ',m.`Team/NOC`) as Country,
    max(m.Bronze) as Total
FROM
	medals m
;

#Total particpants per country
SELECT 
	count(a.name) as Total_Athletes, 
	NOC as Team
FROM 
	athletes a
GROUP BY 
	NOC
ORDER BY 
	Total_Athletes desc
;

#Total coaches per by the country
SELECT 
	count(c.Name) as Total_Coaches,
	c.NOC 
FROM 
	coaches c
GROUP BY
	c.NOC
ORDER BY
	Total_Coaches desc
;

#Total disciplines per Country
SELECT * 
FROM (
	SELECT
		Name,
		count(distinct discipline) as Count_of_Discipline
	FROM 
		teams
	GROUP BY
		Name) a
ORDER BY 
	a.Count_of_Discipline desc
;

#Performance per country with total coaches and athletes info
SELECT
	count(c.Name) as Total_Coaches,
	Count_of_players as Total_Athletes,
	c.NOC,
	m.Total as Total_Medals_Won
FROM coaches c
join (
	SELECT
		`TEAM/NOC` as Country,
		Gold,
		Silver,
		Bronze,
		Total
	FROM
		medals) m
ON 
	c.NOC=m.Country 
    
JOIN (
	SELECT * 
	FROM (
		SELECT 
			count(Name) as Count_of_Players,NOC
		FROM 
			athletes
		GROUP BY
			NOC) a
		ORDER BY
			a.Count_of_players desc) p
ON 
	c.NOC=p.NOC
group by 
	c.NOC
order by
	m.Total desc
;

#Ratio of Athlete vs Coach

SELECT
	Coach_table.NOC,
	Total_Athletes,
	Total_Coaches,
	round(Total_Athletes/Total_Coaches,2) as Athlete_Coach_Ratio
FROM (
	SELECT * 
    FROM (
		SELECT
			count(Name) as Total_Athletes,
            NOC
		FROM
			athletes
		GROUP BY
			NOC) a
		ORDER BY
			a.Total_Athletes desc) Athlete_table
            
JOIN (
	SELECT * 
	FROM (
		SELECT 
			count(Name) as Total_Coaches,
			NOC 
		FROM 
			coaches
		GROUP BY 
			NOC) c
		ORDER BY 
			c.Total_Coaches desc) Coach_table

ON 
	Athlete_table.NOC=Coach_table.NOC	
;

