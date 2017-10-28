 create procedure  PRTRAN_uuser4 @parm1 varchar (10) , @parm2 varchar (10) , @parm3 varchar (24) , @parm4 varchar (10) , @parm5 varchar (2) , @parm6 smallint     as
update PRTRAN
set user4 = 1
where
PRTRAN.batnbr = @parm1 and
PRTRAN.chkacct = @parm2 and
PRTRAN.chksub = @parm3 and
PRTRAN.refnbr =  @parm4 and
PRTRAN.trantype = @parm5 and
PRTRAN.linenbr =  @parm6


