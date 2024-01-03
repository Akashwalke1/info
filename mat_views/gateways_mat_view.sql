-- Deploy iot_core:iot/mat_views/gateways_mat_view to pg

BEGIN;

CREATE MATERIALIZED VIEW IF NOT EXISTS iot.gateways_mat_view(
    gw_uuid,
    email,
    white_label)
AS
  SELECT gw.gw_uuid,
         ac.email,
         wl.white_label
  FROM gateways gw
       LEFT JOIN user_accounts ac ON gw.account_id = ac.id
       LEFT JOIN white_labels wl ON gw.white_label_id = wl.id;

REFRESH MATERIALIZED VIEW iot.gateways_mat_view;

COMMIT;
