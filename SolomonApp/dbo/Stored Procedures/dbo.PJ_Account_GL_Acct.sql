 create procedure PJ_Account_GL_Acct @parm1 varchar (16)  as
select count(*) from PJ_Account
where gl_acct = @parm1


