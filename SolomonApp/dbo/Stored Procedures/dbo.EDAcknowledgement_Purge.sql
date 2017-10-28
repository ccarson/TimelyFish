 CREATE Proc EDAcknowledgement_Purge @SolomonDateFrom smalldatetime, @SolomonDateTo smalldatetime As
Delete From EDAcknowledgement Where AckStatus = 1 And SolomonDate >= @SolomonDateFrom And
SolomonDate <= @SolomonDateTo


