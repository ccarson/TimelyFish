
create view BPv_ARHistCpny as

SELECT DISTINCT CpnyID, CustId
  FROM ARHist
