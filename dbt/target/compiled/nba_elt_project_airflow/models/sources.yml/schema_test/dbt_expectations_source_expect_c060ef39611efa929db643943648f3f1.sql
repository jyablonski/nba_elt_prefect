

    with grouped_expression as (
    select
        
        
    
  
count(*) = 30
 as expression


    from "jacob_db"."nba_airflow"."aws_adv_stats_source"
    

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



