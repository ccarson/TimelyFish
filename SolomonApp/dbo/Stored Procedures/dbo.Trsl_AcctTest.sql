 Create Procedure Trsl_AcctTest @parm1 varchar ( 10), @parm2 varchar ( 10), @parm3 varchar ( 24) As
Select * from FSDefDet
Where TrslId = @parm1
and @parm2 between FSDefDet.BegAcctRange and FSDefDet.EndAcctRange
and @parm3 between FSDefDet.BegSubRange and FSDefDet.EndSubRange
Order by TrslId, BegAcctRange, BegSubRange



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Trsl_AcctTest] TO [MSDSL]
    AS [dbo];

