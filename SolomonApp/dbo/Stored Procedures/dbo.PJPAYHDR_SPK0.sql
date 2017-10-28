 create procedure PJPAYHDR_SPK0  @parm1 varchar (16) , @parm2 varchar (16) , @parm3 varchar (4)   as
select * from PJPAYHDR
where
PJPAYHDR.project       =    @parm1 and
PJPAYHDR.subcontract   =    @parm2 and
PJPAYHDR.payreqnbr    =   @parm3
order by PJPAYHDR.project, PJPAYHDR.subcontract, PJPAYHDR.payreqnbr


