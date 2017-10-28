 create procedure PJREVTIM_sProj @parm1 varchar (16)  as
Select * from PJREVTIM
WHERE      project = @parm1


