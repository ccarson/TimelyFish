CREATE VIEW [caredata].[COMMON_LOOKUPS_USED_VW]
AS
SELECT DISTINCT d.test_type_id lookup_id, h.site_id
  FROM caredata.ev_preg_checks d INNER JOIN caredata.bh_events h ON h.event_id = d.event_id
 WHERE h.deletion_date IS NULL
   and d.test_type_id IS NOT NULL
UNION
SELECT DISTINCT d.lock_id lookup_id, h.site_id
  FROM caredata.ev_matings d INNER JOIN caredata.bh_events h ON h.event_id = d.event_id
 WHERE h.deletion_date IS NULL
   and d.lock_id IS NOT NULL
UNION
SELECT DISTINCT d.leak_id lookup_id, h.site_id
  FROM caredata.ev_matings d INNER JOIN caredata.bh_events h ON h.event_id = d.event_id
 WHERE h.deletion_date IS NULL
   and d.leak_id IS NOT NULL
UNION
SELECT DISTINCT d.quality_id lookup_id, h.site_id
  FROM caredata.ev_matings d INNER JOIN caredata.bh_events h ON h.event_id = d.event_id
 WHERE h.deletion_date IS NULL
  and d.quality_id IS NOT NULL
UNION
SELECT DISTINCT d.standing_reflex_id lookup_id, h.site_id
  FROM caredata.ev_matings d INNER JOIN caredata.bh_events h ON h.event_id = d.event_id
 WHERE h.deletion_date IS NULL
   and d.standing_reflex_id IS NOT NULL
UNION
SELECT DISTINCT d.lesion_score_id lookup_id, h.site_id
  FROM caredata.ev_body_condition d INNER JOIN caredata.bh_events h ON h.event_id = d.event_id
 WHERE h.deletion_date IS NULL
   and d.lesion_score_id IS NOT NULL
UNION
SELECT DISTINCT d.defect_id lookup_id, h.site_id
  FROM caredata.ev_piglet_defects d INNER JOIN caredata.bh_events h ON h.event_id = d.event_id
 WHERE h.deletion_date IS NULL
   and d.defect_id IS NOT NULL
UNION
SELECT DISTINCT d.herd_category_id lookup_id, h.site_id
  FROM caredata.hdr_sows d INNER JOIN caredata.bh_identity_history h ON h.identity_id = d.identity_id
 WHERE h.deletion_date IS NULL
   and d.herd_category_id IS NOT NULL
UNION
SELECT DISTINCT d.herd_category_id lookup_id, h.site_id
  FROM caredata.hdr_boars d INNER JOIN caredata.bh_identity_history h ON h.identity_id = d.identity_id
 WHERE h.deletion_date IS NULL
   and d.herd_category_id IS NOT NULL
UNION
SELECT DISTINCT d.defect_id lookup_id, bn.site_id
  FROM caredata.ev_cohort_defects d INNER JOIN caredata.cohort_location_reservations h ON h.sub_cohort_id = d.sub_cohort_id
       INNER JOIN caredata.hdr_feed_locations lc ON lc.location_id = h.sub_cohort_id
       INNER JOIN caredata.hdr_feed_barns bn ON bn.barn_id = lc.barn_id
 WHERE d.deletion_date IS NULL and h.deletion_date IS NULL
UNION
SELECT DISTINCT h.condition_score_id lookup_id, h.site_id
  FROM caredata.bh_events h
 WHERE h.deletion_date IS NULL
   and h.condition_score_id IS NOT NULL
UNION
SELECT DISTINCT h.controller_manufacturer_id lookup_id, h.site_id
  FROM caredata.hdr_feed_barns h
 WHERE h.deletion_date IS NULL
   and h.controller_manufacturer_id IS NOT NULL
UNION
SELECT DISTINCT h.alarm_manufacturer_id lookup_id, h.site_id
  FROM caredata.hdr_feed_barns h 
 WHERE h.deletion_date IS NULL
   and h.alarm_manufacturer_id IS NOT NULL
