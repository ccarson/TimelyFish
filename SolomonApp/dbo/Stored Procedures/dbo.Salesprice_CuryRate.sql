 /****** Object:  Stored Procedure dbo.Salesprice_CuryRate    Script Date: 4/17/98 10:58:19 AM ******/
/****** Object:  Stored Procedure dbo.Salesprice_CuryRate    Script Date: 4/16/98 7:41:53 PM ******/
Create proc Salesprice_CuryRate @parm1 varchar(4), @parm2 varchar(4),@parm3 varchar(4),@parm4 varchar(4),@parm5 varchar(6) as
	select * from curyrate where ((fromcuryid = @parm1 and tocuryid = @parm2) or
	(fromcuryid = @parm3 and tocuryid = @parm4)) and ratetype = @parm5
	Order By effdate desc



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Salesprice_CuryRate] TO [MSDSL]
    AS [dbo];

