with team_ratings as (

    select *
    from "jacob_db"."nba_staging_airflow"."staging_aws_adv_stats_table"

),

team_attributes as (

    select *
    from "jacob_db"."nba_source"."staging_seed_team_attributes"
),

final_team_ratings as (

    select
        team_ratings.team,
        team_attributes.team_acronym,
        team_ratings.w,
        team_ratings.l,
        team_ratings.ortg,
        team_ratings.drtg,
        team_ratings.nrtg,
        CONCAT('logos/', LOWER(team_acronym), '.png') as team_logo
    from team_ratings
    left join team_attributes using (team)
)

select *
from final_team_ratings