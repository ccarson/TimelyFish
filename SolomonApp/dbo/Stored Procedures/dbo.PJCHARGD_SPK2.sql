 create procedure  PJCHARGD_SPK2  @parm1 varchar (10)   as
select * from PJCHARGD, PJPROJ
where    PJCHARGD.batch_id    = @parm1
and PJCHARGD.project = PJPROJ.project
order by batch_id,
detail_num



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCHARGD_SPK2] TO [MSDSL]
    AS [dbo];

