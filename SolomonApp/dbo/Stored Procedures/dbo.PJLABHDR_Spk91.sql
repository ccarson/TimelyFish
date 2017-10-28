 create procedure PJLABHDR_Spk91 @parm1 varchar (10) , @parm2 varchar (10)   as
select * from PJLABHDR
where    employee  =    @parm1 and
Docnbr    Like @parm2 and
le_Status =    'P'
order by employee, docnbr desc, le_type, pe_date desc


