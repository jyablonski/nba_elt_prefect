SELECT
    team::text,
    age::numeric,
    w::integer,
    l::integer,
    pw::integer,
    pl::integer,
    mov::numeric,
    sos::numeric,
    srs::numeric,
    ortg::numeric,
    drtg::numeric,
    nrtg::numeric,
    pace::numeric,
    ftr::numeric,
    "3par"::numeric AS three_p_rate,
    "ts%"::numeric AS ts_percent,
    "efg%"::numeric AS efg_percent,
    "tov%"::numeric AS tov_percent,
    "orb%"::numeric AS orb_percent,
    "ft/fga"::numeric AS ft_fga,
    "efg%_opp"::numeric AS efg_percent_opp,
    "tov%_opp"::numeric AS tov_percent_opp,
    "drb%_opp"::numeric AS drb_percent_opp,
    "ft/fga_opp"::numeric AS ft_fga_opp,
    arena::text,
    attendance::numeric,
    "att/game"::numeric AS att_game
FROM {{ source('nba_prefect', 'aws_adv_stats_source')}}