 /****** Object:  Stored Procedure dbo.CATran_Recurring_Chk    Script Date: 4/7/98 12:49:20 PM ******/
create Proc CATran_Recurring_Chk @parm1 varchar ( 10) as
select * from CATran
where Recurid <> ''
and PerPost = ''
and Module = ''
and Refnbr = @parm1
and Rlsed = 0


