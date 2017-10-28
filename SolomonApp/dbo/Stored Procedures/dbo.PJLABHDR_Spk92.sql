 create procedure PJLABHDR_Spk92 @parm1 varchar (10) , @parm2 varchar (30)   as
select * from PJLABHDR
where    employee  =    @parm1 and
le_Key    =    @parm2
order by employee, docnbr desc, le_type, pe_date desc


