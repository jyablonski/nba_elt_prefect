
  create view "jacob_db"."nba_staging_airflow"."staging_aws_schedule_table__dbt_tmp" as (
    with schedule_data as (
    select
        away_team::text as away_team,
        /* extract(isodow from proper_date) as day_of_week, this gives the day of week in numeric form lmfao */
        home_team::text as home_team,
        date::text as date,
        proper_date::date as proper_date,
        SUBSTR(start_time, 0, LENGTH(start_time) - 0)::text as start_time,
        TO_CHAR(proper_date, 'Day') as day_name
    from "jacob_db"."nba_airflow"."aws_schedule_source"
)

select *
from schedule_data
  );
