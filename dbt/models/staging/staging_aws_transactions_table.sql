SELECT
    date::TIMESTAMP AS date,
    transaction::text
FROM {{ source('nba_prefect', 'aws_transactions_source')}}