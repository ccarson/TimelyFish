 Create Proc BOMTran_RefNbr_LineNbr @parm1 varchar ( 15), @parm2beg smallint, @parm2end smallint as
   	Select * from BOMTran where
		RefNbr = @parm1 and
		BOMLineNbr between
       		@parm2beg and @parm2end order by RefNbr, BOMLineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BOMTran_RefNbr_LineNbr] TO [MSDSL]
    AS [dbo];

