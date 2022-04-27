SELECT  team::text as team,
        

CASE WHEN team = 'GS' THEN 'GSW'
     WHEN team = 'LA' THEN 'LAL'
     WHEN team = 'PHO' THEN 'PHX'
     WHEN team = 'CHO' THEN 'CHA'
     WHEN team = 'BRK' THEN 'BKN'
     WHEN team = 'NY' THEN 'NYK'
     ELSE team
END
 as team_acronym,
        spread::numeric as spread,
        total::numeric as total,
        moneyline::numeric as moneyline, 
        datetime1::timestamp as time, 
        date::date as date
FROM "jacob_db"."nba_airflow"."aws_odds_source"