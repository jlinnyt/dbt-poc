with subscription_status as (select fsh.dim_subscriber_id,
                                    fin_ent.entitlementId,
                                    fin_ent.isActive,
                                    fin_ent.mostRecentlyDeactivated
                             FROM `nyt-dssor-dev.dssor_publish_202207282125200000.fact_subscriber_history` fsh
                                      CROSS JOIN UNNEST(financial_entitlements) as fin_ent)
SELECT fsh.fact_subscriber_history_id,
                fsh.dim_subscriber_id,
                fsh.bundle_type,
                fsh.is_paid_subscription,
                ss.entitlementId,
                fe.financial_entitlement_code,
                ss.isActive is_active_subscription,
                ss.mostRecentlyDeactivated,
                fsh.version_eff_ts_nyct,
                fsh.version_end_ts_nyct,
                fsh.fact_subscriber_history_sequence,
                fsh.financial_subscriber_id
FROM `nyt-dssor-dev.dssor_publish_202207282125200000.fact_subscriber_history` fsh
         JOIN subscription_status ss on ss.dim_subscriber_id = fsh.dim_subscriber_id
         JOIN `nyt-dssor-dev.dssor_publish_202207282125200000.dim_financial_entitlement` fe
              on fe.dim_financial_entitlement_id = ss.entitlementId
GROUP BY fsh.fact_subscriber_history_id, fsh.dim_subscriber_id, fsh.bundle_type, fsh.is_paid_subscription,
         ss.entitlementId, fe.financial_entitlement_code, ss.isActive, ss.mostRecentlyDeactivated,
         fsh.version_eff_ts_nyct, fsh.version_end_ts_nyct, fsh.fact_subscriber_history_sequence, fsh.financial_subscriber_id
ORDER BY fsh.fact_subscriber_history_id, fsh.dim_subscriber_id
