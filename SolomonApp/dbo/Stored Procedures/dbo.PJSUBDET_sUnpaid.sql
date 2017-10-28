 create procedure PJSUBDET_sUnpaid  @parm1 varchar (16) , @parm2 varchar (16)   as
select * from PJSUBDET
where
PJSUBDET.project       =    @parm1 and
PJSUBDET.subcontract   =    @parm2 and
PJSUBDET.prior_request_amt < PJSUBDET.revised_amt



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJSUBDET_sUnpaid] TO [MSDSL]
    AS [dbo];

