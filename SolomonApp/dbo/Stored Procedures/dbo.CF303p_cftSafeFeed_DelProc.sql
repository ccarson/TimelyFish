Create Procedure CF303p_cftSafeFeed_DelProc as 
    Delete from cftSafeFeed Where StatusFlg = 'C'

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF303p_cftSafeFeed_DelProc] TO [MSDSL]
    AS [dbo];

