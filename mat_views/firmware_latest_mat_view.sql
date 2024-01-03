-- Deploy iot_core:iot/mat_views/firmware_latest_mat_view to pg

BEGIN;

drop MATERIALIZED VIEW if exists iot.firmware_latest_mat_view;

CREATE MATERIALIZED VIEW iot.firmware_latest_mat_view AS
WITH lfw AS (
	SELECT f.device_model,
	       f.fw_version_num,
	       f.id,
	       ROW_NUMBER() OVER (PARTITION BY f.device_model ORDER BY f.fw_version_num DESC) rn
	  FROM iot.firmware f
	 WHERE f.is_enabled = True
	   AND f.dev_only = False
)
SELECT device_model,
       id,
       fw_version_num
  FROM lfw 
 WHERE rn = 1;

CREATE UNIQUE INDEX firmware_latest_model_idx ON iot.firmware_latest_mat_view (device_model);

ALTER TABLE iot.firmware_latest_mat_view OWNER TO postgres;
GRANT ALL ON TABLE iot.firmware_latest_mat_view TO postgres;
GRANT SELECT ON TABLE iot.firmware_latest_mat_view TO iotuser;
GRANT SELECT ON TABLE iot.firmware_latest_mat_view TO grafana;

COMMIT;
