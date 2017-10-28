 Create Proc Batch_Mod_NotBatType_CpnyID @parm1 varchar ( 2), @parm2 varchar ( 1), @parm3 varchar ( 1), @parm4 varchar (10), @parm5 Varchar (47)
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
if @parm5 = 'SYSADMIN'
       Select * from Batch, Currncy
           where Batch.CuryId = Currncy.CuryId
             and Module  =  @parm1
             and BatType <> @parm2
             and Batch.Status  =  @parm3
             and CpnyID like @parm4
             order by Module, BatNbr
else
          Select * from Batch, Currncy
           where Batch.CuryId = Currncy.CuryId
             and Module  =  @parm1
             and BatType <> @parm2
             and Batch.Status  =  @parm3
             and CpnyID in (select cpnyid from vs_share_secCpny
                            where userid = @parm5 and scrn = '01400' and seclevel >= '3')
             order by Module, BatNbr


