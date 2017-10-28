 Create Proc BOMDoc_RefNbr_Status @parm1 varchar ( 15) as
    Select * from BOMDoc where Status <> 'V' and RefNbr like @parm1 order by RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BOMDoc_RefNbr_Status] TO [MSDSL]
    AS [dbo];

