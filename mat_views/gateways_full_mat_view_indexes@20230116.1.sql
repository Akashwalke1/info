-- Deploy iot_core:iot/mat_views/gateways_full_mat_view_indexes to pg

BEGIN;

DO $$
BEGIN

CREATE UNIQUE INDEX gateways_full_mat_view_idx ON iot.gateways_full_mat_view
  USING btree (id);

EXCEPTION
    WHEN others THEN null;
END
$$;



COMMIT;
