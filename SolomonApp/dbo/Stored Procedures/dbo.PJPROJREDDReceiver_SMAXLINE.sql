 create procedure PJPROJREDDReceiver_SMAXLINE  @parm1 varchar (2), @parm2 varchar (16)   as
select max(LineNbr) from PJProjEDDReceiver
where    DocType     =  @parm1    AND
		 Project     =  @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJREDDReceiver_SMAXLINE] TO [MSDSL]
    AS [dbo];

