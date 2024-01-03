-- Deploy iot_core:iot/mat_views/gateways_full_mat_view_grants to pg

BEGIN;

ALTER MATERIALIZED VIEW iot.gateways_full_mat_view
  OWNER TO pgadmin;

GRANT SELECT
  ON iot.gateways_full_mat_view TO iotuser;

COMMIT;
