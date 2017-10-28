 Create Proc vp58330_DedPV
@HomeUnion varchar(10),
@WorkUnion varchar(10),
@CalYr     varchar(4),
@DedId     varchar(10)
As
Select *
From Deduction
Where Union_CD in (@HomeUnion, @WorkUnion)
      And CalYr LIKE @CalYr
      And DedId LIKE @DedId
Order by DedId


