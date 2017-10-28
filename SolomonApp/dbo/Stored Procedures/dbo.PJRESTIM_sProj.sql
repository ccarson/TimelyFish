 create procedure PJRESTIM_sProj @parm1 varchar (16)  as
Select * from PJRESTIM
WHERE  PJRESTIM.project    = @parm1


