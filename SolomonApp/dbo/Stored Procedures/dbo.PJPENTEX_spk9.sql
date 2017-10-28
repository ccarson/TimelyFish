 create procedure PJPENTEX_spk9  as
select * from PJPENTEX
where project =  'Z'
	  and pjt_entity  =  'Z'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPENTEX_spk9] TO [MSDSL]
    AS [dbo];

