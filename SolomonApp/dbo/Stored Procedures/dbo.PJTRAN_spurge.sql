 create procedure PJTRAN_spurge @parm1 varchar (16) , @parm2 varchar (6) as
select * from PJTRAN
where
project = @parm1 and
fiscalNo >= @parm2 and
tr_status <> 'S'


