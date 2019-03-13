USE [SSL_Repo]
GO

/****** Object:  View [dbo].[XRay_And_Thermal]    Script Date: 10/26/2016 8:21:31 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




ALTER VIEW [dbo].[XRay_And_Thermal]
AS
SELECT        natural_key, result_source_key, prep_code, analyzed_size_frac,
                             (SELECT        TOP (1) ISNULL(dbo.bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON dbo.result.prep_key = dbo.preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON dbo.result.procedure_key = dbo.bridge_proced_ss.procedure_key AND 
                                                         dbo.result.source_system_key = dbo.bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT (dbo.result.result_value IS NULL)) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (analyzed_size_frac = q1.analyzed_size_frac)
														 AND (dbo.result.analyte_key IN (397, 398, 399, 400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 
                                                         414, 415, 416, 417, 418, 419, 420, 421, 422, 423, 424, 425, 426, 427, 428, 429, 430, 431, 432, 433, 434, 435, 436, 437, 438, 439, 440, 441, 442, 443, 
                                                         444, 445, 446, 447, 448, 449, 450, 811, 812, 813, 1122, 1123, 1201, 1231, 1242, 1751, 2085, 2172))) AS X_Ray_Method,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_70 left join preparation on result_70.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 397)) 
                         AS AM_Amphibole_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_69 left join preparation on result_69.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 398)) 
                         AS LC_Anacime_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_68 left join preparation on result_68.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 399)) 
                         AS AE_Anatase_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_67 left join preparation on result_67.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 400)) 
                         AS AG_Antigoite_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_66 left join preparation on result_66.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 401)) 
                         AS AO_Aragonite_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_65 left join preparation on result_65.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 402)) 
                         AS BT_Biotite_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_64 left join preparation on result_64.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 403)) 
                         AS BC_Biotite_Chlorite_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_63 left join preparation on result_63.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 404)) 
                         AS BR_Brucite_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_62 left join preparation on result_62.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 405)) 
                         AS CA_Calcite_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_61 left join preparation on result_61.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 406)) 
                         AS CL_Chlorite_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_60 left join preparation on result_60.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 407)) 
                         AS CM_Chlorite_Mica_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_59 left join preparation on result_59.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 408)) 
                         AS CR_Cristobalite_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_58 left join preparation on result_58.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 409)) 
                         AS DL_Dolomite_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_57 left join preparation on result_57.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 410)) 
                         AS EN_Enstatite_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_56 left join preparation on result_56.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 411)) 
                         AS FD_Feldspar_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_55 left join preparation on result_55.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 412)) 
                         AS GI_Gibbsite_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_54 left join preparation on result_54.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 413)) 
                         AS GL_Glauconite_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_53 left join preparation on result_53.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 414)) 
                         AS GE_Geothite_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_52 left join preparation on result_52.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 415)) 
                         AS GY_Gypsum_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_51 left join preparation on result_51.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 416)) 
                         AS KH_Halloysite_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_50 left join preparation on result_50.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 417)) 
                         AS HE_Hematite_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_49 left join preparation on result_49.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 418)) 
                         AS HN_Hornblende_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_48 left join preparation on result_48.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 419)) 
                         AS HB_Hydrobiotite_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_47 left join preparation on result_47.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 420)) 
                         AS IL_Illite_Hydromuscovite_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_46 left join preparation on result_46.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 421)) 
                         AS KK_Kaolinite_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_45 left join preparation on result_45.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 422)) 
                         AS FL_Labradorite_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_44 left join preparation on result_44.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 423)) 
                         AS LE_Lepidocrocite_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_43 left join preparation on result_43.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 424)) 
                         AS MH_Maghemite_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_42 left join preparation on result_42.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 425)) 
                         AS MG_Magnetite_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_41 left join preparation on result_41.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 426)) 
						AS MI_Mica_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_40 left join preparation on result_40.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 427)) 
                         AS MT_Montmorillonite_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_39 left join preparation on result_39.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 428)) 
                         AS MC_Montmorillonite_Chlorite_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_38 left join preparation on result_38.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 429)) 
                         AS MM_Montmorillonite_Mica_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_37 left join preparation on result_37.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 430)) 
                         AS MV_Montmorillonite_Vermiculite_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_36 left join preparation on result_36.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 431)) 
                         AS MS_Muscovite_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_35 left join preparation on result_35.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 432)) 
                         AS NX_Non_Crystalline_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_34 left join preparation on result_34.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 433)) 
                         AS FO_Oligoclase_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_33 left join preparation on result_33.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 434)) 
                         AS FR_Orthoclase_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_32 left join preparation on result_32.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 435)) 
                         AS PG_Palygorskite_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_31 left join preparation on result_31.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 436)) 
                         AS PL_Phlogophite_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_30 left join preparation on result_30.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 437)) 
                         AS FP_Plagioclase_Feldspar_X_Ra,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_29 left join preparation on result_29.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 438)) 
                         AS FK_Potassium_Feldspar_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_28 left join preparation on result_28.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 439)) 
                         AS PY_Pyrophyllite_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_27 left join preparation on result_27.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 440)) 
                         AS QZ_Quartz_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_26 left join preparation on result_26.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 441)) 
                         AS RE_Resistant_Minerals_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_25 left join preparation on result_25.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 442)) 
                         AS SE_Sepiolite_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_24 left join preparation on result_24.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 443)) 
						AS TA_Talc_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_23 left join preparation on result_23.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 444)) 
                         AS TH_Thenardite_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_22 left join preparation on result_22.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 445)) 
                         AS TD_Tridymite_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_21 left join preparation on result_21.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 446)) 
                         AS VR_Vermiculite_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_20 left join preparation on result_20.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 447)) 
                         AS VC_Vermiculite_Chlorite_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_19 left join preparation on result_19.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 448)) 
                         AS VH_Vermiculite_Hydrobiotite_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_18 left join preparation on result_18.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 449)) 
                         AS VM_Vermiculite_Mica_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_17 left join preparation on result_17.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 450)) 
                         AS ZE_Zeolite_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_16 left join preparation on result_16.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 811)) 
						AS HA_Halite_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_15 left join preparation on result_15.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 812)) 
                         AS HS_Hydroxy_Interlayered_Smectite_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_14 left join preparation on result_14.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 813)) 
                         AS HV_Hydroxy_Interlayered_Vermiculite_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_15 left join preparation on result_15.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 1122)) 
                         AS FT_Fluorapatite_XRay,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_14 left join preparation on result_14.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 1123)) 
                         AS NU_Natrojarosite_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_16 left join preparation on result_16.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 1201)) 
                         AS HA_PT_Paragonite_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_75 left join preparation on result_75.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 1231)) 
                         AS NA_Natron_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_74 left join preparation on result_74.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 1242)) 
                         AS JO_Jarosite_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_73 left join preparation on result_73.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 1751)) 
                         AS SZ_Serpentine_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_72 left join preparation on result_72.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 2085)) 
                         AS BE_Boehmite_X_Ray,
                             (SELECT        TOP (1) CAST(SUBSTRING(result_value, 1, CASE CHARINDEX(':', result_value) WHEN 0 THEN LEN(result_value) ELSE CHARINDEX(':', result_value) 
                                                         - 1 END) AS numeric) AS Expr1
                               FROM            dbo.result AS result_71 left join preparation on result_71.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key = 2172)) 
                         AS BD_Beidellite_X_Ray,

                             (SELECT        TOP (1) result_value AS Expr1
                               FROM            (SELECT        result_value, 'S' AS prep_code, '<0.002 mm' as analyzed_size_frac
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                   AND (analyte_key IN (1099, 1524, 1884))
                                                         UNION
                                                         SELECT        result_value, 'N' AS prep_code, '<0.002 mm' as analyzed_size_frac
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1883, 1886))
                                                         UNION
                                                         SELECT        result_value, 'GP' AS prep_code, '<0.002 mm' as analyzed_size_frac
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1433, 1525, 1885))) AS result_1
                               WHERE        (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac)) 
						AS Clay_Mineral_Interpretation,

                             (SELECT        TOP (1) ISNULL(bridge_proced_ss_2.proced_code, '') AS Expr1
                               FROM            dbo.result AS result_13 INNER JOIN
                                                         dbo.preparation AS preparation_2 ON result_13.prep_key = preparation_2.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss AS bridge_proced_ss_2 ON result_13.procedure_key = bridge_proced_ss_2.procedure_key AND 
                                                         result_13.source_system_key = bridge_proced_ss_2.source_system_key
                               WHERE        (result_13.result_type = 'layer analyte') AND (result_13.result_value <> '') AND (NOT (result_13.result_value IS NULL)) AND 
                                                         (result_13.result_source_key = q1.result_source_key) AND (preparation_2.prep_code = q1.prep_code) AND (result_13.result_reliability IS NULL OR
                                                         result_13.result_reliability = '0') AND (result_13.analyte_key IN (42, 43, 2157, 2158, 2159, 2160, 2161, 2162, 2163))) 
                         AS Differential_Scanning_Calorimeter_Method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            dbo.result AS result_12 left join preparation on result_12.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key IN (42))) 
                         AS GI_Gibbsite_Differential_Scanning_Calorimetry,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            dbo.result AS result_12 left join preparation on result_12.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key IN (43))) 
                         AS KK_Kaolinite_Differential_Scanning_Calorimetry,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            dbo.result AS result_12 left join preparation on result_12.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key IN (2157))) 
                         AS GE_Geothite_Differential_Scanning_Calorimetry,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            dbo.result AS result_12 left join preparation on result_12.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key IN (2158))) 
                         AS GY_Gypsum_Differential_Scanning_Calorimetry,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            dbo.result AS result_12 left join preparation on result_12.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key IN (2159))) 
					    AS AT_Alunite_Differential_Scanning_Calorimetry,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            dbo.result AS result_12 left join preparation on result_12.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key IN (2160))) 
                         AS SM_Smectite_Differential_Scanning_Calorimetry,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            dbo.result AS result_12 left join preparation on result_12.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key IN (2161))) 
                         AS KH_Halloysite_Differential_Scanning_Calorimetry,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            dbo.result AS result_12 left join preparation on result_12.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key IN (2162))) 
                         AS QZ_Quartz_Differential_Scanning_Calorimetry,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            dbo.result AS result_12 left join preparation on result_12.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key IN (2163))) 
                         AS VR_Vermiculite_Differential_Calorimetry,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss_1.proced_code, '') AS Expr1
                               FROM            dbo.result AS result_10 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_10.prep_key = preparation_1.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss AS bridge_proced_ss_1 ON result_10.procedure_key = bridge_proced_ss_1.procedure_key AND 
                                                         result_10.source_system_key = bridge_proced_ss_1.source_system_key
                               WHERE        (result_10.result_type = 'layer analyte') AND (result_10.result_value <> '') AND (NOT (result_10.result_value IS NULL)) AND 
                                                         (result_10.result_source_key = q1.result_source_key) AND (preparation_1.prep_code = q1.prep_code) AND (result_10.result_reliability IS NULL OR
                                                         result_10.result_reliability = '0') AND (result_10.analyte_key IN (364, 365, 366, 367, 1205, 1758, 1759, 1760, 1881))) 
                         AS Thermal_Gravimetric_Method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            dbo.result AS result_12 left join preparation on result_12.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key IN (364))) 
                         AS AG_Gypsum_Thermal_Gravimetric_Analysis,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            dbo.result AS result_12 left join preparation on result_12.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key IN (365))) 
                         AS GI_Gibbsite_Thermal_Gravimetric_Analysis,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            dbo.result AS result_12 left join preparation on result_12.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key IN (366))) 
                         AS GE_Kaolinite_Differential_Thermal_Analysis,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            dbo.result AS result_12 left join preparation on result_12.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key IN (367))) 
                         AS KK_Kaolinite_Thermal_Gravimetric_Analysis,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            dbo.result AS result_12 left join preparation on result_12.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key IN (1205))) 
                         AS AG_Antigorite_Thermal_Gravimetric_Analysis,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            dbo.result AS result_12 left join preparation on result_12.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key IN (1758))) 
                         AS KH_Halloysite_Thermal_Gravimetric_Analysis,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            dbo.result AS result_12 left join preparation on result_12.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key IN (1759))) 
                         AS MT_Montmorillonite_Thermal_Gravimetric_Analysis,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            dbo.result AS result_12 left join preparation on result_12.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key IN (1760))) 
                         AS PG_Palygorskite_Thermal_Gravimetric_Analysis,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            dbo.result AS result_12 left join preparation on result_12.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key IN (1881))) 
                         AS CA_Calcite_Thermal_Gravimetric_Analysis,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss_1.proced_code, '') AS Expr1
                               FROM            dbo.result AS result_10 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_10.prep_key = preparation_1.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss AS bridge_proced_ss_1 ON result_10.procedure_key = bridge_proced_ss_1.procedure_key AND 
                                                         result_10.source_system_key = bridge_proced_ss_1.source_system_key
                               WHERE        (result_10.result_type = 'layer analyte') AND (result_10.result_value <> '') AND (NOT (result_10.result_value IS NULL)) AND 
                                                         (result_10.result_source_key = q1.result_source_key) AND (preparation_1.prep_code = q1.prep_code) AND (result_10.result_reliability IS NULL OR
                                                         result_10.result_reliability = '0') AND (result_10.analyte_key IN (809, 810, 814, 815, 816))) AS Differential_Thermal_Analysis_Method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            dbo.result AS result_12 left join preparation on result_12.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key IN (809))) 
                         AS GI_Gibbsite_Differential_Thermal_Analysis,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            dbo.result AS result_12 left join preparation on result_12.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key IN (810))) 
                         AS KK_Kaolinite_Differential_Thermal_Analysis,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            dbo.result AS result_12 left join preparation on result_12.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key IN (814))) 
                         AS GE_Geothite_Differential_Thermal_Analysis,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            dbo.result AS result_12 left join preparation on result_12.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key IN (815))) 
                         AS KH_Halloysite_Differential_Thermal_Analysi,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            dbo.result AS result_12 left join preparation on result_12.prep_key = preparation.prep_key
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND (analyte_key IN (816))) 
                         AS QZ_Quartz_Differential_Thermal_Analysis
FROM            dbo.XRay_And_Thermal_List AS q1
GROUP BY prep_code, natural_key, result_source_key, analyzed_size_frac




GO

