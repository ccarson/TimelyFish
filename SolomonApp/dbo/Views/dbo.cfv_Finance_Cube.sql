


CREATE VIEW [dbo].[cfv_Finance_Cube]
AS
SELECT
H.Sub,
H.FiscYr,
H.Acct,
H.BegBal,
H.CpnyID,
H.LastClosePerNbr,
Case when ((H.Acct between '42100' and '43900') or (H.Acct = '44950'))
then H.PtdBal00 * -1 else H.PtdBal00 end PtdBal00,
Case when ((H.Acct between '42100' and '43900') or (H.Acct = '44950'))
then H.PtdBal01 * -1 else H.PtdBal01 end PtdBal01,
Case when ((H.Acct between '42100' and '43900') or (H.Acct = '44950'))
then H.PtdBal02 * -1 else H.PtdBal02 end PtdBal02,
Case when ((H.Acct between '42100' and '43900') or (H.Acct = '44950'))
then H.PtdBal03 * -1 else H.PtdBal03 end PtdBal03,
Case when ((H.Acct between '42100' and '43900') or (H.Acct = '44950'))
then H.PtdBal04 * -1 else H.PtdBal04 end PtdBal04,
Case when ((H.Acct between '42100' and '43900') or (H.Acct = '44950'))
then H.PtdBal05 * -1 else H.PtdBal05 end PtdBal05,
Case when ((H.Acct between '42100' and '43900') or (H.Acct = '44950'))
then H.PtdBal06 * -1 else H.PtdBal06 end PtdBal06,
Case when ((H.Acct between '42100' and '43900') or (H.Acct = '44950'))
then H.PtdBal07 * -1 else H.PtdBal07 end PtdBal07,
Case when ((H.Acct between '42100' and '43900') or (H.Acct = '44950'))
then H.PtdBal08 * -1 else H.PtdBal08 end PtdBal08,
Case when ((H.Acct between '42100' and '43900') or (H.Acct = '44950'))
then H.PtdBal09 * -1 else H.PtdBal09 end PtdBal09,
Case when ((H.Acct between '42100' and '43900') or (H.Acct = '44950'))
then H.PtdBal10 * -1 else H.PtdBal10 end PtdBal10,
Case when ((H.Acct between '42100' and '43900') or (H.Acct = '44950'))
then H.PtdBal11 * -1 else H.PtdBal11 end PtdBal11,
Case when ((H.Acct between '42100' and '43900') or (H.Acct = '44950'))
then H.PtdBal12 * -1 else H.PtdBal12 end PtdBal12,
Case when ((H.Acct between '42100' and '43900') or (H.Acct = '44950'))
then H.YtdBal00 * -1 else H.YtdBal00 end YtdBal00,
Case when ((H.Acct between '42100' and '43900') or (H.Acct = '44950'))
then H.YtdBal01 * -1 else H.YtdBal01 end YtdBal01,
Case when ((H.Acct between '42100' and '43900') or (H.Acct = '44950'))
then H.YtdBal02 * -1 else H.YtdBal02 end YtdBal02,
Case when ((H.Acct between '42100' and '43900') or (H.Acct = '44950'))
then H.YtdBal03 * -1 else H.YtdBal03 end YtdBal03,
Case when ((H.Acct between '42100' and '43900') or (H.Acct = '44950'))
then H.YtdBal04 * -1 else H.YtdBal04 end YtdBal04,
Case when ((H.Acct between '42100' and '43900') or (H.Acct = '44950'))
then H.YtdBal05 * -1 else H.YtdBal05 end YtdBal05,
Case when ((H.Acct between '42100' and '43900') or (H.Acct = '44950'))
then H.YtdBal06 * -1 else H.YtdBal06 end YtdBal06,
Case when ((H.Acct between '42100' and '43900') or (H.Acct = '44950'))
then H.YtdBal07 * -1 else H.YtdBal07 end YtdBal07,
Case when ((H.Acct between '42100' and '43900') or (H.Acct = '44950'))
then H.YtdBal08 * -1 else H.YtdBal08 end YtdBal08,
Case when ((H.Acct between '42100' and '43900') or (H.Acct = '44950'))
then H.YtdBal09 * -1 else H.YtdBal09 end YtdBal09,
Case when ((H.Acct between '42100' and '43900') or (H.Acct = '44950'))
then H.YtdBal10 * -1 else H.YtdBal10 end YtdBal10,
Case when ((H.Acct between '42100' and '43900') or (H.Acct = '44950'))
then H.YtdBal11 * -1 else H.YtdBal11 end YtdBal11,
Case when ((H.Acct between '42100' and '43900') or (H.Acct = '44950'))
then H.YtdBal12 * -1 else H.YtdBal12 end YtdBal12,
A.AcctType,
A.Descr
FROM SolomonApp.dbo.Account A, SolomonApp.dbo.AcctHist H
WHERE A.Acct = H.Acct
--ORDER BY
--H.Sub,
--H.FiscYr,
--H.CpnyID,
--H.Acct



