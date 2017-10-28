 /****** Object:  Stored Procedure dbo.roiextra    Script Date: 4/17/98 12:50:25 PM ******/
/****** Object:  Stored Procedure dbo.roiextra    Script Date: 4/7/98 12:56:04 PM ******/
Create Procedure roiextra @rptriid smallint            As
Select * from rptextra
Where RI_ID = @rptriid
Order by RI_ID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[roiextra] TO [MSDSL]
    AS [dbo];

