 create procedure PJREVHDR_dpjrev @parm1 varchar (16) , @parm2 varchar (4)  as
Delete  from PJREVHDR
WHERE       PJREVHDR.project = @parm1 and
PJREVHDR.revid = @parm2


