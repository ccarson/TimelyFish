 Create Procedure PP_01270 @Company Varchar ( 10)
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
Begin Tran

Delete from VS_SubXRef where cpnyid = @Company

Insert into VS_SubXRef (Active, CpnyId , Descr, Sub, User1, User2, User3, User4)
         Select Active, @company, Descr, Sub, User1, User2, User3, User4 from Subacct
Commit



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PP_01270] TO [MSDSL]
    AS [dbo];

