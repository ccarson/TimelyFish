Create Procedure CF303p_cftSafeFeed_UnProc as 
    Select * from cftSafeFeed Where StatusFlg = 'I' Order by SiteId, BinNbr, PigGroupId

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF303p_cftSafeFeed_UnProc] TO [MSDSL]
    AS [dbo];

