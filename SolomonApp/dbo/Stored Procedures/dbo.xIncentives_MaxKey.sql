Create Procedure xIncentives_MaxKey as 
    Select Convert(smallint, Max(KeyFld)) from xIncentives

GO
GRANT CONTROL
    ON OBJECT::[dbo].[xIncentives_MaxKey] TO [MSDSL]
    AS [dbo];

