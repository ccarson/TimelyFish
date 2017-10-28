 /****** Object:  Stored Procedure dbo.proiheader1    Script Date: 4/17/98 12:50:25 PM ******/
Create Procedure proiheader1 @rptidb smallint           ,@rptide smallint            As
Select * from roiheader
Where RI_ID Between @rptidb and @rptide
Order by RI_ID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[proiheader1] TO [MSDSL]
    AS [dbo];

