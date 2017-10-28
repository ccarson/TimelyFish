 Create Proc BOMTran_RefNbr_KitId_LineNbr @parm1 varchar(15), @parm2 varchar(30), @parm3beg smallint, @parm3end smallint as
   Select * from BOMTran where RefNbr = @parm1 and
		   KitId = @parm2 and
           LineNbr between @parm3beg and @parm3end
       order by RefNbr, KitId, LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BOMTran_RefNbr_KitId_LineNbr] TO [MSDSL]
    AS [dbo];

