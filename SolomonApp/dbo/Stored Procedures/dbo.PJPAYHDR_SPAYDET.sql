 create procedure PJPAYHDR_SPAYDET  @parm1 varchar (16) as
select PJPAYHDR.* from PJPAYDET, PJPAYHDR
where
PJPAYDET.project       =    @parm1
and  PJPAYDET.project       =    PJPAYHDR.project
and  PJPAYDET.subcontract   =    PJPAYHDR.subcontract
and  PJPAYDET.payreqnbr     =    PJPAYHDR.payreqnbr
and  PJPAYHDR.status1     <> 'P'


