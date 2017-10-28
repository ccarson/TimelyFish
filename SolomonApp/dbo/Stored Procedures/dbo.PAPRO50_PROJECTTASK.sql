
CREATE PROCEDURE [dbo].[PAPRO50_PROJECTTASK]
    @alloc_batch AS VARCHAR(10) AS

DECLARE @nAlloc_batch AS VARCHAR(10) = @alloc_batch,
        @cutOffString CHAR(3),
        @cutOffPercent INTEGER
       
-- Build a memory table of data to return
DECLARE @OUTPUT TABLE (
    period char(6),
    pjt_entity char(32),
    project char(16),
    tskpercent float)

SET NOCOUNT ON

-- Get the cut-off percent for doing specific or all tasks.
SET @cutOffString = ISNULL((SELECT LEFT(control_data, 3)
                             FROM PJCONTRL (NOLOCK)
                             WHERE control_type = 'PA'
                               AND control_code = 'ALLOC-SYNC-TASK-CUTOFF'), '75')
IF ISNUMERIC(@cutOffString) = 0
    SET @cutOffString = '75'
SET @cutOffPercent = CONVERT(INTEGER, ROUND(CONVERT(FLOAT, @cutOffString), 0))
IF @cutOffPercent > 100
    SET @cutOffPercent = 100
ELSE IF @cutOffPercent < 0
    SET @cutOffPercent = 0

-- Insert all the allocated projects for this run with their percentage of tasks allocated
INSERT INTO @OUTPUT
SELECT irc.period, CONVERT(CHAR(32), '%') AS pjt_entity, isa.project,
 ROUND(COUNT(DISTINCT isa.pjt_entity) / CONVERT(FLOAT, (SELECT COUNT(DISTINCT pt.pjt_entity) FROM PJPENT pt WHERE pt.project = isa.project)), 2) * 100 AS tskpercent
 FROM PJINDSRCAUD isa (NOLOCK)
 -- Get a list of periods that have rates calculated and are attached to projects in this batch
 CROSS JOIN (SELECT DISTINCT r.period
              FROM pjpoolh r
               JOIN PJINDSRCAUD pisa (NOLOCK)
                 ON pisa.fiscalno = r.period
                AND pisa.amount <> 0
                AND (pisa.alloc_batch = @nAlloc_batch
                    OR pisa.recalc_alloc_batch = @nAlloc_batch)
               JOIN PJPROJ p (NOLOCK)
                 ON pisa.project = p.project
               JOIN PJALLOC a (NOLOCK)
                 ON (a.alloc_method_cd = p.alloc_method_cd
                    OR a.alloc_method_cd = p.alloc_method2_cd)
               JOIN AllocGrp ag (NOLOCK)
                 ON (ag.GrpId = a.ptd_indirectgrp
                     OR ag.GrpId = a.ytd_indirectgrp)
               WHERE r.grpid = ag.GrpId) irc
 WHERE isa.fiscalno <= irc.period
   AND isa.amount <> 0
   AND (isa.alloc_batch = @nAlloc_batch
       OR isa.recalc_alloc_batch = @nAlloc_batch)
 GROUP BY irc.period, isa.project

-- Insert specific allocated tasks based on the percentage
INSERT INTO @OUTPUT
SELECT DISTINCT o.period, isa.pjt_entity, o.project, 101
 FROM @OUTPUT o
 JOIN PJINDSRCAUD isa (NOLOCK)
   ON isa.project  = o.project
  AND isa.fiscalno <= o.period
  AND isa.amount <> 0
  AND (isa.alloc_batch = @nAlloc_batch
      OR isa.recalc_alloc_batch = @nAlloc_batch)
 WHERE o.pjt_entity = CONVERT(CHAR(32), '%')
   AND o.tskpercent <= @cutOffPercent

-- Remove the initial entry for projects where specific allocated tasks were inserted
DELETE @OUTPUT
 WHERE tskpercent <= @cutOffPercent

-- Return the data
SET NOCOUNT OFF

SELECT project, pjt_entity, period
 FROM @OUTPUT
 ORDER BY project, period, pjt_entity

