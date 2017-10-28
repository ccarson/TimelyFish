CREATE   Procedure pXF211MaxLoadID
	@parmdate smalldatetime
AS
Select Max(Convert(Integer,LoadNbr)) 
From cftFeedLoad fl
Where fl.DateReq=@parmdate 


