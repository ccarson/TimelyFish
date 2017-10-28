 Create Procedure Fetch_CurySym
 @Parm1 varchar (4) as

select CurySym
From Currncy
Where CuryID = @Parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[Fetch_CurySym] TO [MSDSL]
    AS [dbo];

