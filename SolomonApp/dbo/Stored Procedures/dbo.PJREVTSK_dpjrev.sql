 create procedure PJREVTSK_dpjrev @parm1 varchar (16) , @parm2 varchar (4)  as
Delete  from PJREVTSK
WHERE       PJREVTSK.project = @parm1 and
PJREVTSK.revid = @parm2


