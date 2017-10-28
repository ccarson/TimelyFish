 create procedure PJREVCAT_dpjrev @parm1 varchar (16) , @parm2 varchar (4)  as
Delete  from PJREVCAT
WHERE       pjrevcat.project = @parm1 and
pjrevcat.revid = @parm2


