CREATE   Procedure pXF211FeedLoadID
	@parmLoad As Char(20),@parmdate smalldatetime

AS
Select fl.* 
From cftFeedLoad fl
Where fl.DateReq=@parmdate AND fl.LoadNbr=@parmLoad  


