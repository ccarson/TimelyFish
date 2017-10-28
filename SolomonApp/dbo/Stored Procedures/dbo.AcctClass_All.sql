 /****** Object:  Stored Procedure dbo.AcctClass_All    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc  AcctClass_All @parm1 varchar ( 10) as
       Select * from AcctClass
           where ClassId LIKE  @parm1
           order by ClassId


