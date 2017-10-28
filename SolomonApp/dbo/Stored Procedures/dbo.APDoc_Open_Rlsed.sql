 /****** Object:  Stored Procedure dbo.APDoc_Open_Rlsed    Script Date: 4/7/98 12:19:54 PM ******/
Create Procedure APDoc_Open_Rlsed as
Select * from APDoc
where APDoc.DocType  in ('AC', 'AD', 'VO')
and APDoc.OpenDoc  =  1
and APDoc.Rlsed    =  1
and APDoc.Selected = 0
Order by APDoc.DocType, APDoc.RefNbr


