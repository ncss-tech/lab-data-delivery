USE [SSL_Repo]
GO

/****** Object:  View [dbo].[Chemical_Properties]    Script Date: 10/26/2016 8:18:11 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





ALTER VIEW [dbo].[Chemical_Properties]
AS
SELECT  top 2000      natural_key, result_source_key, prep_code,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.1') AS decimal(10, 2)) AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (preparation.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key in (61,67,678))) AS ca_nh4_ph_7,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (preparation.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key IN (61,67,678))) AS ca_nh4_ph_7_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.1') AS decimal(10, 2)) AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (preparation.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key in (63,69,680))) AS mg_nh4_ph_7,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (preparation.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key IN (63,69,680))) AS mg_nh4_ph_7_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.1') AS decimal(10, 2)) AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (preparation.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key in (65,71,682))) AS na_nh4_ph_7,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (preparation.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key IN (65,71,682))) AS na_nh4_ph_7_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.1') AS decimal(10, 2)) AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (preparation.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key in (64,70,681))) AS k_nh4_ph_7,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (preparation.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key IN (64,70,681))) AS k_nh4_ph_7_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.1') AS decimal(10, 2)) AS Expr1
                               FROM            (SELECT        result_value, 'S' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                   AND (analyte_key IN (568,652,653,721,722,723,791,1291,1292,1440,2099))
                                                         UNION
                                                         SELECT        result_value, 'N' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1154,1289,1442))
                                                         UNION
                                                         SELECT        result_value, 'S-SK' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1290))
                                                         UNION
                                                         SELECT        result_value, 'M' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1152,1288,1441))
                                                         UNION
                                                         SELECT        result_value, 'HM' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1160))
                                                         UNION
                                                         SELECT        result_value, 'GP' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1161,1287))) AS result_1
                               WHERE        (prep_code = q1.prep_code)) 
						AS sum_of_nh4_ph_7_Ext_bases,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.1') AS decimal(10, 2)) AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (preparation.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key in (73, 1121))) acidity_bacl2_tea_ph_8_2,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (preparation.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key IN (73, 1121))) AS acidity_bacl2_tea_ph_82_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.1') AS decimal(10, 2)) AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (preparation.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key in (55))) aluminum_kcl_extractable,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (preparation.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key IN (55))) AS aluminum_kcl_extract_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.1') AS decimal(10, 2)) AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (preparation.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key in (56))) manganese_kcl_extractable,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (preparation.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key IN (56))) AS manganese_kcl_extract_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.1') AS decimal(10, 2)) AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (preparation.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key in (683))) iron_kcl_extractable,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (preparation.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key IN (683))) AS iron_kcl_extractable_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.1') AS decimal(10, 2)) AS Expr1
                               FROM            (SELECT        result_value, 'S' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                   AND (analyte_key IN (518,654,655,736,737,738,796,1303,1304,1450,2101))
                                                         UNION
                                                         SELECT        result_value, 'N' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1157,1301,1452))
                                                         UNION
                                                         SELECT        result_value, 'S-SK' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1302))
                                                         UNION
                                                         SELECT        result_value, 'M' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1046,1300,1451))
                                                         UNION
                                                         SELECT        result_value, 'HM' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1159))
                                                         UNION
                                                         SELECT        result_value, 'GP' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1162,1299
													))) AS result_1
                               WHERE        (prep_code = q1.prep_code)) AS sum_of_cations_cec_pH_8_2,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.1') AS decimal(10, 2)) AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (preparation.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key in (62,68,679))) cec_nh4_ph_7,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (preparation.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key IN (62,68,679))) AS cec_nh4_ph_7_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.1') AS decimal(10, 2)) AS Expr1
                               FROM            (SELECT        result_value, 'S' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                   AND (analyte_key IN (517,619,650,706,707,708,748,749,750,751,752,753,799,1097,1313,1314,1315,1316,1453,1454,2026,2030,2031,2032,2102))
                                                         UNION
                                                         SELECT        result_value, 'N' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1158,1309,1310,1455,1456,2034,2035))
                                                         UNION
                                                         SELECT        result_value, 'S-SK' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1311,1312,2029))
                                                         UNION
                                                         SELECT        result_value, 'M' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1048,1307,1308,1457,1458,2028,2033))
                                                         UNION
                                                         SELECT        result_value, 'HM' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1167))
                                                         UNION
                                                         SELECT        result_value, 'GP' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1168,1305,1306,2027))
													) AS result_1
                               WHERE        (prep_code = q1.prep_code)) AS ecec_base_plus_aluminum,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 2)) AS Expr1
                               FROM            (SELECT        result_value, 'S' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                   AND (analyte_key IN (512,618,648,703,704,705,715,716,717,718,719,720,790,1096,1325,1326,1327,1328,1462,1463,2036,2041,2042,2043,2104))
                                                         UNION
                                                         SELECT        result_value, 'N' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1153,1321,1322,1466,1467,2039,2045))
                                                         UNION
                                                         SELECT        result_value, 'S-SK' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1323,1324,2040))
                                                         UNION
                                                         SELECT        result_value, 'M' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1043,1319,1320,1464,1465,2038,2044))
                                                         UNION
                                                         SELECT        result_value, 'HM' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1169))
                                                         UNION
                                                         SELECT        result_value, 'GP' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1170,1317,1318,2037))
													) AS result_1
                               WHERE        (prep_code = q1.prep_code)) AS aluminum_saturation,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 2)) AS Expr1
                               FROM            (SELECT        result_value, 'S' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                   AND (analyte_key IN (514,658,659,660,661,662,663,664,665,724,728,730,731,732,792,1459,2103))
                                                         UNION
                                                         SELECT        result_value, 'N' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (727,1155,1461))
                                                         UNION
                                                         SELECT        result_value, 'S-SK' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (729))
                                                         UNION
                                                         SELECT        result_value, 'M' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (726,1044,1460))
                                                         UNION
                                                         SELECT        result_value, 'HM' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1163))
                                                         UNION
                                                         SELECT        result_value, 'GP' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1164,725))
													) AS result_1
                               WHERE        (prep_code = q1.prep_code)) AS base_sat_sum_of_cations_ph_8_2,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 2)) AS Expr1
                               FROM            (SELECT        result_value, 'S' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                   AND (analyte_key IN (513,666,667,733,734,735,793,1297,1298,1447,2100))
                                                         UNION
                                                         SELECT        result_value, 'N' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1156,1295,1449))
                                                         UNION
                                                         SELECT        result_value, 'S-SK' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1296))
                                                         UNION
                                                         SELECT        result_value, 'M' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1045,1294,1448))
                                                         UNION
                                                         SELECT        result_value, 'HM' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1165))
                                                         UNION
                                                         SELECT        result_value, 'GP' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1166,1293))
												) AS result_1
                               WHERE        (prep_code = q1.prep_code)) AS base_sat_nh4oac_ph_7,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(dbo.result.result_value, '4.2') AS decimal(10, 3)) Expr1
                               FROM            dbo.result INNER JOIN dbo.preparation ON dbo.result.prep_key = dbo.preparation.prep_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key IN (45, 460))) AS total_carbon_ncs,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key IN (45, 460))) AS total_carbon_ncs_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_17.result_value, '5.3') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_17 INNER JOIN
                                                         dbo.preparation AS preparation_17 ON result_17.prep_key = preparation_17.prep_key
                               WHERE        (result_17.result_type = 'layer analyte') AND (result_17.result_value <> '') AND (NOT result_17.result_value IS NULL) AND 
                                                         (result_17.result_source_key = q1.result_source_key) AND (preparation_17.prep_code = q1.prep_code) AND (result_17.result_reliability IS NULL OR
                                                         result_17.result_reliability = '0') AND (result_17.analyte_key IN (79, 461))) AS total_nitrogen_ncs,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key IN (79, 461))) AS total_nitrogen_ncs_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_16.result_value, '4.2') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_16 INNER JOIN
                                                         dbo.preparation AS preparation_16 ON result_16.prep_key = preparation_16.prep_key
                               WHERE        (result_16.result_type = 'layer analyte') AND (result_16.result_value <> '') AND (NOT result_16.result_value IS NULL) AND 
                                                         (result_16.result_source_key = q1.result_source_key) AND (preparation_16.prep_code = q1.prep_code) AND (result_16.result_reliability IS NULL OR
                                                         result_16.result_reliability = '0') AND (result_16.analyte_key IN (362, 462))) AS total_sulfur_ncs,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key IN (362, 462))) AS total_sulfur_ncs_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.1') AS decimal(10, 3)) AS Expr1
                               FROM            (SELECT        result_value, 'S' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                   AND (analyte_key IN (794,1070,1238))
                                                         UNION
                                                         SELECT        result_value, 'N' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (2021))
                                                         UNION
                                                         SELECT        result_value, 'GP' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (2022))
											) AS result_1
                               WHERE        (prep_code = q1.prep_code)) AS estimated_organic_carbon,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_15.result_value, '4.2') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_15 INNER JOIN
                                                         dbo.preparation AS preparation_15 ON result_15.prep_key = preparation_15.prep_key
                               WHERE        (result_15.result_type = 'layer analyte') AND (result_15.result_value <> '') AND (NOT result_15.result_value IS NULL) AND 
                                                         (result_15.result_source_key = q1.result_source_key) AND (preparation_15.prep_code = q1.prep_code) AND (result_15.result_reliability IS NULL OR
                                                         result_15.result_reliability = '0') AND (result_15.analyte_key = 780)) AS organic_carbon_walkley_black,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 780)) AS oc_walkley_black_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 3)) AS Expr1
                               FROM            (SELECT        result_value, 'S' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND (result_source_key = q1.result_source_key) AND (analyte_key IN (559, 647))
                                                         UNION
                                                         SELECT        result_value, 'M' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND (result_source_key = q1.result_source_key) AND (analyte_key = 1078)
                                                         UNION
                                                         SELECT        result_value, 'N' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND (result_source_key = q1.result_source_key) AND (analyte_key IN (1076, 2086))
                                                         UNION
                                                         SELECT        result_value, 'GP' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND (result_source_key = q1.result_source_key) AND (analyte_key = 1077)
                                                         UNION
                                                         SELECT        result_value, 'HM' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND (result_source_key = q1.result_source_key) AND (analyte_key = 1079)) 
                                                         AS result_1
                               WHERE        (prep_code = q1.prep_code)) AS carbon_to_nitrogen_ratio,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_13.result_value, '4.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_13 INNER JOIN
                                                         dbo.preparation AS preparation_13 ON result_13.prep_key = preparation_13.prep_key
                               WHERE        (result_13.result_type = 'layer analyte') AND (result_13.result_value <> '') AND (NOT result_13.result_value IS NULL) AND (result_13.result_source_key = q1.result_source_key) AND 
                                                         (preparation_13.prep_code = q1.prep_code) AND (result_13.result_reliability IS NULL OR
                                                         result_13.result_reliability = '0') AND (result_13.analyte_key = 52)) AS fe_dithionite_citrate_extract,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 52)) AS iron_dc_extract_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_12.result_value, '4.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_12 INNER JOIN
                                                         dbo.preparation AS preparation_12 ON result_12.prep_key = preparation_12.prep_key
                               WHERE        (result_12.result_type = 'layer analyte') AND (result_12.result_value <> '') AND (NOT result_12.result_value IS NULL) AND (result_12.result_source_key = q1.result_source_key) AND 
                                                         (preparation_12.prep_code = q1.prep_code) AND (result_12.result_reliability IS NULL OR
                                                         result_12.result_reliability = '0') AND (result_12.analyte_key = 51)) AS aluminum_dithionite_citrate,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 51)) AS aluminum_dc_extract_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_11.result_value, '4.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_11 INNER JOIN
                                                         dbo.preparation AS preparation_11 ON result_11.prep_key = preparation_11.prep_key
                               WHERE        (result_11.result_type = 'layer analyte') AND (result_11.result_value <> '') AND (NOT result_11.result_value IS NULL) AND (result_11.result_source_key = q1.result_source_key) AND 
                                                         (preparation_11.prep_code = q1.prep_code) AND (result_11.result_reliability IS NULL OR
                                                         result_11.result_reliability = '0') AND (result_11.analyte_key = 53)) AS manganese_dithionite_citrate,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 53)) AS manganese_dc_extract_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '5.2') AS decimal(10, 3)) AS Expr1
                               FROM            (SELECT        result_value, 'S' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND (result_source_key = q1.result_source_key) AND (analyte_key IN (690, 691, 
                                                                                   1071, 1090, 1851))
                                                         UNION
                                                         SELECT        result_value, 'M' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND (result_source_key = q1.result_source_key) AND (analyte_key IN (692, 693, 
                                                                                  1072, 1091, 1848))
                                                         UNION
                                                         SELECT        result_value, 'MW' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND (result_source_key = q1.result_source_key) AND (analyte_key IN (700, 701, 
																					1095, 1849))
                                                         UNION
                                                         SELECT        result_value, 'N' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND (result_source_key = q1.result_source_key) AND (analyte_key IN (696, 697, 
                                                                                  1074, 1093, 1850))
                                                         UNION
                                                         SELECT        result_value, 'GP' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND (result_source_key = q1.result_source_key) AND (analyte_key IN (698, 699, 
                                                                                  1075, 1094, 1846))
                                                         UNION
                                                         SELECT        result_value, 'HM' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND (result_source_key = q1.result_source_key) AND (analyte_key IN (694, 695, 
                                                                                  1073, 1092, 1847))) AS result_1
                               WHERE        (prep_code = q1.prep_code)) AS aluminum_plus_half_iron_oxalat,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_9.result_value, '4.2') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_9 INNER JOIN
                                                         dbo.preparation AS preparation_9 ON result_9.prep_key = preparation_9.prep_key
                               WHERE        (result_9.result_type = 'layer analyte') AND (result_9.result_value <> '') AND (NOT result_9.result_value IS NULL) AND (result_9.result_source_key = q1.result_source_key) AND 
                                                         (preparation_9.prep_code = q1.prep_code) AND (result_9.result_reliability IS NULL OR
                                                         result_9.result_reliability = '0') AND (result_9.analyte_key = 452)) AS ammoniumoxalate_opticaldensity,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 452)) AS ammonium_ox_opt_dens_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_8.result_value, '5.2') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_8 INNER JOIN
                                                         dbo.preparation AS preparation_8 ON result_8.prep_key = preparation_8.prep_key
                               WHERE        (result_8.result_type = 'layer analyte') AND (result_8.result_value <> '') AND (NOT result_8.result_value IS NULL) AND (result_8.result_source_key = q1.result_source_key) AND 
                                                         (preparation_8.prep_code = q1.prep_code) AND (result_8.result_reliability IS NULL OR
                                                         result_8.result_reliability = '0') AND (result_8.analyte_key = 47)) AS fe_ammoniumoxalate_extractable,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 47)) AS iron_ammonium_oxalate_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_7.result_value, '5.2') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_7 INNER JOIN
                                                         dbo.preparation AS preparation_7 ON result_7.prep_key = preparation_7.prep_key
                               WHERE        (result_7.result_type = 'layer analyte') AND (result_7.result_value <> '') AND (NOT result_7.result_value IS NULL) AND (result_7.result_source_key = q1.result_source_key) AND 
                                                         (preparation_7.prep_code = q1.prep_code) AND (result_7.result_reliability IS NULL OR
                                                         result_7.result_reliability = '0') AND (result_7.analyte_key = 46)) AS aluminum_ammonium_oxalate,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 46)) AS al_ammonium_oxalate_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_5.result_value, '5.2') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_5 INNER JOIN
                                                         dbo.preparation AS preparation_5 ON result_5.prep_key = preparation_5.prep_key
                               WHERE        (result_5.result_type = 'layer analyte') AND (result_5.result_value <> '') AND (NOT result_5.result_value IS NULL) AND (result_5.result_source_key = q1.result_source_key) AND 
                                                         (preparation_5.prep_code = q1.prep_code) AND (result_5.result_reliability IS NULL OR
                                                         result_5.result_reliability = '0') AND (result_5.analyte_key = 50)) AS silica_ammonium_oxalate,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 50)) AS silica_ammonium_oxalate_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_6.result_value, '7.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_6 INNER JOIN
                                                         dbo.preparation AS preparation_6 ON result_6.prep_key = preparation_6.prep_key
                               WHERE        (result_6.result_type = 'layer analyte') AND (result_6.result_value <> '') AND (NOT result_6.result_value IS NULL) AND (result_6.result_source_key = q1.result_source_key) AND 
                                                         (preparation_6.prep_code = q1.prep_code) AND (result_6.result_reliability IS NULL OR
                                                         result_6.result_reliability = '0') AND (result_6.analyte_key = 48)) AS manganese_ammonium_oxalate,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 48)) AS mn_ammonium_oxalate_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_4.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_4 INNER JOIN
                                                         dbo.preparation AS preparation_4 ON result_4.prep_key = preparation_4.prep_key
                               WHERE        (result_4.result_type = 'layer analyte') AND (result_4.result_value <> '') AND (NOT result_4.result_value IS NULL) AND (result_4.result_source_key = q1.result_source_key) AND 
                                                         (preparation_4.prep_code = q1.prep_code) AND (result_4.result_reliability IS NULL OR
                                                         result_4.result_reliability = '0') AND (result_4.analyte_key = 58)) AS carbon_sodium_pyro_phospate,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 58)) AS c_na_pyro_phosphate_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_3.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_3 INNER JOIN
                                                         dbo.preparation AS preparation_3 ON result_3.prep_key = preparation_3.prep_key
                               WHERE        (result_3.result_type = 'layer analyte') AND (result_3.result_value <> '') AND (NOT result_3.result_value IS NULL) AND (result_3.result_source_key = q1.result_source_key) AND 
                                                         (preparation_3.prep_code = q1.prep_code) AND (result_3.result_reliability IS NULL OR
                                                         result_3.result_reliability = '0') AND (result_3.analyte_key = 59)) AS iron_sodium_pyro_phosphate
,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 59)) AS iron_na_pyro_phosphate_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_2.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_2 INNER JOIN
                                                         dbo.preparation AS preparation_2 ON result_2.prep_key = preparation_2.prep_key
                               WHERE        (result_2.result_type = 'layer analyte') AND (result_2.result_value <> '') AND (NOT result_2.result_value IS NULL) AND (result_2.result_source_key = q1.result_source_key) AND 
                                                         (preparation_2.prep_code = q1.prep_code) AND (result_2.result_reliability IS NULL OR
                                                         result_2.result_reliability = '0') AND (result_2.analyte_key = 57)) AS aluminum_na_pyro_phosphate,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 57)) AS aluminum_na_pyro_phosphate_met,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_1.result_value, '5.2') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT result_1.result_value IS NULL) AND (result_1.result_source_key = q1.result_source_key) AND 
                                                         (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key = 60)) AS manganese_na_pyro_phosphate,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 60)) AS mn_na_pyro_phosphate_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_1.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT result_1.result_value IS NULL) AND (result_1.result_source_key = q1.result_source_key) AND 
                                                         (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key = 244)) AS ph_kcl,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 244)) AS ph_kcl_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_1.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT result_1.result_value IS NULL) AND (result_1.result_source_key = q1.result_source_key) AND 
                                                         (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key = 455)) AS ph_cacl2,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 455)) AS ph_cacl2_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_1.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT result_1.result_value IS NULL) AND (result_1.result_source_key = q1.result_source_key) AND 
                                                         (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key = 247)) AS ph_h2o,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 247)) AS ph_h2o_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_1.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT result_1.result_value IS NULL) AND (result_1.result_source_key = q1.result_source_key) AND 
                                                         (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key = 456)) AS ph_saturated_paste,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 456)) AS ph_saturated_paste_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_1.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT result_1.result_value IS NULL) AND (result_1.result_source_key = q1.result_source_key) AND 
                                                         (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key = 246)) AS ph_oxidized,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_1.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT result_1.result_value IS NULL) AND (result_1.result_source_key = q1.result_source_key) AND 
                                                         (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key = 1147)) AS ph_oxidized_initial,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key in (246,1147))) AS ph_oxidized_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_1.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT result_1.result_value IS NULL) AND (result_1.result_source_key = q1.result_source_key) AND 
                                                         (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key = 245)) AS ph_naf,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 245)) AS ph_naf_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_1.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT result_1.result_value IS NULL) AND (result_1.result_source_key = q1.result_source_key) AND 
                                                         (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key = 1363)) AS ph_water_extract,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 1363)) AS ph_water_extract_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_1.result_value, '3.0') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT result_1.result_value IS NULL) AND (result_1.result_source_key = q1.result_source_key) AND 
                                                         (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key = 41)) AS caco3_lt_2_mm,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 41)) AS caco3_lt_2_mm_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 3)) AS Expr1
                               FROM            (SELECT        result_value, 'S' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                   AND (analyte_key IN (623))
											) AS result_1
                               WHERE        (prep_code = q1.prep_code)) AS caco3_lt_20_mm,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_1.result_value, '3.0') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT result_1.result_value IS NULL) AND (result_1.result_source_key = q1.result_source_key) AND 
                                                         (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key = 485)) AS corrected_gypsum_lt_2_mm,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 485)) AS corrected_gyp_lt_2_mm_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 3)) AS Expr1
                               FROM            (SELECT        result_value, 'S' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                   AND (analyte_key IN (624))
												) AS result_1
                               WHERE        (prep_code = q1.prep_code)) AS gypsum_lt_20_mm,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_1.result_value, '7.0') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT result_1.result_value IS NULL) AND (result_1.result_source_key = q1.result_source_key) AND 
                                                         (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key = 358)) AS resistivity_saturated_paste,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 358)) AS resistivity_sp_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_1.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT result_1.result_value IS NULL) AND (result_1.result_source_key = q1.result_source_key) AND 
                                                         (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key = 348)) AS ca_satx,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 348)) AS ca_satx_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_1.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT result_1.result_value IS NULL) AND (result_1.result_source_key = q1.result_source_key) AND 
                                                         (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key = 353)) AS mg_satx,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 353)) AS mg_satx_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_1.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT result_1.result_value IS NULL) AND (result_1.result_source_key = q1.result_source_key) AND 
                                                         (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key = 788)) AS ca_plus_mg_satx,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 788)) AS ca_plus_mg_satx_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM            (SELECT        result_value, 'S' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                   AND (analyte_key IN (1930))) AS result_1
                               WHERE        (prep_code = q1.prep_code)) AS ca_to_mg_ratio,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_1.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT result_1.result_value IS NULL) AND (result_1.result_source_key = q1.result_source_key) AND 
                                                         (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key = 359)) AS na_satx,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 359)) AS na_satx_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_1.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT result_1.result_value IS NULL) AND (result_1.result_source_key = q1.result_source_key) AND 
                                                         (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key = 357)) AS k_satx,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 357)) AS k_satx_method,

                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_1.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT result_1.result_value IS NULL) AND (result_1.result_source_key = q1.result_source_key) AND 
                                                         (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key = 349)) AS co3_satx,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 349)) AS co3_satx_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_1.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT result_1.result_value IS NULL) AND (result_1.result_source_key = q1.result_source_key) AND 
                                                         (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key = 345)) AS hco3_satx,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 345)) AS hco3_satx_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_1.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT result_1.result_value IS NULL) AND (result_1.result_source_key = q1.result_source_key) AND 
                                                         (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key = 787)) AS co3_plus_hco3_satx,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 787)) AS co3_plus_hco3_satx_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_1.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT result_1.result_value IS NULL) AND (result_1.result_source_key = q1.result_source_key) AND 
                                                         (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key = 350)) AS cl_satx,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 350)) AS cl_satx_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_1.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT result_1.result_value IS NULL) AND (result_1.result_source_key = q1.result_source_key) AND 
                                                         (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key = 352)) AS f_satx,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 352)) AS f_satx_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_1.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT result_1.result_value IS NULL) AND (result_1.result_source_key = q1.result_source_key) AND 
                                                         (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key = 356)) AS po4_satx,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 356)) AS po4_satx_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_1.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT result_1.result_value IS NULL) AND (result_1.result_source_key = q1.result_source_key) AND 
                                                         (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key = 347)) AS br_satx,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 347)) AS br_satx_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_1.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT result_1.result_value IS NULL) AND (result_1.result_source_key = q1.result_source_key) AND 
                                                         (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key = 344)) AS oac_satx,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 344)) AS oac_satx_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_1.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT result_1.result_value IS NULL) AND (result_1.result_source_key = q1.result_source_key) AND 
                                                         (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key = 360)) AS so4_satx,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 360)) AS so4_satx_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_1.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT result_1.result_value IS NULL) AND (result_1.result_source_key = q1.result_source_key) AND 
                                                         (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key = 355)) AS no2_satx,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 355)) AS no2_satx_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_1.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT result_1.result_value IS NULL) AND (result_1.result_source_key = q1.result_source_key) AND 
                                                         (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key = 354)) AS no3_satx,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 354)) AS no3_satx_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_1.result_value, '4.1') AS decimal(10, 2)) AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT result_1.result_value IS NULL) AND (result_1.result_source_key = q1.result_source_key) AND 
                                                         (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key = 361)) AS h20_satx,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 361)) AS h20_satx_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.1') AS decimal(10, 3)) AS Expr1
                               FROM            (SELECT        result_value, 'S' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                   AND (analyte_key IN (570,1030,1522,2096))
                                                         UNION
                                                         SELECT        result_value, 'N' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1171,1329,1523,2097))
                                                         UNION
                                                         SELECT        result_value, 'HM' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1172))
                                                         UNION
                                                         SELECT        result_value, 'GP' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1173))
															) AS result_1
                               WHERE        (prep_code = q1.prep_code)) AS total_estimated_salts_satx,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_1.result_value, '5.2') AS decimal(10, 2)) AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT result_1.result_value IS NULL) AND (result_1.result_source_key = q1.result_source_key) AND 
                                                         (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key = 351)) AS electrical_conductivity_satx,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 351)) AS electrical_cond_satx_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_1.result_value, '5.2') AS decimal(10, 2)) AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT result_1.result_value IS NULL) AND (result_1.result_source_key = q1.result_source_key) AND 
                                                         (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key = 343)) AS ec_predict_one_to_two,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 343)) AS ec_predict_one_to_two_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 3)) AS Expr1
                               FROM            (SELECT        result_value, 'S' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                   AND (analyte_key IN (531,620,651,668,669,670,675,676,677,754,755,756,757,758,759,760,761,762,800,801,1444,1445,1446,1512,1513,1514,1515,1516,1517,1518))
                                                         UNION
                                                         SELECT        result_value, 'N' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1174,1177))
                                                         UNION
                                                         SELECT        result_value, 'M' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1183))
                                                         UNION
                                                         SELECT        result_value, 'HM' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1175,1178))
                                                         UNION
                                                         SELECT        result_value, 'GP' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1176,1179))
														) AS result_1
                               WHERE        (prep_code = q1.prep_code)) AS exchangeable_sodium,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 3)) AS Expr1
                               FROM            (SELECT        result_value, 'S' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                   AND (analyte_key IN (563,636,803,1520,2094))
                                                         UNION
                                                         SELECT        result_value, 'N' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1180,1521,2095))
                                                         UNION
                                                         SELECT        result_value, 'HM' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1181))
                                                         UNION
                                                         SELECT        result_value, 'GP' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1182))
															) AS result_1
                               WHERE        (prep_code = q1.prep_code)) AS sodium_absorption_ratio,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '4.2') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND 
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 482) AS melanic_index,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 482)) AS melanic_index_method,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.0') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND 
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 252) AS new_zealand_phosphorus_retent,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 252)) AS new_zealand_phos_retent_method,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '6.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND 
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 49) AS phosphorus_ammonium_oxalate,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 49)) AS phosphorus_ammonium_oxalate_method,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '4.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND 
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1128) AS phosphorus_anion_resin_one_hr,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '4.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND 
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1129) AS phosphorus_anion_resin_24_hr,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key in (1128,1129))) AS phosphorus_anion_resin_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.1') AS decimal(10, 3)) AS Expr1
                               FROM            (SELECT        result_value, 'S' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                   AND (analyte_key IN (1887))
                                                         UNION
                                                         SELECT        result_value, 'N' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1888))
								) AS result_1
                               WHERE        (prep_code = q1.prep_code)) AS phosphorus_anion_resin_capacit,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '6.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND 
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 249) AS phosphorus_bray1,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 249)) AS phosphorus_bray1_method,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '6.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND 
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 250) AS phosphorus_bray2,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 250)) AS phosphorus_bray2_method,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '6.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND 
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 251) AS phosphorus_citric_acid,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 251)) AS phosphorus_citric_acid_method,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND 
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 483) AS phosphorus_mehlich_3,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 483)) AS phosphorus_mehlich_3_method,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '6.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND 
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 253) AS phosphorus_olsen,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 253)) AS phosphorus_olsen_method,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '6.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND 
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 248) AS phosphorus_water,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 248)) AS phosphorus_water_method,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '6.2') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND 
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 77) AS nitrate_1m_kcl,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 77)) AS nitrate_1m_kcl_method,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key in (1352, 1365, 1366, 1367, 1353, 1354, 1369, 1368, 1355, 1371, 1370, 1372, 1364, 1356, 1373, 1381, 1375, 1376, 1377, 1379, 1357, 1386, 1358, 1359, 1380, 1374, 2098, 1382, 1378, 1383, 1360, 1384, 1385))) AS water_extract_method,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '5.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1352) AS acetate_water_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1365) AS aluminum_water_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1366) AS arsenic_water_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1367) AS barium_water_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '5.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1353) AS boron_water_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '5.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1354) AS bromide_water_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1369) AS cadmium_water_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1368) AS calcium_water_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '5.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1355) AS chloride_water_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1371) AS chromium_water_extractabe,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1370) AS cobalt_water_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1372) AS copper_water_extracable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '5.2') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1364) AS ec_water_extract,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '5.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1356) AS fluoride_water_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1373) AS iron_water_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1381) AS lead_water_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1375) AS magnesium_water_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1376) AS manganese_water_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1377) AS molybdenum_water_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1379) AS nickel_water_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '6.2') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1386) AS nitrate_n_water_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '5.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1357) AS nitrate_water_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '5.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1358) AS nitrite_water_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '5.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1359) AS phosphorus_water_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1380) AS phosphate_water_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1374) AS potassium_water_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 2098) AS selenium_water_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1382) AS silicon_water_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1378) AS sodium_water_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1383) AS strontium_water_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '5.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1360) AS sulfate_water_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1384) AS vanadium_water_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1385) AS zinc_water_extractable,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON result.prep_key = preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result.procedure_key = bridge_proced_ss.procedure_key AND 
                                                         result.source_system_key = bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key in (1331, 1332, 1333, 1335, 1334, 1337, 1336, 1338, 1339, 1346, 1341, 1342, 1349, 1344, 1340, 1347, 1350, 1343, 1351, 1348, 1345))) AS mehlich_3_extractable_method,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1331) AS aluminum_mehlich3_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1332) AS arsenic_mehlich3_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1333) AS barium_mehlich3_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1335) AS cadmium_mehlich3_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1334) AS calcium_mehlich3_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1337) AS chromium_mehlich3_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1336) AS cobalt_mehlich3_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1338) AS copper_mehlich3_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1339) AS iron_mehlich3_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1346) AS lead_mehlich3_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1341) AS magnesium_mehlich3_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1342) AS manganese_mehlich3_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1349) AS molybdenum_mehlich3_extractabl,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1344) AS nickel_mehlich3_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1345) AS phosphorus_mehlich3_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1340) AS potassium_mehlich3_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1347) AS selenium_mehlich3_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1350) AS silicon_mehlich3_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1343) AS sodium_mehlich3_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1351) AS strontium_mehlich3_extractable,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.1') AS decimal(10, 3)))
                            FROM          result, preparation
                            WHERE      result_type = 'layer analyte' AND result_source_key = q1.result_source_key AND result.prep_key = preparation.prep_key AND
                                                   preparation.prep_code = q1.prep_code AND result.analyte_key = 1348) AS zinc_mehlich3_extractable--,

FROM            dbo.Chemical_Properties_List AS q1
GROUP BY result_source_key, prep_code, natural_key








GO

