select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select
    team_logo as unique_field,
    count(*) as n_records

from "jacob_db"."nba_airflow"."staging_seed_team_attributes"
where team_logo is not null
group by team_logo
having count(*) > 1



      
    ) dbt_internal_test