 CREATE PROCEDURE IRRequirement_DeleteAllRevised AS
	Delete from IRRequirement where  Revised = 1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[IRRequirement_DeleteAllRevised] TO [MSDSL]
    AS [dbo];

