select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select *
from "jacob_db"."nba_staging_airflow"."staging_aws_transactions_table"
where date is null



      
    ) dbt_internal_test