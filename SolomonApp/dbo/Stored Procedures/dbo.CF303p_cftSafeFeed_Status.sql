

CREATE  Procedure CF303p_cftSafeFeed_Status as 
        UPDATE cftSafeFeed 
	Set StatusFlg = 'P'
	Where StatusFlg = 'O'
        

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF303p_cftSafeFeed_Status] TO [MSDSL]
    AS [dbo];

