 /****** Object:  Stored Procedure dbo.ARRev_PV_Custid_Refnbr    Script Date: 4/7/98 12:30:33 PM ******/
Create Proc ARRev_PV_Custid_Refnbr @parm1 varchar(10), @parm2 varchar(15), @parm3 varchar(10) AS
Select * from ARDoc Where CpnyId = @parm1
and CustID = @parm2
and refnbr like @parm3
and doctype in ('PA', 'CM')
and Rlsed = 1
and OpenDoc = 0
and noprtstmt = 0
Order by CustID, Refnbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARRev_PV_Custid_Refnbr] TO [MSDSL]
    AS [dbo];

