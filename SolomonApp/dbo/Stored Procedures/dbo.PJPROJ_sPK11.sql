 create procedure PJPROJ_sPK11 @parm1 varchar (16)  as
select * from PJPROJ
where project = @parm1
and (contract_type = 'FPR' OR
contract_type = 'FPW' OR
contract_type = 'TMR' OR
contract_type = 'TMW' OR
contract_type = 'CPR' OR
contract_type = 'CPW')
order by project

