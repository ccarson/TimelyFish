CREATE VIEW [caredata].[MEDICATION_BUDGET_VW]
AS
SELECT m.budget_id,
       m.ration_id,
       m.treatment_id,
       b.feed_budget_id,
       b.disabled,
       b.creation_date,
       b.created_by,
       b.last_update_date,
       b.last_update_by,
       b.deletion_date,
       b.deleted_by
  FROM caredata.map_feed_medication_rations m INNER JOIN caredata.hdr_medication_budgets b ON b.budget_id = m.budget_id
