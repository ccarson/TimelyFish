 create procedure  PRTRAN_utran @parm1 varchar (1) , @parm2 varchar (10) , @parm3 varchar (10) , @parm4 varchar (24) , @parm5 smallint , @parm6 varchar (10) , @parm7 varchar (2)   as
update PRTRAN
set pc_status = @parm1
where
PRTRAN.batnbr = @parm2 and
PRTRAN.chkacct = @parm3 and
PRTRAN.chksub = @parm4 and
PRTRAN.linenbr =  @parm5 and
PRTRAN.refnbr =  @parm6 and
PRTRAN.trantype = @parm7


