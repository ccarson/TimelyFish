 /****** Object:  Stored Procedure dbo.CATran_RecurId_LineID    Script Date: 4/7/98 12:49:20 PM ******/
create Proc CATran_RecurId_LineID @parm1 varchar ( 10), @parm2 varchar ( 10), @parm3beg smallint, @parm3end smallint as
Select * from CATran
Where bankcpnyid like @parm1
and RecurId like @parm2
and linenbr between @parm3beg and @parm3end
and batnbr = recurid
Order by RecurId, linenbr


