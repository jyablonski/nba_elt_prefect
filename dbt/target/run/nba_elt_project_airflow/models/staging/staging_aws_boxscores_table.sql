
  create view "jacob_db"."nba_staging_airflow"."staging_aws_boxscores_table__dbt_tmp" as (
    with season_stats as (
    SELECT 
            player::text as player,
            sum(fga::numeric) as fga_total,
            sum(fta::numeric) as fta_total,
            sum(pts::numeric) as pts_total,
            COUNT(*) as games_played,
    type::text as type
    FROM "jacob_db"."nba_airflow"."aws_boxscores_source"
    WHERE player IS NOT NULL
    group by player, type
),

/*      pts / (2 * (fga + (fta::numeric * 0.44))) as hm */
game_stats as (
    SELECT player,
           team,
           location,
           opponent,
           outcome,
           mp,
           fgm,
           fga::numeric,
           fgpercent,
           threepfgmade,
           threepattempted,
           threepointpercent,
           ft,
           fta,
           ftpercent,
           oreb,
           dreb,
           trb,
           ast,
           stl,
           blk,
           tov,
           pf,
           pts::numeric,
           plusminus,
           gmsc,
           date,
           type,
           season
    FROM "jacob_db"."nba_airflow"."aws_boxscores_source"
    WHERE player IS NOT NULL

),

game_ids as (
    SELECT distinct
     DENSE_RANK() OVER (
         ORDER BY 
              date,(
                CASE
                    WHEN team < opponent THEN CONCAT(team,opponent)
                    ELSE CONCAT(opponent,team)
                END
              )
     ) as game_id,     
     team,
     date,
     opponent
     FROM "jacob_db"."nba_airflow"."aws_boxscores_source"
    
),

final_aws_boxscores as (
    SELECT g.player,
           g.team,
           i.game_id,
           g.date,
           g.location,
           g.opponent,
           g.outcome,
           g.mp,
           g.fgm,
           g.fga,
           g.fgpercent,
           g.threepfgmade,
           g.threepattempted,
           g.threepointpercent,
           g.ft,
           g.fta,
           g.ftpercent,
           g.oreb,
           g.dreb,
           g.trb,
           g.ast,
           g.stl,
           g.blk,
           g.tov,
           g.pf,
           g.pts,
           g.plusminus,
           g.gmsc,
           g.type,
           g.season,
           CASE WHEN g.pts = 0 AND g.fga = 0 AND g.fta::numeric = 0 THEN NULL
     ELSE round(g.pts / (2 * (g.fga + (g.fta::numeric * 0.44))), 3)
END as game_ts_percent,
           CASE WHEN s.pts_total = 0 AND s.fga_total = 0 AND s.fta_total::numeric = 0 THEN NULL
     ELSE round(s.pts_total / (2 * (s.fga_total + (s.fta_total::numeric * 0.44))), 3)
END as season_ts_percent,
           round(s.pts_total / s.games_played, 1)::numeric as season_avg_ppg,
           s.games_played as games_played
    from game_stats g
    LEFT JOIN season_stats s using (player)
    LEFT JOIN game_ids i using (team, date, opponent)

)

SELECT * FROM final_aws_boxscores
  );
