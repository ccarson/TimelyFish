 create proc WS_CheckRegistration @parm1 VARCHAR(5)

WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
select * from vs_RegistDetail 
where RegItem = @parm1 AND Unlocked = 1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_CheckRegistration] TO [MSDSL]
    AS [dbo];

