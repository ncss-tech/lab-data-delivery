USE [SSL_Repo]
GO

/****** Object:  View [dbo].[Calculations_Including_Estimates_And_Default_Values_List]    Script Date: 10/26/2016 8:17:49 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER VIEW [dbo].[Calculations_Including_Estimates_And_Default_Values_List]
AS
SELECT        dbo.layer.natural_key, dbo.result.result_key, dbo.result.result_type, dbo.result.result_source_key, dbo.result.analyte_key, dbo.result.prep_key, 
                         dbo.result.result_value, dbo.result.procedure_key, dbo.result.analyzed_size_frac, dbo.analyte.analyte_abbrev, dbo.preparation.prep_abbrev, 
                         dbo.preparation.prep_code, dbo.analyte.analyte_format, dbo.layer.site_key, dbo.result.source_system_key, ISNULL(dbo.bridge_proced_ss.proced_code, '') 
                         AS procedure_code
FROM            dbo.layer INNER JOIN
                         dbo.result INNER JOIN
                         dbo.analyte ON dbo.result.analyte_key = dbo.analyte.analyte_key INNER JOIN
                         dbo.preparation ON dbo.result.prep_key = dbo.preparation.prep_key ON dbo.layer.layer_key = dbo.result.result_source_key LEFT OUTER JOIN
                         dbo.bridge_proced_ss ON dbo.result.procedure_key = dbo.bridge_proced_ss.procedure_key AND 
                         dbo.result.source_system_key = dbo.bridge_proced_ss.source_system_key
WHERE        (dbo.result.analyte_key IN (4, 25, 28, 243, 242, 590 , 591 , 593 , 516 , 600 , 614 , 617 , 610 , 613 , 615 , 594 , 598 , 575 , 580 , 582 , 578 , 579 , 581 , 577 , 574 , 583 , 576 , 573 , 555 , 556 , 599 , 612 , 611 , 604 , 602 , 596 , 609 , 608 , 607 , 605 , 587 , 603 , 601 , 595 , 628 , 631 , 630 , 606 , 547 , 544 , 542 , 543 , 548, 549 , 553 , 551 , 554 , 552 , 546 , 550 , 545 , 528 , 526 , 525 , 524 , 523 , 530 , 529 , 527 , 534 , 533 , 538 , 537 , 539 , 571 , 572 , 586 , 555 , 556
						)) AND (dbo.result.result_reliability IS NULL OR dbo.result.result_reliability = '0')


GO

