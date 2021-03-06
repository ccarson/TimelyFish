﻿CREATE TABLE [carereporting].[SUMMARY_DATA] (
    [site_id]                                 INT      NOT NULL,
    [perfdate]                                DATETIME NOT NULL,
    [perfparity]                              SMALLINT NOT NULL,
    [TotalServices]                           SMALLINT NULL,
    [TotalFirstServices]                      SMALLINT NULL,
    [TotalGiltFirstServices]                  SMALLINT NULL,
    [TotalGiltAvailableFirstServices]         SMALLINT NULL,
    [SumAvailableTo1stServiceInterval]        SMALLINT NULL,
    [TotalGiltArrivalFirstServices]           SMALLINT NULL,
    [SumArrivalTo1stServiceInterval]          SMALLINT NULL,
    [TotalFailToFarrowService]                SMALLINT NULL,
    [TotalRepeatsAndFailToFarrowServices]     SMALLINT NULL,
    [TotalWeanedSowFirstServices]             SMALLINT NULL,
    [TotalWeanedSowsFirstServedBy7Days]       SMALLINT NULL,
    [SumWeanTo1stServiceInterval]             SMALLINT NULL,
    [TotalRepeatServices]                     SMALLINT NULL,
    [TotalMatings]                            SMALLINT NULL,
    [TotalNaturalOnlyServices]                SMALLINT NULL,
    [TotalAIOnlyServices]                     SMALLINT NULL,
    [TotalMixedServices]                      SMALLINT NULL,
    [TotalMultipleMatingServices]             SMALLINT NULL,
    [TotalSoloBoarSemenServices]              SMALLINT NULL,
    [PresumedInPig]                           SMALLINT NULL,
    [ServedToFarrowWeek1PresumedInPig]        SMALLINT NULL,
    [Week1PresumedInPig]                      SMALLINT NULL,
    [ServedToFarrowWeek2PresumedInPig]        SMALLINT NULL,
    [Week2PresumedInPig]                      SMALLINT NULL,
    [ServedToFarrowWeek3PresumedInPig]        SMALLINT NULL,
    [Week3PresumedInPig]                      SMALLINT NULL,
    [ServedToFarrowWeek4PresumedInPig]        SMALLINT NULL,
    [Week4PresumedInPig]                      SMALLINT NULL,
    [ServedToFarrowWeek5PresumedInPig]        SMALLINT NULL,
    [Week5PresumedInPig]                      SMALLINT NULL,
    [ServedToFarrowWeek6PresumedInPig]        SMALLINT NULL,
    [Week6PresumedInPig]                      SMALLINT NULL,
    [ServedToFarrowWeek7PresumedInPig]        SMALLINT NULL,
    [Week7PresumedInPig]                      SMALLINT NULL,
    [ServedToFarrowWeek8PresumedInPig]        SMALLINT NULL,
    [Week8PresumedInPig]                      SMALLINT NULL,
    [ServedToFarrowWeek9PresumedInPig]        SMALLINT NULL,
    [Week9PresumedInPig]                      SMALLINT NULL,
    [ServedToFarrowWeek10PresumedInPig]       SMALLINT NULL,
    [Week10PresumedInPig]                     SMALLINT NULL,
    [ServedToFarrowWeek11PresumedInPig]       SMALLINT NULL,
    [Week11PresumedInPig]                     SMALLINT NULL,
    [ServedToFarrowWeek12PresumedInPig]       SMALLINT NULL,
    [Week12PresumedInPig]                     SMALLINT NULL,
    [ServedToFarrowWeek13PresumedInPig]       SMALLINT NULL,
    [Week13PresumedInPig]                     SMALLINT NULL,
    [ServedToFarrowWeek14PresumedInPig]       SMALLINT NULL,
    [Week14PresumedInPig]                     SMALLINT NULL,
    [ServedToFarrowWeek15PresumedInPig]       SMALLINT NULL,
    [Week15PresumedInPig]                     SMALLINT NULL,
    [ServedToFarrowWeek16PresumedInPig]       SMALLINT NULL,
    [Week16PresumedInPig]                     SMALLINT NULL,
    [ServedToFarrowWeek17PresumedInPig]       SMALLINT NULL,
    [Week17PresumedInPig]                     SMALLINT NULL,
    [TotalServicesFarrowed]                   SMALLINT NULL,
    [TotalServicesLateFarrowed]               SMALLINT NULL,
    [ServedToFarrow]                          SMALLINT NULL,
    [ServedToFarrowAdjFarrowingRate]          SMALLINT NULL,
    [ServedToFarrowFarrowed]                  SMALLINT NULL,
    [ServedToFarrowDropout0to28]              SMALLINT NULL,
    [ServedToFarrowDropout29to37]             SMALLINT NULL,
    [ServedToFarrowDropout38to56]             SMALLINT NULL,
    [ServedToFarrowDropout57to126]            SMALLINT NULL,
    [TotalFarrowings]                         SMALLINT NULL,
    [FirstLitterFarrowings]                   SMALLINT NULL,
    [AssistedFarrowings]                      SMALLINT NULL,
    [FirstLitterAssistedFarrowings]           SMALLINT NULL,
    [InducedFarrowings]                       SMALLINT NULL,
    [FirstLitterInducedFarrowings]            SMALLINT NULL,
    [Totalborn]                               SMALLINT NULL,
    [FirstLitterTotalborn]                    SMALLINT NULL,
    [Liveborn]                                SMALLINT NULL,
    [FirstLitterLiveborn]                     SMALLINT NULL,
    [Stillborn]                               SMALLINT NULL,
    [FirstLitterStillborn]                    SMALLINT NULL,
    [Mummified]                               SMALLINT NULL,
    [FirstLitterMummified]                    SMALLINT NULL,
    [SumFarrowingIntervals]                   SMALLINT NULL,
    [CountFarrowingIntervals]                 SMALLINT NULL,
    [SumGestationLength]                      SMALLINT NULL,
    [CountSowsFarrowedAndWeaned]              SMALLINT NULL,
    [SumPigletsWeanedToSowsFarrowedAndWeaned] SMALLINT NULL,
    [TotalAbortions]                          SMALLINT NULL,
    [PigletLossesLessThan2Days]               SMALLINT NULL,
    [PigletLosses2To8Days]                    SMALLINT NULL,
    [PigletLossesOver8Days]                   SMALLINT NULL,
    [SumPigletLossAge]                        SMALLINT NULL,
    [TotalPigletLosses]                       SMALLINT NULL,
    [CountPigletLossEvents]                   SMALLINT NULL,
    [LittersWeaned]                           SMALLINT NULL,
    [LittersWeanedSumLactationLengths]        SMALLINT NULL,
    [LittersWeanedLiveborn]                   SMALLINT NULL,
    [WeanedWithZero]                          SMALLINT NULL,
    [LittersWeanedPlusZero]                   SMALLINT NULL,
    [CompleteWeaned]                          SMALLINT NULL,
    [CompleteWeanedWithZero]                  SMALLINT NULL,
    [CompleteWeanedLiveborn]                  SMALLINT NULL,
    [TotalPigletsWeanedAllWeanings]           SMALLINT NULL,
    [SumLactationLengths]                     SMALLINT NULL,
    [SumLitterReconciliation]                 SMALLINT NULL,
    [NurseSowsCreated]                        SMALLINT NULL,
    [NurseSowsWeaned]                         SMALLINT NULL,
    [PartWeaned]                              SMALLINT NULL,
    [PartWeanedPigletsWeaned]                 SMALLINT NULL,
    [SumPigletsAgeAtWeaning]                  SMALLINT NULL,
    [TotalPigletsWeaned]                      SMALLINT NULL,
    [TotalPigletsWeanedExclPartWeaned]        SMALLINT NULL,
    [SubStandardWeaned]                       SMALLINT NULL,
    [FemalesSold]                             SMALLINT NULL,
    [FemalesDied]                             SMALLINT NULL,
    [FemalesTransferredOff]                   SMALLINT NULL,
    [SumParityAtSale]                         SMALLINT NULL,
    [SumParityAtDeath]                        SMALLINT NULL,
    [SumParityAtTransferredOff]               SMALLINT NULL,
    [SumParityAtDisposal]                     SMALLINT NULL,
    [FemalesDisposed]                         SMALLINT NULL,
    [TotalLivebornToDisposedSow]              SMALLINT NULL,
    [TotalStillbornToDisposedSow]             SMALLINT NULL,
    [TotalMummifiedToDisposedSow]             SMALLINT NULL,
    [TotalBornToDisposedSow]                  SMALLINT NULL,
    [TotalWeanedToDisposedSow]                SMALLINT NULL,
    [EndingFemaleInventory]                   SMALLINT NULL,
    [EndingSowInventory]                      SMALLINT NULL,
    [EndingGiltInventory]                     SMALLINT NULL,
    [EndingGestatingGiltInventory]            SMALLINT NULL,
    [EndingRetainedGiltInventory]             SMALLINT NULL,
    [EndingBoarInventory]                     SMALLINT NULL,
    [SumEndingFemaleParity]                   SMALLINT NULL,
    [FemalesArrived]                          SMALLINT NULL,
    [GiltsArrived]                            SMALLINT NULL,
    [SumSowNonProdDays]                       SMALLINT NULL,
    [SumGestationDays]                        SMALLINT NULL,
    [SumParityAtPeriodEnd]                    SMALLINT NULL,
    [SumParityDays]                           SMALLINT NULL,
    [SumGiltDays]                             SMALLINT NULL,
    [SumSowDays]                              SMALLINT NULL,
    [SumFemaleDays]                           SMALLINT NULL,
    CONSTRAINT [FK_SUMMARY_DATA_SITES_0] FOREIGN KEY ([site_id]) REFERENCES [careglobal].[SITES] ([site_id]) ON DELETE CASCADE
);

