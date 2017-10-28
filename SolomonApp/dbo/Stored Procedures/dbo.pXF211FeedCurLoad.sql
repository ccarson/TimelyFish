CREATE   Procedure pXF211FeedCurLoad
	@parmMill As Char(6), @parmdate smalldatetime, @Sort As varchar(1)

--SAFGRID3
AS
Select fl.*, c.*, fo.* 
From cftFeedLoad fl
JOIN cftContact c ON fl.ContactID=c.ContactID AND ContactTypeID='04'
JOIN cftFeedOrder fo on fl.OrdNbr=fo.OrdNbr
Where fl.DateReq=@parmdate AND fo.MillId=@parmMill 
AND fo.CF09=1 
Order by 
CASE WHEN @Sort='L' THEN fl.LoadNbr END ASC,
CASE WHEN @Sort<>'L' THEN c.ContactName END ASC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF211FeedCurLoad] TO [MSDSL]
    AS [dbo];

