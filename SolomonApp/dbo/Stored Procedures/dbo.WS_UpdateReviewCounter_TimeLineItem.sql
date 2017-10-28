
Create Procedure WS_UpdateReviewCounter_TimeLineItem
		@parm1 varchar(10),    --docNbr
		@parm2 varchar(10),    --Lupd_user
		@parm3 varchar(8)      --Lupd_prog
AS
     UPDATE p Set le_id07 = (SELECT COUNT(*) 
                               FROM PJLABDET 
                              WHERE docnbr = @parm1 AND ld_id17 IN ('1','R')), 
                  lupd_user = @parm2, lupd_prog = @parm3, lupd_datetime = GetDate()
       FROM PJLABHDR p
      WHERE docnbr = @parm1
	   -- Return the number of line items still needing review.
	  SELECT COUNT(*) AS ReviewCounter
      FROM PJLABDET 
      WHERE docnbr = @parm1 AND ld_id17 IN ('1','R')

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_UpdateReviewCounter_TimeLineItem] TO [MSDSL]
    AS [dbo];

