 Create Procedure IRComponent_OnKit @KitId VarChar(30) As
Select * from Component where KitId like @KitID Order BY LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[IRComponent_OnKit] TO [MSDSL]
    AS [dbo];

