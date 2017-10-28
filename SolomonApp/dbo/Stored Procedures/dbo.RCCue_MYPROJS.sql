create Proc RCCue_MYPROJS @parm1 varchar(10) as
select  count(distinct pjproj.project) from PJPROJ left join PJPROJEM on PJPROJ.project = PJPROJEM.project, PJEMPLOY
where PJEMPLOY.user_id = @parm1
and (PJEMPLOY.employee = PJPROJ.manager1 or PJEMPLOY.employee = PJPROJ.manager2 or
     PJEMPLOY.employee = PJPROJEM.employee ) and (PJPROJ.status_pa = 'A' or PJPROJ.status_PA = 'M') 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[RCCue_MYPROJS] TO [MSDSL]
    AS [dbo];

