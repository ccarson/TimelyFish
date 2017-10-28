
CREATE VIEW [QQ_pjqueuemsp]
AS
SELECT	Type AS [transaction type], Status AS [status, P=posted, W=wait, X=exception], SLKeyValue AS [SL key value], KeyUID AS [GUID of key value in XREF], 
		CpnyID AS company, CONVERT(DATE,Crtd_DateTime) AS [create date], Crtd_Prog AS [create program], Crtd_User AS [create user], 
		CONVERT(DATE,LUpd_DateTime) AS [last update date], LUpd_Prog AS [last update program], Lupd_User AS [last update user], 
		PjqueueMsp_PK AS [identity key of record]

FROM PJQUEUEMSP WITH (nolock) 

