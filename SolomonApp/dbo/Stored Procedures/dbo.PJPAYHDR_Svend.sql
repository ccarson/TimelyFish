 create procedure PJPAYHDR_Svend  @parm1 varchar (15)   as
select * from PJPAYHDR
where
PJPAYHDR.vendid   =    @parm1 and
PJPAYHDR.status1  <> 'P'


