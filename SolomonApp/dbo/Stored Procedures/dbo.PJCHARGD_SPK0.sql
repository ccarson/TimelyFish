 create procedure PJCHARGD_SPK0  @parm1 varchar (10) , @parm2beg int , @parm2end int   as
select * from PJCHARGD
where    batch_id    = @parm1
and    detail_num between  @parm2beg and @parm2end
order by batch_id,
detail_num



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCHARGD_SPK0] TO [MSDSL]
    AS [dbo];

