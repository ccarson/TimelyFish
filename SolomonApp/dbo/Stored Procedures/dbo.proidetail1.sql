 /****** Object:  Stored Procedure dbo.proidetail1    Script Date: 4/17/98 12:50:25 PM ******/
Create Procedure proidetail1 @rptidb smallint           , @rptide smallint           , @lb smallint           , @le smallint            As
Select * from roidetail
Where RI_ID Between @rptidb and @rptide and
linenbr Between @lb and @le
Order by RI_ID, linenbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[proidetail1] TO [MSDSL]
    AS [dbo];

