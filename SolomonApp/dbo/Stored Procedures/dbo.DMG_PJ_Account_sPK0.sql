 create procedure DMG_PJ_Account_sPK0 @parm1 varchar (10)  
	as
select * from PJ_Account
where gl_acct  like  @parm1
order by gl_acct

if @@ROWCOUNT = 0 begin
	return 0 		-- Failure
end
else
	return 1		-- Success




GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_PJ_Account_sPK0] TO [MSDSL]
    AS [dbo];

