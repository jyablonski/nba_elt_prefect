select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      

    with grouped_expression as (
    select
        
        
    
  
count(*) = 30
 as expression


    from "jacob_db"."nba_staging_airflow"."staging_aws_adv_stats_table"
    

),
validation_errors as (

    select
        *
    from
        grouped_expression
    where
        not(expression = true)

)

select *
from validation_errors




      
    ) dbt_internal_test