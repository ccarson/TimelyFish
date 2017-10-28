 Create Procedure IRBucket_Def as
Select * from IRBucket order by DateStart



GO
GRANT CONTROL
    ON OBJECT::[dbo].[IRBucket_Def] TO [MSDSL]
    AS [dbo];

