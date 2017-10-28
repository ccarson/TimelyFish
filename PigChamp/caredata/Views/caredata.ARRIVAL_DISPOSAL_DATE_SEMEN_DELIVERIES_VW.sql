CREATE VIEW [caredata].[ARRIVAL_DISPOSAL_DATE_SEMEN_DELIVERIES_VW]
AS
SELECT e.identity_id 
      ,e.eventdate arrival_date 
      ,s.expiry_date disposal_date 
      ,h.primary_identity
      ,h.identity_type
      ,h.is_current_site
      ,h.site_id
  FROM caredata.bh_events e 
           INNER JOIN caredata.hdr_semen_batches s ON e.identity_id = s.identity_id 
           INNER JOIN caredata.bh_identity_history h ON e.identity_id = h.identity_id 
 WHERE e.event_type = 155
   and e.deletion_date IS NULL 
   and h.deletion_date IS NULL 
