
    
    

select
    team as unique_field,
    count(*) as n_records

from "jacob_db"."nba_staging_airflow"."staging_aws_adv_stats_table"
where team is not null
group by team
having count(*) > 1


