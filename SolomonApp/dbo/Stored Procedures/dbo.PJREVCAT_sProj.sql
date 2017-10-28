 create procedure PJREVCAT_sProj @parm1 varchar (16)   as
Select * from PJREVCAT
WHERE       pjrevcat.project = @parm1


