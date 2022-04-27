

  create  table "jacob_db"."nba_prod_airflow"."prod_transactions__dbt_tmp"
  as (
    with transactions_data as (
    select
        date,
        transaction
    from "jacob_db"."nba_staging_airflow"."staging_aws_transactions_table"
)

select *
from transactions_data
  );