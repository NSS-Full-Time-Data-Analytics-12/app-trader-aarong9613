

SELECT DISTINCT name, app_store_apps.price AS app_price, app_store_apps.rating AS app_rating , app_store_apps.content_rating AS app_content_rating, play_store_apps.price AS play_price, play_store_apps.rating AS play_rating, primary_genre AS app_genre, genres AS play_genre,
play_store_apps.content_rating AS play_content_rating
FROM app_store_apps
	INNER JOIN play_store_apps USING (name)
WHERE app_store_apps.review_count::numeric >12892.91 AND play_store_apps.review_count::numeric > 444152.90 AND app_store_apps.rating > 4 AND app_store_apps.price = 0.00 AND app_store_apps.content_rating = '4+'
ORDER BY play_store_apps.rating DESC, app_store_apps.rating DESC;

	

/*average revenue from in app advertising is $4000 per month after advertising cost are factored in or $48,000 per annum. For "free apps" the purchase price is $25,000, therfore after 7 months the in app advertising will cover the overhead regardless of in app purchases.''I suggest focusing on free apps as there over 501 apps that are listed as free and have a rating above 4 stars and an above average review count for sufficient sample size to ensure a more accurate and precise rating. Moreover, if we restrict our apps to a content_rating of 4+ we can market to kids and therefore a larger audienece resulting in 309 records. Also, by having apps with a high rating we prolong the life expectancy of the app that we purchase and increase the odds of an in app purchase by having higher user traffic. Lastly, we examined the genre and found that "games" were amongst the most popular. Given the above information we selected the 10 apps below that we would purchase.

1) Geometry Dash Lite
2) Domino's Pizza USA
3) Egg inc
4) Bible
5) Toy Blast
6) Chase Mobile
7) Fishdom
8)Geometry Dash Meltdown
9) Score! Hero
10)Township */
-------------------------------------------------------------------------------
WITH table_a AS (SELECT name, content_rating, rating, review_count::integer, price::numeric, (4000*12) AS min_gross_rev_year1, 
	CASE WHEN price::numeric BETWEEN 0 AND 2.50 THEN 25000
	   ELSE price *10000
		 END AS total_cost_year1
FROM app_store_apps
WHERE app_store_apps.name ILIKE '%Halloween%' OR app_store_apps.name ILIKE '%HAUNTED%' AND rating >= 4.0
	UNION 
SELECT name, content_rating, rating, review_count, price::numeric, (4000*12) AS min_gross_rev, 
	CASE WHEN price::numeric BETWEEN 0 AND 2.50 THEN 25000
	    ELSE price::numeric *10000
		END AS total_cost_year1
FROM play_store_apps
WHERE play_store_apps.name ILIKE '%Halloween%' OR play_store_apps.name ILIKE '%HAUNTED%' and rating >= 4.0
ORDER BY review_count DESC, rating DESC, price::numeric)

SELECT name, content_rating, rating, review_count::integer, price::numeric, (4000*12) AS min_gross_rev_year1, total_cost_year1, min_gross_rev_year1 - total_cost_year1 AS profit_year1
FROM table_a

--Being a Halloween themed campaign we first wanted to identify Halloween key words in both tables. Thus, it was necessary to union the tables so we could do a stacked search of all titles relating to Halloween which returned 17 records. Once we identified Halloween themed apps we narrowed our search based on a rating above 4.0 in addition to having a "high" review count which was visually verified due to the low record count. Furthermore, we opted for apps that were "free" to purchase which would keep the intial cost to $25,000. Based on the above critera we chose the below apps.

/* 
1) Haunted Halloween Escape
2) Connect'Em Halloween
3) Coin Dozer: Haunted
4) Halloween Sandbox Number Coloring- Color By Number
