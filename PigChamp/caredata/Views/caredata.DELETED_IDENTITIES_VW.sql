CREATE VIEW [caredata].[DELETED_IDENTITIES_VW] 
AS
SELECT DISTINCT h.identity_id 
  FROM caredata.bh_identity_history h INNER JOIN careglobal.farms f on h.site_id = f.site_id 
 GROUP BY h.identity_id 
HAVING MAX(main_site_id) > -1 
