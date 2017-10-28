 create procedure PJCOMDET_spk1
as
select * from PJCOMDET
where fiscalno = 'Z'
and system_cd = 'Z'
and batch_id = 'Z'
and detail_num = 9



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCOMDET_spk1] TO [MSDSL]
    AS [dbo];

