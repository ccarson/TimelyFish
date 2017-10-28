
create procedure PJPROJ_PM_ID15_w  @parm1 varchar (16)  as
select PM_ID15 From PJPROJEX
where
project = @parm1


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJ_PM_ID15_w] TO [MSDSL]
    AS [dbo];

