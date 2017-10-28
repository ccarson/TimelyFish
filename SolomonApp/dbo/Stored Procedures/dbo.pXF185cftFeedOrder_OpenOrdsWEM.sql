CREATE PROCEDURE [dbo].[pXF185cftFeedOrder_OpenOrdsWEM]
      @parm1 varchar (10)--, --MillID
      --@parm2 varchar (6)--, --ContactID
      --@parm3 smalldatetime, --SchedDate
      --@parm4 smalldatetime --SchedDate
      --@parm3 varchar (6)  --order number
      AS 
      SELECT f.* 
      FROM cftFeedOrder f
      --JOIN MTECHLOADORDERS mt ON f.OrdNbr=mt.[Ticket Comment]
      LEFT JOIN cftFOList l on f.OrdNbr=l.OrdNbr 
      WHERE f.OrdNbr = @parm1  
      --AND ((f.ContactID = @parm2))
      AND Exists (SELECT * FROM cftOrderStatus WHERE Status = f.Status AND RelFlg = 1)
      AND (l.OrdNbr is null)
      --AND CONVERT(datetime, mt.[Load Date],101) BETWEEN @parm3 AND @parm4
      ORDER BY f.ContactID

