 /****** Object:  Stored Procedure dbo.Venditem_Invt_Vend_Fscyr                                 ******/
Create proc Venditem_Invt_Vend_Fscyr @parm1 varchar(30), @parm2 varchar(4), @parm3 varchar(15) as
	select * from VendItem where
		InvtID = @parm1 and
		Fiscyr = @parm2 and
		VendID like @parm3
	order by InvtID,VendID,FiscYr


