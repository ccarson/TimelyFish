 create procedure PJREVTSK_sProj @parm1 varchar (16)  as
Select * from PJREVTSK
WHERE       PJREVTSK.project = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJREVTSK_sProj] TO [MSDSL]
    AS [dbo];

