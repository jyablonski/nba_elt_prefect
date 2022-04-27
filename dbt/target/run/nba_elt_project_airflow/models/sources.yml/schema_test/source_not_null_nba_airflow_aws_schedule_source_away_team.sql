select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select *
from "jacob_db"."nba_airflow"."aws_schedule_source"
where away_team is null



      
    ) dbt_internal_test