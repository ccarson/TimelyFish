 /****** Object:  Stored Procedure dbo.ItemXRef_Invt  Script Date: 9/14/98 10:58:18 AM ******/
/****** Object:  Stored Procedure dbo.ItemXRef_Invt Script Date: 9/14/98 7:41:52 PM ******/
Create Proc ItemXRef_Invt @parm1 varchar ( 30) as
Select * from ItemXRef where Invtid = @parm1
  Order by AltIDType



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ItemXRef_Invt] TO [MSDSL]
    AS [dbo];

