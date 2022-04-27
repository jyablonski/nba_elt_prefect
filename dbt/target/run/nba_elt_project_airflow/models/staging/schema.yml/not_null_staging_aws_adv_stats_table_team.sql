select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select *
from "jacob_db"."nba_staging_airflow"."staging_aws_adv_stats_table"
where team is null



      
    ) dbt_internal_test