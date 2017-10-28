 create procedure PJLABHDR_Sspv @parm1 varchar (10) , @parm2 varchar (10)   as
select * from PJLABHDR
where    employee like @parm1 and
Docnbr Like @parm2 and
le_status <> 'X'
order by employee, docnbr desc, le_type, pe_date desc


