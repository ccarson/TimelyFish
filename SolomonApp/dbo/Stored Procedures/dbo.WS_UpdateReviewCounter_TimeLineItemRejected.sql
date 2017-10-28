
Create Procedure WS_UpdateReviewCounter_TimeLineItemRejected
		@parm1 varchar(10),    --docNbr
		@parm2 varchar(10),    --Lupd_user
		@parm3 varchar(8)      --Lupd_prog
AS
     UPDATE p Set le_id07 = (SELECT COUNT(*) 
                               FROM PJLABDET 
                              WHERE docnbr = @parm1 AND ld_id17 IN ('1','R')), 
                  lupd_user = @parm2, lupd_prog = @parm3, lupd_datetime = GetDate(),
                  le_status = 'R'
       FROM PJLABHDR p
      WHERE docnbr = @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_UpdateReviewCounter_TimeLineItemRejected] TO [MSDSL]
    AS [dbo];

