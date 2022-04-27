SELECT
    player::text AS player,
    team::text AS team,
    season_salary::numeric AS salary
FROM "jacob_db"."nba_airflow"."aws_contracts_source"