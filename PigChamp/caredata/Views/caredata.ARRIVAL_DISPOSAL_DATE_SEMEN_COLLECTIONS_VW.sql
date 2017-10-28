CREATE VIEW [caredata].[ARRIVAL_DISPOSAL_DATE_SEMEN_COLLECTIONS_VW]
AS
SELECT c.batch_identity_id identity_id 
      ,e.eventdate arrival_date 
      ,s.expiry_date disposal_date 
      ,h.primary_identity
      ,h.identity_type
      ,h.is_current_site
      ,h.site_id
  FROM caredata.bh_events e 
           INNER JOIN caredata.ev_semen_collections c ON e.event_id = c.event_id 
           INNER JOIN caredata.hdr_semen_batches s ON c.batch_identity_id = s.identity_id 
           INNER JOIN caredata.bh_identity_history h ON e.identity_id = h.identity_id 
 WHERE e.event_type = 157
   and e.deletion_date IS NULL 
   and h.deletion_date IS NULL 
