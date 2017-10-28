 create procedure PJSUBCON_SIK11  
 @parm1 varchar (15),
 @parm2 varchar (4)   
 as
select * from PJSUBCON
where    vendid      = @parm1
and		 curyId      = @parm2
and    status_sub  <> 'C'
and    status_sub  <> 'D'
order by vendid, subcontract



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJSUBCON_SIK11] TO [MSDSL]
    AS [dbo];

