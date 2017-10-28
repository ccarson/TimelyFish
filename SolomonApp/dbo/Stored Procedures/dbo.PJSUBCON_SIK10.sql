 create procedure PJSUBCON_SIK10  
 @parm1 varchar (15),
 @parm2 varchar (4)
  as
select * from PJSUBCON
where    vendid      = @parm1
and		 curyId		 = @parm2
order by vendid, subcontract



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJSUBCON_SIK10] TO [MSDSL]
    AS [dbo];

