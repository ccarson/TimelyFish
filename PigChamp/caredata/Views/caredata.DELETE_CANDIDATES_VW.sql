CREATE VIEW [caredata].[DELETE_CANDIDATES_VW]
AS
SELECT *
  FROM caredata.bh_identities
 WHERE identity_id NOT IN 
(
  SELECT identity_id FROM [caredata].[DELETED_IDENTITIES_VW] 
  UNION
  SELECT DISTINCT male_identity_id FROM caredata.ev_matings WHERE male_identity_id IS NOT NULL and identity_id IN (SELECT identity_id FROM [caredata].[DELETED_IDENTITIES_VW])
  UNION
  SELECT DISTINCT fostered_from_identity_id FROM caredata.ev_nurse_on WHERE fostered_from_identity_id IS NOT NULL and identity_id IN (SELECT identity_id FROM [caredata].[DELETED_IDENTITIES_VW])
  UNION
  SELECT DISTINCT f.identity_id FROM caredata.ev_fosters f INNER JOIN caredata.bh_events e ON f.other_event_id = e.event_id WHERE e.identity_id IN (SELECT identity_id FROM [caredata].[DELETED_IDENTITIES_VW])
)
