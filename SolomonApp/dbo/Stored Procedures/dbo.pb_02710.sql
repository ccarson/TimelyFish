 CREATE PROCEDURE pb_02710 @RI_ID SMALLINT
AS

    if exists (select S4Future3 from PCSetup where S4Future3 = 'A' or S4Future3 = 'S')
        UPDATE RptRunTime SET ShortAnswer04 = 'TRUE' WHERE RI_ID = @RI_ID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pb_02710] TO [MSDSL]
    AS [dbo];

