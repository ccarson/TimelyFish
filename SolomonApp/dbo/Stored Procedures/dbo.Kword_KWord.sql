 /****** Object:  Stored Procedure dbo.Kword_KWord    Script Date: 4/17/98 12:50:25 PM ******/
/****** Object:  Stored Procedure dbo.Kword_KWord    Script Date: 4/7/98 12:51:20 PM ******/
Create Proc  Kword_KWord @parm1 varchar ( 11) as
       Select * from KWord
           where KWord  LIKE  @parm1
           order by Kword


