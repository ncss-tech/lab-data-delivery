USE [SSL_Repo]
GO

/****** Object:  View [dbo].[Major_And_Trace_Elements_Oxides_List]    Script Date: 10/26/2016 8:19:48 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[Major_And_Trace_Elements_Oxides_List]
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
WHERE        (dbo.result.analyte_key IN (491, 490, 492, 496, 493, 494, 498, 495, 497, 499, 500, 1207, 1130, 1131, 1132, 1133, 501, 503, 502, 504, 507, 506, 1137, 508, 509, 505, 
                         1134, 1135, 1139, 1136, 1151, 1138, 1140, 510, 818, 819, 820)) AND (dbo.result.result_reliability IS NULL OR
                         dbo.result.result_reliability = '0')

GO

