 create procedure PJPAYHDR_sdupinv  @parm1 varchar (15) , @parm2 varchar (15) , @parm3 varchar (4)   as
select * from PJPAYHDR, PJSUBCON
where
PJPAYHDR.project       =    PJSUBCON.project and
PJPAYHDR.subcontract   =   PJSUBCON.subcontract and
PJPAYHDR.vendor_invref = @parm1 and
PJSUBCON.vendid = @parm2 and
PJPAYHDR.payreqnbr <> @parm3
order by PJPAYHDR.project, PJPAYHDR.subcontract, PJPAYHDR.payreqnbr


