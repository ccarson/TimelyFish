 /****** Object:  Stored Procedure dbo.SOAddress_CustId_ShipToID    Script Date: 4/7/98 12:30:33 PM ******/
Create Proc SOAddress_CustId_ShipToID @parm1 varchar ( 15), @parm2 varchar ( 10) as
    Select * from SOAddress where CustId = @parm1
                  and ShipToId like @parm2
                  order by CustId, ShipToId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOAddress_CustId_ShipToID] TO [MSDSL]
    AS [dbo];

