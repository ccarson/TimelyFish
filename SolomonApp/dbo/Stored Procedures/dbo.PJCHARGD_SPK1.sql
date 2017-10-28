 create procedure PJCHARGD_SPK1  @parm1 varchar (10)   as
select * from PJCHARGD
where    batch_id    = @parm1
order by batch_id,
detail_num



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCHARGD_SPK1] TO [MSDSL]
    AS [dbo];

