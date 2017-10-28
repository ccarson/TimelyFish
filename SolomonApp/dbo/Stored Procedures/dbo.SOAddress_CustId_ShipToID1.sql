 /****** Object:  Stored Procedure dbo.SOAddress_CustId_ShipToID1    Script Date: 4/7/98 12:30:33 PM ******/
Create Proc SOAddress_CustId_ShipToID1 @parm1 varchar ( 15), @parm2 varchar ( 10) as
    Select * from SOAddress where CustId = @parm1
                  and ShipToId like @parm2
                  order by CustId, ShipToId DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOAddress_CustId_ShipToID1] TO [MSDSL]
    AS [dbo];

