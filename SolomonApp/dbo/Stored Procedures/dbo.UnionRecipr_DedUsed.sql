 Create Proc UnionRecipr_DedUsed
@DedId     varchar(10)
As
Select Top 1 cast(1 As Integer)
From UnionReciprocity
Where DedId LIKE @DedId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[UnionRecipr_DedUsed] TO [MSDSL]
    AS [dbo];

