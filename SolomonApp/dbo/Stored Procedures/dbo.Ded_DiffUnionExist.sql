 Create Proc Ded_DiffUnionExist
@DedId     varchar(10),
@CalYr     varchar(4),
@UnionCd   varchar(10)
As
Select Top 1 cast(1 As Integer)
From Deduction
Where DedId=@DedId And CalYr<>@CalYr And Union_Cd<>@UnionCd


