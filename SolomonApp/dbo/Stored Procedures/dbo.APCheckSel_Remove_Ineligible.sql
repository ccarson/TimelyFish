 create proc APCheckSel_Remove_Ineligible @AccessNbr smallint, @CpnyID char(10)

WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
set nocount on
/*
**  Remove records which are currently on an unreleased
**  manual check batch
*/
DELETE WrkCheckSel
FROM WrkCheckSel, APTran
WHERE AccessNbr = @AccessNbr
AND APTran.AcctDist = 0 and
APTran.Rlsed = 0 and
APTran.DrCr = 'S' AND
APTran.VendId = WrkCheckSel.VendId And
APTran.UnitDesc = WrkCheckSel.RefNbr and
APTran.CostType = WrkCheckSel.DocType

delete from wrkchecksel
WHERE AccessNbr = @AccessNbr AND wrkchecksel.s4future11 = 'VM' AND not exists
(select * from vs_intercompany where
vs_intercompany.FromCompany = @CpnyID and vs_intercompany.ToCompany = wrkchecksel.CpnyID)


