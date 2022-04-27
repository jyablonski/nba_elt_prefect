with final_table as (
    select
        player,
        team_acronym,
        team,
        date,
        status,
        injury,
        description
    from "jacob_db"."nba_staging_airflow"."staging_aws_injury_data_table"
)

select *
from final_table