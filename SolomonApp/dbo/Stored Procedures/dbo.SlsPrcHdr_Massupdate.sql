 /****** Object:  Stored Procedure dbo.SlsPrcHdr_Massupdate    Script Date: 4/17/98 10:58:19 AM ******/
/****** Object:  Stored Procedure dbo.SlsPrcHdr_Massupdate    Script Date: 4/16/98 7:41:53 PM ******/
Create Proc SlsPrcHdr_Massupdate @parm1 varchar (2), @parm2 varchar (4) as
     Select * from SlsPrc where PriceCat = @parm1 and CuryID = @parm2
	order by PriceCat, SelectFld1, SelectFld2, DiscPrcTyp, CuryID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SlsPrcHdr_Massupdate] TO [MSDSL]
    AS [dbo];

