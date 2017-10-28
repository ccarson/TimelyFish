Create Procedure pXF100_cfvPigGroupInv_PGDNeg @parm1 varchar (10), @parm2 smalldatetime as 
    Select Sum(Qty) from cfvPigGroupInv Where PigGroupId = @parm1 and TranDate <= @parm2 and Qty < 0

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF100_cfvPigGroupInv_PGDNeg] TO [MSDSL]
    AS [dbo];

