

  create  table "jacob_db"."nba_prod_airflow"."prod_team_adv_stats__dbt_tmp"
  as (
    with aws_adv_stats_table as (

    select *
    from "jacob_db"."nba_staging_airflow"."staging_aws_adv_stats_table"

),

team_attributes as (

    select *
    from "jacob_db"."nba_source"."staging_seed_team_attributes"
),

prod_adv_stats_table as (

    select *
    from aws_adv_stats_table
    left join team_attributes using (team)
)

select *
from prod_adv_stats_table
  );