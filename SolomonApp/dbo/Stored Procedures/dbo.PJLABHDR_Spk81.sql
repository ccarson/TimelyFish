 create procedure PJLABHDR_Spk81 @parm1 varchar (10) ,@parm2 smalldatetime as
select * from PJLABHDR
where    employee = @parm1 and
pe_date = @parm2  and
le_status in ('A','I','C','R','T')
	order by employee


