 Create Procedure pjinvdet_swiptrd @parm1 varchar (10) as
select pjinvdet.*,
	pjpent.*,
	pjproj.*
From pjinvdet
	left outer join pjpent
		on pjinvdet.project = pjpent.project
		and pjinvdet.pjt_entity = pjpent.pjt_entity
	left outer join pjproj
		on pjinvdet.project = pjproj.project
Where pjinvdet.li_type in ('T','R','D', 'A', 'B') and
	pjinvdet.draft_num = @PARM1
order by pjinvdet.draft_num,
	pjinvdet.source_trx_date


