 create procedure PJEXPDET_sPAYCDRC  @parm1 varchar (4) , @parm2 smalldatetime , @parm3 smalldatetime, @parm4 varchar (10), @parm5 varchar(10), @parm6 varchar(100), @parm7 varchar (16)
 WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'  as
select PJEXPDET.*,PJEXPHDR.*,PJEXPTYP.*,PJEMPLOY.*
	from PJEXPDET
		left outer join PJEXPTYP
			on PJEXPDET.exp_type = PJEXPTYP.exp_type
		, PJEXPHDR
		left outer join PJEMPLOY
			on PJEXPHDR.employee = PJEMPLOY.employee
	where PJEXPDET.docnbr  = PJEXPHDR.docnbr
		and PJEXPHDR.status_1 = 'P'
		and PJEXPDET.payment_cd = @parm1
		and (PJEXPDET.exp_date >= @parm2 and PJEXPDET.exp_date <= @parm3)
		and PJEXPHDR.employee like @parm4
		and (PJEXPDET.td_id03 like @parm7 and PJEXPDET.td_id03 <> ' ')
		and PJEXPDET.amt_company <> 0
		and PJEXPDET.CpnyId_chrg like @parm5
		and PJEXPDET.CpnyId_chrg in (select cpnyid from dbo.UserAccessCpny(@parm6))
	order by PJEXPDET.exp_date



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJEXPDET_sPAYCDRC] TO [MSDSL]
    AS [dbo];

