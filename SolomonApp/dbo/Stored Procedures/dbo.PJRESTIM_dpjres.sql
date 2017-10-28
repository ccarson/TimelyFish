 create procedure PJRESTIM_dpjres @parm1 varchar (16) , @parm2 varchar (32) , @parm3 varchar (16)  as
DELETE from PJRESTIM
WHERE       PJRESTIM.project    = @parm1 and
PJRESTIM.pjt_entity = @parm2 and
PJRESTIM.acct       = @parm3


