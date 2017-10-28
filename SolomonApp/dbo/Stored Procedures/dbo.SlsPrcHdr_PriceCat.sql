 /****** Object:  Stored Procedure dbo.SlsPrcHdr_PriceCat    Script Date: 4/17/98 10:58:19 AM ******/
/****** Object:  Stored Procedure dbo.SlsPrcHdr_PriceCat    Script Date: 4/16/98 7:41:53 PM ******/
Create Proc SlsPrcHdr_PriceCat @parm1 varchar (2), @parm2 varchar (30), @parm3 varchar (30), @parm4 varchar(1) as
		Select * from SlsPrc where PriceCat = @parm1 and SelectFld1 = @parm2 and
			SelectFld2 = @parm3 and DiscPrcTyp LIKE @parm4
			order by PriceCat, SelectFld1, SelectFld2, DiscPrcTyp



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SlsPrcHdr_PriceCat] TO [MSDSL]
    AS [dbo];

