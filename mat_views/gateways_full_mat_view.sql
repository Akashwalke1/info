-- Deploy iot_core:iot/mat_views/gateways_full_mat_view to pg


BEGIN;

DROP MATERIALIZED VIEW IF EXISTS iot.gateways_full_mat_view;

CREATE MATERIALIZED VIEW IF NOT EXISTS iot.gateways_full_mat_view
AS
  SELECT g.id,
         g.gw_uuid,
         iot_convert_uuid_to_gw( g.gw_uuid ) AS gw_uid,
		 COALESCE(g.wan_mac::text, '00:00:00:00:00:00'::text) AS wan_mac,
		 g.title,
		 g.account_id,
		 COALESCE(uac.email, ''::character varying) AS email,
		 COALESCE(wl.white_label::text, ''::text) AS white_label,
		 g.stats_last_seen,
		 g.is_test_gw,
		 g.fw_is_up_to_date AS up_to_date,
		 COALESCE(dot.serial::text, ''::text) AS ott_serial,
		 COALESCE(g.dev_serial, ''::text) AS dev_serial
  FROM gateways g
       LEFT JOIN user_accounts uac ON uac.id = g.account_id
       LEFT JOIN dev_ott dot ON g.gw_uuid = dot.gw_uuid
       LEFT JOIN white_labels wl ON g.white_label_id = wl.id
;

COMMIT;

