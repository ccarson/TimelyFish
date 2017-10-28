 Create Proc BOMDoc_RefNbr @parm1 varchar ( 15) as
    Select * from BOMDoc where RefNbr like @parm1 order by RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BOMDoc_RefNbr] TO [MSDSL]
    AS [dbo];

