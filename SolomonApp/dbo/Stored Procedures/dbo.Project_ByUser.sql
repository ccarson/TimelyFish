
Create Proc Project_ByUser @parm1 varchar ( 85)
as
select project from PJPROJ, PJEMPLOY
where  PJPROJ.manager1 = PJEMPLOY.employee and PJEMPLOY.user_id = @parm1


GO
GRANT CONTROL
    ON OBJECT::[dbo].[Project_ByUser] TO [MSDSL]
    AS [dbo];

