Create Procedure pXF100_CFAutoOrdNbr as 
    Select LastOrdNbr from cftFOSetUp

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF100_CFAutoOrdNbr] TO [MSDSL]
    AS [dbo];

