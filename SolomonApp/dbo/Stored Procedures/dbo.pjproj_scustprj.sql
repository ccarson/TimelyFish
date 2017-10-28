 create procedure pjproj_scustprj @parm1 varchar (15) , @parm2 varchar (16),  @parm3 varchar (10)   as
select * from pjproj
where customer like @parm1
and project like @parm2
and cpnyid = @parm3
and (contract_type = 'FPR' OR
contract_type = 'FPW' OR
contract_type = 'TMR' OR
contract_type = 'TMW' OR
contract_type = 'CPR' OR
contract_type = 'CPW')



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjproj_scustprj] TO [MSDSL]
    AS [dbo];

