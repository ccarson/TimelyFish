 Create Procedure pjcosubh_sOpen @PARM1 varchar (16) as
select * from pjcosubh
Where
project = @PARM1 and
status1 <> 'A' and status1 <> 'C'


