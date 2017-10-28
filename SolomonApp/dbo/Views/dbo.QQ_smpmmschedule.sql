
CREATE VIEW [QQ_smpmmschedule]
AS
SELECT	S.PMType AS [PM ID], H.PMTypeDesc AS [Description], S.ManufID AS [Manufacturer ID], S.ModelID AS [Model ID], S.EstTime AS [Estimated Time], 
		S.Calendar, S.CalendarCode, S.CalendarInterval, D.Season, S.Usage, S.IntervalCode, S.UsageInterval, H.CallTypeId AS [Call Type], 
		H.FaultCodeId AS [Problem Code], H.PMLevel AS [PM Level], H.TechID AS Technician, D.DetailType, D.Invtid AS [Inventory ID], 
		D.Quantity AS [Qty/Hours], D.UnitCost, D.UnitPrice, D.WorkArea, D.WorkDesc AS [Descr], CONVERT(DATE,S.Crtd_DateTime) AS [Create Date], 
		S.Crtd_Prog AS [Create Program], S.Crtd_User AS [Create User], CONVERT(DATE,S.Lupd_DateTime) AS [Last Update Date], 
		S.Lupd_Prog AS [Last Update Program], S.Lupd_User AS [Last Update User], S.MeterTypeID, S.NoteId, S.User1, S.User2, S.User3, S.User4, 
        S.User5, S.User6, CONVERT(DATE,S.User7) AS [User7], CONVERT(DATE,S.User8) AS [User8]
FROM	smPMMSchedule S with (nolock) 
			LEFT OUTER JOIN smPMDetail D with (nolock) ON S.PMType = D.PMType 
			LEFT OUTER JOIN smPMHeader H with (nolock) ON S.PMType = H.PMType

