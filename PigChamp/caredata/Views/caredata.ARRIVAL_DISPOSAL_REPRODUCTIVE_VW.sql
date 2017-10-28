

CREATE VIEW [caredata].[ARRIVAL_DISPOSAL_REPRODUCTIVE_VW] 
AS

-- --------------------------------------------------------------------------------
-- 2015/11/12 BMD:  Replace inline function call with left JOIN to bh_events (dbe)
--                     Reduced exucution time from minutes to under 1 second
-- --------------------------------------------------------------------------------
   
SELECT e.identity_id 
      ,e.eventdate arrival_date 
      --,[caresystem].GetDisposalDate(e.identity_id) disposal_date 
      ,dbe.eventdate as disposal_date
      ,h.primary_identity
      ,h.identity_type
      ,h.is_current_site
      ,h.site_id
  FROM caredata.bh_events e 
  INNER JOIN caredata.bh_identity_history h ON e.identity_id = h.identity_id
  Left Join caredata.bh_events dbe on dbe.identity_id = e.identity_id 
       and dbe.deletion_date IS NULL and dbe.event_type IN (298, 299, 300, 301) 
 WHERE e.event_type IN (100, 105, 110, 150)
   and e.deletion_date IS NULL 
   and h.deletion_date IS NULL 

