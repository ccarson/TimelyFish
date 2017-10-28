 /****** Object:  Stored Procedure dbo.CARecur_all    Script Date: 4/7/98 12:49:20 PM ******/
Create Proc CARecur_all @parm1 varchar ( 10), @parm2 varchar ( 10) as
    select * from CARecur
     where CpnyID like @parm1
     and RecurId like @parm2
    order by RecurId


