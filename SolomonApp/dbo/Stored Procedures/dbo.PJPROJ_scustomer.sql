 create procedure PJPROJ_scustomer @parm1 varchar (15) , @parm2 varchar (16),  @parm3 varchar (10)  as
select * from PJPROJ
where customer = @parm1    and
project like @parm2  and
cpnyid = @parm3 and
(contract_type = 'FPR' OR
contract_type = 'FPW' OR
contract_type = 'TMR' OR
contract_type = 'TMW' OR
contract_type = 'CPR' OR
contract_type = 'CPW')



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJ_scustomer] TO [MSDSL]
    AS [dbo];

