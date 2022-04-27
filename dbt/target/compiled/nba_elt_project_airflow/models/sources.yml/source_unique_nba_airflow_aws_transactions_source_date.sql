
    
    

select
    date as unique_field,
    count(*) as n_records

from "jacob_db"."nba_airflow"."aws_transactions_source"
where date is not null
group by date
having count(*) > 1


