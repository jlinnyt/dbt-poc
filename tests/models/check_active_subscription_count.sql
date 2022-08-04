with active_subscriptions as
         (select count(*) as count
          from `nyt-dssor-dev.dbt_poc.paid_subscribers_model`
          where version_end_ts_nyct = '4195-01-01 00:00:00-05')
select count
from active_subscriptions
where
    count < 0