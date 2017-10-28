 /****** Object:  Stored Procedure dbo.PI_LotSerNbr_Tag    Script Date: 4/17/98 10:58:19 AM ******/
Create Proc PI_LotSerNbr_Tag @Parm1 varchar(10), @Parm2 varchar(10), @Parm3 varchar(30) as
   Select * from lotsermst where siteid = @parm1
	and whseloc = @parm2 and invtid = @parm3
	order by lotsernbr


