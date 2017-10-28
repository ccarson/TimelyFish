 Create Proc PIdetail_Count
   @Parm1 Varchar(10)
as

Select Count(*)
   from PIDetail
   where PIID = @Parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PIdetail_Count] TO [MSDSL]
    AS [dbo];

