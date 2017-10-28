 /****** Object:  Stored Procedure dbo.Vendor_All    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure Vendor_CuryID  @parm1 varchar ( 4), @parm2 varchar ( 15) as
Select * from Vendor where (Vendor.CuryID = "" or Vendor.CuryID =@parm1) and VendId like @parm2 order by VendId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Vendor_CuryID] TO [MSDSL]
    AS [dbo];

