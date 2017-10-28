 create procedure PJREVCAT_dpjrevt @parm1 varchar (16) , @parm2 varchar (4) , @parm3 varchar (32)  as
Delete  from PJREVCAT
WHERE       project = @parm1 and
revid = @parm2 and
pjt_entity = @parm3


