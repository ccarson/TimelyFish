 Create Proc vp58330_DBNav
@HomeUnion varchar(10),
@WorkUnion varchar(10),
@DedId     varchar(10)
As
Select *
From UnionReciprocity
Where HomeUnion LIKE @HomeUnion
      And WorkUnion LIKE @WorkUnion
      And DedId LIKE @DedId
Order by HomeUnion, WorkUnion, DedID


