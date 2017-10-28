 Create proc SOHeader_CustID_Open1 @parm1 varchar ( 15) as
          Select * from SOHeader where custid = @parm1
          and Status = "O"
          and UnshippedBalance > 0
          order by Ordnbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOHeader_CustID_Open1] TO [MSDSL]
    AS [dbo];

