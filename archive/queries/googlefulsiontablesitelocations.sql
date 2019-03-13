USE [SSL_Repo]
GO

/****** Object:  View [dbo].[Google_Fusion_Table_Site_Location]    Script Date: 10/26/2016 8:19:21 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






ALTER VIEW [dbo].[Google_Fusion_Table_Site_Location]
AS
SELECT     pedlabsampnum AS [Pedon Lab Sample Number], usiteid AS [User Site Identifier
], ISNULL
                          ((SELECT     area_name
                              FROM         dbo.area AS area_0
                              WHERE     (area_key = dbo.combine_nasis_ncss.country_key)), '') AS [Country
], ISNULL
                          ((SELECT     area_name
                              FROM         dbo.area AS area_2
                              WHERE     (area_key = dbo.combine_nasis_ncss.state_key)), '') AS [State
], ISNULL
                          ((SELECT     area_name
                              FROM         dbo.area AS area_1
                              WHERE     (area_key = dbo.combine_nasis_ncss.county_key)), '') AS [County
], ISNULL
                          ((SELECT     area_code
                              FROM         dbo.area AS area_3
                              WHERE     (area_key = dbo.combine_nasis_ncss.mlra_key)), '') AS [MLRA
], latitude_decimal_degrees AS [Latitude Decimal Degrees
], 
                      longitude_decimal_degrees AS [Longitude Decimal Degrees
], REPLACE(ISNULL(corr_name, ''),',',' ') AS [Correlated Series Name
], REPLACE(ISNULL(samp_name, ''),',',' ') AS [Sampled As Series Name
], '<a href="http://ncsslabdatamart.sc.egov.usda.gov/rptExecute.aspx?p=' + CAST(pedon_key AS VARCHAR) 
                      + '&r=1&g=on&" target="_blank">Lab Data Report</a>' AS [Lab Report URL
], 
                      '<a href="http://ncsslabdatamart.sc.egov.usda.gov/rptExecute.aspx?p=' + CAST(pedon_key AS VARCHAR) 
                      + '&r=4&" target="_blank">Pedon Description Report</a>' AS [Description Report URL
], ROUND(dbo.PedonCompleteIndex(pedon_key), 0) 
                      AS [Complete Pedon Index
]
FROM         dbo.combine_nasis_ncss
WHERE     (NOT (latitude_decimal_degrees IS NULL)) AND (NOT (longitude_decimal_degrees IS NULL))






GO

