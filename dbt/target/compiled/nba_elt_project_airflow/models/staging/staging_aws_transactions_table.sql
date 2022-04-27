SELECT
    date::TIMESTAMP AS date,
    transaction::text
FROM "jacob_db"."nba_airflow"."aws_transactions_source"