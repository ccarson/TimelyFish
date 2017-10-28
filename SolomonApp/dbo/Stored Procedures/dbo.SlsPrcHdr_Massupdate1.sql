 /****** Object:  Stored Procedure dbo.SlsPrcHdr_Massupdate1    Script Date: 4/17/98 10:58:19 AM ******/
/****** Object:  Stored Procedure dbo.SlsPrcHdr_Massupdate1    Script Date: 4/16/98 7:41:53 PM ******/
Create Proc SlsPrcHdr_Massupdate1 @parm1 varchar (4) as
     Select * from SlsPrc where CuryID Like @parm1
	order by SlsPrcID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SlsPrcHdr_Massupdate1] TO [MSDSL]
    AS [dbo];

