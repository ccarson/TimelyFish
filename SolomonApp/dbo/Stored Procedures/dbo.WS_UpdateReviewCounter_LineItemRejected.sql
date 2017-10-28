
Create Procedure WS_UpdateReviewCounter_LineItemRejected
		@parm1 varchar(10),    --docNbr
		@parm2 varchar(10),    --Lupd_user
		@parm3 varchar(8)      --Lupd_prog
AS
     UPDATE p Set te_id06 = (SELECT COUNT(*) 
                               FROM PJEXPDET 
                              WHERE docnbr = @parm1 AND td_id14 IN ('1','R')), 
                  lupd_user = @parm2, lupd_prog = @parm3,lupd_datetime = GetDate(),
                  status_1 = 'R'
       FROM PJEXPHDR p
      WHERE docnbr = @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_UpdateReviewCounter_LineItemRejected] TO [MSDSL]
    AS [dbo];

