 create procedure PJPAYHDR_Sbatref  @parm1 varchar (10) , @parm2 varchar (10)   as
select * from PJPAYHDR
where
PJPAYHDR.batnbr       =    @parm1 and
PJPAYHDR.refnbr   =    @parm2
order by PJPAYHDR.batnbr, PJPAYHDR.refnbr


