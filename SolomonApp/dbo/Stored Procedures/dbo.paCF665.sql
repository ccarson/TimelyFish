Create Procedure paCF665 @RI_ID smallint as 
	Delete from wrkLastRation Where RI_ID = @RI_ID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[paCF665] TO [MSDSL]
    AS [dbo];

