Create Procedure CF300p_CFAutoOrdNbr as 
    Select LastOrdNbr from cftFOSetUp

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF300p_CFAutoOrdNbr] TO [MSDSL]
    AS [dbo];

