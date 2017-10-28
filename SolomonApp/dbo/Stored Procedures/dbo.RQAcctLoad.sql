 /****** Object:  Stored Procedure dbo.RQAcctLoad    Script Date: 9/1/00 9:39:16 AM ******/
CREATE PROCEDURE RQAcctLoad @parm1 varchar(10), @parm2 varchar(10)  AS

select * from Account where active <> 0
and acct >= @parm1
and acct <= @parm2
order by acct


