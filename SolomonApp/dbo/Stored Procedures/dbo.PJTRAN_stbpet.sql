 create procedure PJTRAN_stbpet
/* project */ @parm1 varchar (16),
/* vendor */  @parm2 varchar (15),
/* acct   */  @parm3 varchar (16),
/* company */ @parm4 varchar (10),
/* task */    @parm5 varchar (32),
/* from date*/@parm6 smalldatetime,
/* to date */ @parm7 smalldatetime,
/* labor cl*/ @parm8 varchar (4),
/* gl sub */  @parm9 varchar (24),
/* employee*/ @parm10 varchar (10),
/* module */  @parm11 varchar (2),
/* billable*/ @parm12 varchar (1)
    as
select * from PJTRAN, pjacct
where
	project = @parm1 and
	vendor_num like @parm2 and
	pjtran.acct like @parm3 and
	cpnyid like @parm4 and
	pjt_entity like @parm5 and
      trans_date >= @parm6 and
      trans_date <= @parm7 and
	tr_id05 like @parm8 and
	gl_subacct like @parm9 and
	employee like @parm10 and
	system_cd like @parm11 and
	tr_status like @parm12 and
      alloc_flag <> 'X'   and
	pjacct.acct = pjtran.acct and
	pjacct.id5_sw in ('L','X')
order by       project, pjt_entity, pjtran.acct, trans_date


