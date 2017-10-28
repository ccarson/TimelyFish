
/****** Object:  View [dbo].[vw_AcctCode]    Script Date: 09/26/2011 08:37:49 ******/
Create View [dbo].[vw_AcctCode]
As
Select Distinct (Acctlist.acct+AcctList.Sub) as 'acct_code' , Acctlist.CpnyID, 
Account.Active 'AcctActive', SubAcct.Active 'SubActive', vw_acctSub.Active 'AcctSubActive', Account.* from (

    SELECT DISTINCT A.acct, A.Sub, A.CpnyID
    FROM         AcctHist A
    UNION
    SELECT DISTINCT A.acct, A.Sub ,A.CpnyID
    FROM         GLTran A ) AcctList 
	LEFT OUTER JOIN Account on Account.Acct = Acctlist.Acct
	LEFT OUTER JOIN SubAcct on subacct.sub = Acctlist.Sub
	LEFT OUTER JOIN vw_acctsub on vw_acctsub.Acct = Acctlist.Acct AND vw_acctsub.Sub = Acctlist.Sub AND vw_acctsub.CpnyID = AcctList.CpnyID

