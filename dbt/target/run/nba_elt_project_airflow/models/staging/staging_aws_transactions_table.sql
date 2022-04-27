
  create view "jacob_db"."nba_staging_airflow"."staging_aws_transactions_table__dbt_tmp" as (
    SELECT
    date::TIMESTAMP AS date,
    transaction::text
FROM "jacob_db"."nba_airflow"."aws_transactions_source"
  );