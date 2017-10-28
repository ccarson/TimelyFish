 Create Proc BM11600_Wrk_ISequence_LUpd
	@Screen varchar (5),
	@UserId varchar (47),
	@ISequenceBeg integer,
	@ISequenceEnd integer as
	Select * from BM11600_Wrk where
		LUpd_Prog = @Screen and
		LUpd_User = @UserId and
		ISequence BETWEEN @ISequenceBeg and @ISequenceEnd
	Order by ISequence


