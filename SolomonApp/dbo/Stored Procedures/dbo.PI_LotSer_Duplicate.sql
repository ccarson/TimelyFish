 /****** Object:  Stored Procedure dbo.PI_LotSer_Duplicate    Script Date: 4/17/98 10:58:19 AM ******/
Create Proc PI_LotSer_Duplicate @parm1 varchar(30), @Parm2 varchar(25), @parm3 varchar(10), @parm4 varchar(10) as
select * from lotsermst
where invtid = @parm1
  And lotsernbr = @parm2
  And siteid = @parm3
  And Whseloc = @parm4


