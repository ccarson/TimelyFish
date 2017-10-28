 create proc Checkfor_unreleased_ARBatch AS
select * from batch where rlsed = 0 and Status <> 'V' and module = "AR"


