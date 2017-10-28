CREATE VIEW [caredata].[MEDICATION_USAGE_VW]
AS
SELECT m.purchase_id,
       SUM(m.quantity) as qty_used
  FROM caredata.map_medication_usage m INNER JOIN caredata.ev_medication_purchases p ON m.purchase_id = p.purchase_id
                                      INNER JOIN caredata.ev_medication_usage u ON m.event_id = u.event_id
 WHERE p.deletion_date IS NULL
   and u.deletion_date IS NULL
 GROUP BY m.purchase_id
