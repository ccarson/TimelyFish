 Create Procedure pjlabhdr_spurge @parm1 varchar (06) as
select * from pjlabhdr
where pjlabhdr.fiscalno <= @parm1 and le_status = 'P'


