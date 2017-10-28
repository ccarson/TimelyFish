 CREATE PROCEDURE delete_pr_details
@parm1 varchar(4),
@parm2 smallint,
@parm3 varchar(6),
@parm4 varchar(4),
@parm5 smallint,
@parm6 smallint
WITH RECOMPILE
AS

-- 07/28/99  VAD  DE#209199 & 209198: Initial design
-- 09|07|00  MAP  DE 214454 - Deduction History enhancement. Added deletion of deduction history.
-- 09|27|00  MAP  DE 210930 - MC Payroll enhancement. Delete DeductCpny records.
-- 06/25/02  VAL  DE#229983 - Enhanced Timesheet Entry enhancement. Delete PRBatInfo records.
-- 02|18|03  MAP  DE#231913 - Don't delete PRTrans with trantype=CA.
-- 02|19|04  MAP  DE#234391 - Added screen number 02635 to batch delete statement.
--
-- Parameters:
-- @parm1 - calendar year to delete checks from
-- @parm2 - calendar quarter to delete checks from
-- @parm3 - fiscal period to delete timesheets from
-- @parm4 - calendar year to delete employee history from
-- @parm5 - keep checks for reconciliation
-- @parm6 - calendar year to delete deduction,exemption,prtable history.

SET NOCOUNT ON

-- Create temporary worktable.
-- It will store the list of batches subject to delete

IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id = object_id(N'[tempdb]..[#BatchesToDel]') AND type = 'U')
    DROP TABLE #BatchesToDel

CREATE TABLE #BatchesToDel (BatNbr char(10) NOT NULL)

-- ** Part 1. Delete payroll checks

-- Delete expired checks from PRDoc
-- Check is considered expired if its calendar year/quarter is less or equal to values passed in @parm1/@parm2 parameters
-- Also do not delete document if it belongs to unreleased or partially released batches.
-- Deletion logic also depends on whether or not the "keep checks for reconciliation" option was selected in PR Setup screen
IF @parm5 = 0
        DELETE PRDoc
        WHERE (CalYr = @parm1 AND CalQtr <= @parm2 OR CalYr < @parm1) AND NOT EXISTS
            (SELECT * FROM Batch WHERE Batch.BatNbr = PRDoc.BatNbr AND Module = 'PR' AND Status NOT IN ('D','P','U','V'))
ELSE
        DELETE PRDoc
        WHERE (CalYr = @parm1 AND CalQtr <= @parm2 OR CalYr < @parm1) AND Status IN ('C', 'V') AND NOT EXISTS
            (SELECT * FROM Batch WHERE Batch.BatNbr = PRDoc.BatNbr AND Module = 'PR' AND Status NOT IN ('D','P','U','V'))

-- Also delete all void documents
DELETE PRDoc FROM PRDoc, Batch
WHERE PRDoc.BatNbr = Batch.BatNbr AND Module = 'PR' AND Batch.Status IN ('D','V') AND EditScrnNbr IN ('02040','02070','02630','02635')

-- Delete batches which corresponding PRDoc records were removed from database.
DELETE Batch
WHERE Module = 'PR' AND EditScrnNbr IN('02040','02070','02630','02635')
AND NOT EXISTS (SELECT * FROM PRDoc WHERE PRDoc.BatNbr = Batch.BatNbr)

-- Delete stub details which corresponding PRDoc records were removed from database.
DELETE StubDetail
WHERE NOT EXISTS (SELECT * FROM PRDoc WHERE PRDoc.Acct = StubDetail.Acct AND PRDoc.Sub = StubDetail.Sub AND PRDoc.ChkNbr = StubDetail.ChkNbr AND PRDoc.DocType = StubDetail.DocType)

-- Delete prtrans which corresponding PRDoc records were removed from database.
DELETE PRTran
WHERE TimeShtFlg = 0 AND Type_ <> 'RC' AND TranType <> 'CA' AND
      NOT EXISTS (SELECT * FROM PRDoc WHERE PRDoc.Acct = PRTran.ChkAcct AND PRDoc.Sub = PRTran.ChkSub AND PRDoc.ChkNbr = PRTran.RefNbr AND PRDoc.DocType = PRTran.TranType)

-- ** Part 2. Delete check reconciliation details

-- Create the list of reconciliation batches subject to delete.
INSERT INTO #BatchesToDel
SELECT DISTINCT BatNbr FROM PRTran WHERE TimeShtFlg = 0 AND Type_ = 'RC'

-- The purpose of this statement is to prevent batch form deletion if it referes to any existing check
DELETE #BatchesToDel
WHERE EXISTS (SELECT * FROM PRDoc, PRTran WHERE PRTran.BatNbr = #BatchesToDel.BatNbr AND PRDoc.Acct = PRTran.ChkAcct AND PRDoc.Sub = PRTran.ChkSub AND PRDoc.ChkNbr = PRTran.RefNbr AND PRDoc.DocType = PRTran.TranType AND PRTran.TimeShtFlg = 0 AND PRTran.Type_ = 'RC')

DELETE PRTran FROM PRTran, #BatchesToDel
WHERE TimeShtFlg = 0 AND Type_ = 'RC' AND PRTran.BatNbr = #BatchesToDel.BatNbr

DELETE Batch
WHERE Module = 'PR' AND EditScrnNbr = '02050'
AND NOT EXISTS (SELECT * FROM PRTran WHERE PRTran.BatNbr = Batch.BatNbr AND TimeShtFlg = 0 AND Type_ = 'RC')

-- Clean up the work table
TRUNCATE TABLE #BatchesToDel

-- ** Part 3. Delete timesheets

-- Create the list of expired timesheets
INSERT INTO #BatchesToDel
SELECT DISTINCT BatNbr FROM PRTran
WHERE TimeShtFlg = 1 AND Rlsed = 1 AND PerPost <= @parm3

-- Exclude timesheets that belong to unreleased batches
DELETE #BatchesToDel FROM #BatchesToDel, Batch
WHERE Batch.BatNbr = #BatchesToDel.BatNbr AND Module = 'PR' AND Status <> 'C'

-- Create clustered index on worktable. It is done to improve performance during further operations.
CREATE UNIQUE CLUSTERED INDEX BatchesToDel0 ON #BatchesToDel (BatNbr)

-- Delete timesheet details from PRTran table
DELETE PRTran FROM PRTran, #BatchesToDel
WHERE TimeShtFlg = 1 AND Rlsed = 1 AND TranType <> 'CA' AND
      PerPost <= @parm3 AND PRTran.BatNbr = #BatchesToDel.BatNbr

-- Delete timesheet batches
DELETE Batch FROM Batch, #BatchesToDel
WHERE Module = 'PR' AND Batch.BatNbr = #BatchesToDel.BatNbr

-- DE#229983 - Delete PRBatInfo records.
DELETE PRBatInfo FROM PRBatInfo, #BatchesToDel
WHERE PRBatInfo.BatNbr=#BatchesToDel.BatNbr

-- Drop the worktable
DROP TABLE #BatchesToDel

-- ** Part 4. Delete employee history

-- Delete history records
DELETE EarnDed WHERE CalYr <= @parm4
DELETE EarnDedAudt WHERE CalYr <= @parm4
DELETE EmployeePayAudt WHERE CalYr <= @parm4
DELETE W2Federal WHERE CalYr <= @parm4
DELETE W2StateLocal WHERE CalYr <= @parm4

-- DE 214454: Deduction History enhancement.
Delete Deduction Where CalYr <= @parm6
                   and NOT exists (Select EarnDedId
                                     From EarnDed
                                    Where EarnDed.CalYr     = Deduction.CalYr
                                      and EarnDed.EarnDedId = Deduction.DedId
                                      and EarnDed.EDType    = 'D')
                   and NOT exists (Select EarnDedId
                                     From PRTran
                                    Where PRTran.Type_     like 'D%'
                                      and PRTran.EarnDedId = Deduction.DedId
                                      and PRTran.CalYr     = Deduction.CalYr)
Delete DeductionAudt Where CalYr <= @parm6
                   and NOT exists (Select EarnDedId
                                     From EarnDed
                                    Where EarnDed.CalYr     = DeductionAudt.CalYr
                                      and EarnDed.EarnDedId = DeductionAudt.DedId
                                      and EarnDed.EDType    = 'D')
                   and NOT exists (Select EarnDedId
                                     From PRTran
                                    Where PRTran.Type_     like 'D%'
                                      and PRTran.EarnDedId = DeductionAudt.DedId
                                      and PRTran.CalYr     = DeductionAudt.CalYr)
Delete ExmptCredit Where CalYr <= @parm6 and NOT exists (Select DedId From Deduction Where Deduction.DedId = ExmptCredit.DedId and Deduction.CalYr = ExmptCredit.CalYr)
Delete ExmptCreditAudt Where CalYr <= @parm6 and NOT exists (Select DedId From Deduction Where Deduction.DedId = ExmptCreditAudt.DedId and Deduction.CalYr = ExmptCreditAudt.CalYr)
Delete PRTableHeader Where CalYr <= @parm6 and NOT exists (Select DedId From Deduction Where (AllId = PayTblId or HeadId = PayTblId or JointId = PayTblId or MarriedId = PayTblId or SingleId = PayTblId) and Deduction.CalYr = PRTableHeader.CalYr) and NOT exists (Select ExmptCrId From ExmptCredit Where ExmptCredit.PayTblId = PRTableHeader.PayTblId and ExmptCredit.CalYr = PRTableHeader.CalYr)
Delete PRTableHeaderAudt Where CalYr <= @parm6 and NOT exists (Select DedId From Deduction Where (AllId = PayTblId or HeadId = PayTblId or JointId = PayTblId or MarriedId = PayTblId or SingleId = PayTblId) and Deduction.CalYr = PRTableHeaderAudt.CalYr) and NOT exists (Select ExmptCrId From ExmptCredit Where ExmptCredit.PayTblId = PRTableHeaderAudt.PayTblId and ExmptCredit.CalYr = PRTableHeaderAudt.CalYr)
Delete PRTableDetail Where CalYr <= @parm6 and NOT exists (Select Paytblid From PRTableHeader Where PRTableHeader.Paytblid = PRTableDetail.Paytblid and PRTableHeader.CalYr = PRTableDetail.CalYr)
Delete PRTableDetailAudt Where CalYr <= @parm6 and NOT exists (Select Paytblid From PRTableHeaderAudt Where PRTableHeaderAudt.Paytblid = PRTableDetailAudt.Paytblid and PRTableHeaderAudt.CalYr = PRTableDetailAudt.CalYr)

-- DE 210930: MC Payroll enhancement.
Delete DeductCpny Where CalYr <= @parm6 and NOT exists (Select DedId From Deduction Where Deduction.DedId = DeductCpny.DedId and Deduction.CalYr = DeductCpny.CalYr)
Delete DeductCpnyAudt Where CalYr <= @parm6 and NOT exists (Select DedId From Deduction Where Deduction.DedId = DeductCpnyAudt.DedId and Deduction.CalYr = DeductCpnyAudt.CalYr)

-- ** Part 5. Delete any remaining void batch
DELETE Batch WHERE Module = 'PR' AND Status = 'V'

SET NOCOUNT OFF


