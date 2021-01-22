USE ncsslabdata;
GO

-------- drop the temp table
DROP TABLE IF EXISTS #temp_results_step2;

-------- create the temp table
CREATE TABLE #temp_results_step2(
 [labsampnum] varchar(10),
 [result_source_key] int NULL,
 [prep_code] varchar(64) NULL,
 [sum_of_nh4_ph_7_Ext_bases] decimal(10, 1) NULL,
 [sum_of_cations_cec_pH_8_2] decimal(10, 1) NULL,
 [ecec_base_plus_aluminum] decimal(10, 1) NULL,
 [aluminum_saturation] decimal(10, 0) NULL,
 [base_sat_sum_of_cations_ph_8_2] decimal(10, 0) NULL,
 [base_sat_nh4oac_ph_7] decimal(10, 0) NULL,
 [estimated_organic_carbon] decimal(10, 1) NULL,
 [carbon_to_nitrogen_ratio] decimal(10, 0) NULL,
 [aluminum_plus_half_iron_oxalat] decimal(10, 2) NULL,
 [caco3_lt_20_mm] decimal(10, 0) NULL,
 [gypsum_lt_20_mm] decimal(10, 0) NULL,
 [ca_to_mg_ratio] decimal(10, 1) NULL,
 [total_estimated_salts_satx] decimal(10, 1) NULL,
 [exchangeable_sodium] decimal(10, 0) NULL,
 [sodium_absorption_ratio] decimal(10, 0) NULL,
 [phosphorus_anion_resin_capacit] decimal(10, 1) NULL)


-------- truncate existing data
TRUNCATE TABLE result_light;

------------- insert data into result_light table
INSERT INTO result_light
            SELECT 
                result_key,
                result_source_key,
                r.prep_key,
                result_type,
                result_reliability,
                r.analyte_key,
                r.procedure_key,
                r.source_system_key,
                REPLACE(result_value, '..', '.') AS result_value,
                p.prep_code,
                b.proced_code
            FROM
                dbo.layer AS l
                INNER JOIN
                    dbo.result AS r
                        ON l.layer_key = r.result_source_key
                INNER JOIN
                    dbo.analyte AS a
                        ON r.analyte_key = a.analyte_key
                LEFT JOIN
                    dbo.preparation AS p
                        ON r.prep_key = p.prep_key
                LEFT JOIN
                    dbo.bridge_proced_ss AS b
                        ON r.procedure_key = b.procedure_key
                           AND r.source_system_key = b.source_system_key
            WHERE
                (
                    result_type = 'layer result'
                    AND r.analyte_key IN (
                                             568, 652, 653, 721, 722, 723, 791, 1291, 1292, 1440, 2099, 1154, 1289,
                                             1442, 1290, 1152, 1288, 1441, 1160, 1161, 1287, 518, 654, 655, 736, 737,
                                             738, 796, 1303, 1304, 1450, 2101, 1157, 1301, 1452, 1302, 1046, 1300,
                                             1451, 1159, 517, 619, 650, 706, 707, 708, 748, 749, 750, 751, 752, 753,
                                             799, 1097, 1313, 1314, 1315, 1316, 1453, 1454, 2026, 2030, 2031, 2032,
                                             2102, 1158, 1309, 1310, 1455, 1456, 2034, 2035, 1311, 1312, 2029, 1048,
                                             1307, 1308, 1457, 1458, 2028, 2033, 11671168, 1305, 1306, 2027, 512, 618,
                                             648, 703, 704, 705, 715, 716, 717, 718, 719, 720, 790, 1096, 1325, 1326,
                                             1327, 1328, 1462, 1463, 2036, 2041, 2042, 2043, 2104, 1153, 1321, 1322,
                                             1466, 1467, 2039, 2045, 1323, 1324, 2040, 1043, 1319, 1320, 1464, 1465,
                                             2038, 2044, 1169, 1170, 1317, 1318, 2037, 514, 658, 659, 660, 661, 662,
                                             663, 664, 665, 724, 728, 730, 731, 732, 792, 1459, 2103, 727, 1155, 1461,
                                             729, 1163, 1164, 725, 513, 666, 667, 733, 734, 735, 793, 1297, 1298, 1447,
                                             2100, 1156, 1295, 1449, 1296, 1045, 1294, 1448, 1165, 1166, 1293, 794,
                                             1070, 1238, 2021, 2022, 559, 647, 1078, 1076, 2086, 1077, 1079, 1071,
                                             1090, 1851, 1072, 1091, 1848, 1095, 1849, 1074, 1093, 1850, 1075, 1094,
                                             1846, 1073, 1092, 1847, 623, 624, 1930, 570, 1030, 1522, 2096, 1171, 1329,
                                             1523, 2097, 1172, 1173, 531, 620, 651, 668, 669, 670, 675, 676, 677, 754,
                                             755, 756, 757, 758, 759, 760, 761, 762, 800, 801, 1444, 1445, 1446, 1512,
                                             1513, 1514, 1515, 1516, 1517, 1518, 1174, 1177, 1183, 1175, 1178, 1176,
                                             1179, 563, 636, 803, 1520, 2094, 1180, 1521, 2095, 1181, 1182, 1887, 1888
                                         )
                ); --AND natural_key = '00P00101'





GO

------------- this step takes 2 minutes -- use select ... INTO  #temp_results_step2 syntax
INSERT INTO #temp_results_step2
    (
        labsampnum,
        result_source_key,
        prep_code,
        sum_of_nh4_ph_7_Ext_bases,
        sum_of_cations_cec_pH_8_2,
        ecec_base_plus_aluminum,
        aluminum_saturation,
        base_sat_sum_of_cations_ph_8_2,
        base_sat_nh4oac_ph_7,
        estimated_organic_carbon,
        carbon_to_nitrogen_ratio,
        aluminum_plus_half_iron_oxalat,
        caco3_lt_20_mm,
        gypsum_lt_20_mm,
        ca_to_mg_ratio,
        total_estimated_salts_satx,
        exchangeable_sodium,
        sodium_absorption_ratio,
        phosphorus_anion_resin_capacit
    )
SELECT
    natural_key      AS labsampnum,
    result_source_key,
    (
        SELECT TOP (1)
            prep_code
        FROM
            result_light AS result
        WHERE
            (
                prep_code IS NOT NULL
                AND (result.result_source_key = q1.result_source_key)
            )
    )
    --(result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) )
                     AS prep_code,

    --Sum_of_nh4_ph_7_Ext_bases (Calc)							

    -- (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.1') AS decimal(10, 2)) AS Expr1
    (
        SELECT TOP (1)
            CAST(ROUND(CAST(result_value AS REAL), 1) AS DECIMAL(10, 1)) AS Expr1
        FROM
            (
                SELECT
                    result.result_value,
                    'S' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (result.analyte_key IN (
                                                   568, 652, 653, 721, 722, 723, 791, 1291, 1292, 1440, 2099
                                               )
                        )
                UNION
                SELECT
                    result.result_value,
                    'N' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1154, 1289, 1442
                                        )
                        )
                UNION
                SELECT
                    result.result_value,
                    'S-SK' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1290
                                        )
                        )
                UNION
                SELECT
                    result.result_value,
                    'M' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1152, 1288, 1441
                                        )
                        )
                UNION
                SELECT
                    result.result_value,
                    'HM' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1160
                                        )
                        )
                UNION
                SELECT
                    result.result_value,
                    'GP' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (result.analyte_key IN (
                                                   1161, 1287
                                               )
                        )
            ) AS result_1
    --WHERE      (prep_code = q1.prep_code)
    )                AS sum_of_nh4_ph_7_Ext_bases,

    ---sum_of_cations_cec_pH_8_2 (calc)
    (
        SELECT TOP (1)
            CAST(ROUND(CAST(result_value AS REAL), 1) AS DECIMAL(10, 1)) AS Expr1

        -- (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.1') AS decimal(10, 2)) AS Expr1
        FROM
            (
                SELECT
                    result.result_value,
                    'S' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (result.analyte_key IN (
                                                   518, 654, 655, 736, 737, 738, 796, 1303, 1304, 1450, 2101
                                               )
                        )
                UNION
                SELECT
                    result.result_value,
                    'N' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1157, 1301, 1452
                                        )
                        )
                UNION
                SELECT
                    result.result_value,
                    'S-SK' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1302
                                        )
                        )
                UNION
                SELECT
                    result.result_value,
                    'M' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1046, 1300, 1451
                                        )
                        )
                UNION
                SELECT
                    result.result_value,
                    'HM' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1159
                                        )
                        )
                UNION
                SELECT
                    result.result_value,
                    'GP' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (result.analyte_key IN (
                                                   1162, 1299
                                               )
                        )
            ) AS result_1
    --  WHERE 
    --    (prep_code = q1.prep_code)
    )                AS sum_of_cations_cec_pH_8_2,

    --ecec_base_plus_aluminum  (Calc) 

    (
        SELECT TOP (1)
            CAST(ROUND(CAST(result_value AS REAL), 1) AS DECIMAL(10, 1)) AS Expr1
        --	(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.1') AS decimal(10, 2)) AS Expr1
        FROM
            (
                SELECT
                    result.result_value,
                    'S' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (result.analyte_key IN (
                                                   517, 619, 650, 706, 707, 708, 748, 749, 750, 751, 752, 753, 799,
                                                   1097, 1313, 1314, 1315, 1316, 1453, 1454, 2026, 2030, 2031, 2032,
                                                   2102
                                               )
                        )
                UNION
                SELECT
                    result.result_value,
                    'N' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1158, 1309, 1310, 1455, 1456, 2034, 2035
                                        )
                        )
                UNION
                SELECT
                    result.result_value,
                    'S-SK' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1311, 1312, 2029
                                        )
                        )
                UNION
                SELECT
                    result.result_value,
                    'M' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1048, 1307, 1308, 1457, 1458, 2028, 2033
                                        )
                        )
                UNION
                SELECT
                    result.result_value,
                    'HM' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1167
                                        )
                        )
                UNION
                SELECT
                    result.result_value,
                    'GP' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (result.analyte_key IN (
                                                   1168, 1305, 1306, 2027
                                               )
                        )
            ) AS result_1
    --WHERE        (prep_code = q1.prep_code)
    )                AS ecec_base_plus_aluminum,

    --aluminum_saturation (calc)						

    (
        SELECT TOP (1)
            CAST(ROUND(CAST(result_value AS REAL), 0) AS DECIMAL(10, 0)) AS Expr1
        -- (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 2)) AS Expr1
        FROM
            (
                SELECT
                    result.result_value,
                    'S' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (result.analyte_key IN (
                                                   512, 618, 648, 703, 704, 705, 715, 716, 717, 718, 719, 720, 790,
                                                   1096, 1325, 1326, 1327, 1328, 1462, 1463, 2036, 2041, 2042, 2043,
                                                   2104
                                               )
                        )
                UNION
                SELECT
                    result.result_value,
                    'N' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1153, 1321, 1322, 1466, 1467, 2039, 2045
                                        )
                        )
                UNION
                SELECT
                    result.result_value,
                    'S-SK' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1323, 1324, 2040
                                        )
                        )
                UNION
                SELECT
                    result.result_value,
                    'M' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1043, 1319, 1320, 1464, 1465, 2038, 2044
                                        )
                        )
                UNION
                SELECT
                    result.result_value,
                    'HM' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1169
                                        )
                        )
                UNION
                SELECT
                    result.result_value,
                    'GP' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (result.analyte_key IN (
                                                   1170, 1317, 1318, 2037
                                               )
                        )
            ) AS result_1
    --WHERE         (prep_code = q1.prep_code)
    )                AS aluminum_saturation,

    ---base_sat_sum_of_cations_ph_8_2 (calc)				
    (
        SELECT TOP (1)
            CAST(ROUND(CAST(result_value AS REAL), 0) AS DECIMAL(10, 0)) AS Expr1

        -- (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 2)) AS Expr1
        FROM
            (
                SELECT
                    result.result_value,
                    'S' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (result.analyte_key IN (
                                                   514, 658, 659, 660, 661, 662, 663, 664, 665, 724, 728, 730, 731,
                                                   732, 792, 1459, 2103
                                               )
                        )
                UNION
                SELECT
                    result.result_value,
                    'N' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            727, 1155, 1461
                                        )
                        )
                UNION
                SELECT
                    result.result_value,
                    'S-SK' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            729
                                        )
                        )
                UNION
                SELECT
                    result.result_value,
                    'M' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            726, 1044, 1460
                                        )
                        )
                UNION
                SELECT
                    result.result_value,
                    'HM' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1163
                                        )
                        )
                UNION
                SELECT
                    result.result_value,
                    'GP' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (result.analyte_key IN (
                                                   1164, 725
                                               )
                        )
            ) AS result_1
    --WHERE       (prep_code = q1.prep_code)
    )                AS base_sat_sum_of_cations_ph_8_2,

    --base_sat_nh4oac_ph_7 (calc) 

    (
        SELECT TOP (1)
            CAST(ROUND(CAST(result_value AS REAL), 0) AS DECIMAL(10, 0)) AS Expr1
        --(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 2)) AS Expr1
        FROM
            (
                SELECT
                    result.result_value,
                    'S' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (result.analyte_key IN (
                                                   513, 666, 667, 733, 734, 735, 793, 1297, 1298, 1447, 2100
                                               )
                        )
                UNION
                SELECT
                    result.result_value,
                    'N' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1156, 1295, 1449
                                        )
                        )
                UNION
                SELECT
                    result.result_value,
                    'S-SK' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1296
                                        )
                        )
                UNION
                SELECT
                    result.result_value,
                    'M' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1045, 1294, 1448
                                        )
                        )
                UNION
                SELECT
                    result.result_value,
                    'HM' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1165
                                        )
                        )
                UNION
                SELECT
                    result.result_value,
                    'GP' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (result.analyte_key IN (
                                                   1166, 1293
                                               )
                        )
            ) AS result_1
    --WHERE     (prep_code = q1.prep_code)
    )                AS base_sat_nh4oac_ph_7,

    ---estimated_organic_carbon (calc)														 

    (
        SELECT TOP (1)
            CAST(ROUND(CAST(result_value AS REAL), 1) AS DECIMAL(10, 1)) AS Expr1
        -- (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.1') AS decimal(10, 3)) AS Expr1
        FROM
            (
                SELECT
                    result.result_value,
                    'S' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (result.analyte_key IN (
                                                   794, 1070, 1238
                                               )
                        )
                UNION
                SELECT
                    result.result_value,
                    'N' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            2021
                                        )
                        )
                UNION
                SELECT
                    result.result_value,
                    'GP' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (result.analyte_key IN (
                                                   2022
                                               )
                        )
            ) AS result_1
    -- WHERE        (prep_code = q1.prep_code)
    )                AS estimated_organic_carbon,

    --carbon_to_nitrogen_ratio (calc)
    (
        SELECT TOP (1)
            CAST(ROUND(CAST(result_value AS REAL), 0) AS DECIMAL(10, 0)) AS Expr1
        --(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 3)) AS Expr1
        FROM
            (
                SELECT
                    result.result_value,
                    'S' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (result.analyte_key IN (
                                                   559, 647
                                               )
                        )
                UNION
                SELECT
                    result.result_value,
                    'M' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (analyte_key = 1078)
                UNION
                SELECT
                    result.result_value,
                    'N' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1076, 2086
                                        )
                        )
                UNION
                SELECT
                    result.result_value,
                    'GP' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (analyte_key = 1077)
                UNION
                SELECT
                    result.result_value,
                    'HM' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (result.analyte_key = 1079)
            ) AS result_1
    --WHERE        (prep_code = q1.prep_code)
    )                AS carbon_to_nitrogen_ratio,

    --aluminum_plus_half_iron_oxalat (calc)
    (
        SELECT TOP (1)
            CAST(ROUND(CAST(result_value AS REAL), 2) AS DECIMAL(10, 2)) AS Expr1
        -- (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '5.2') AS decimal(10, 3)) AS Expr1
        FROM
            (
                SELECT
                    result.result_value,
                    'S' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (result.analyte_key IN (
                                                   1071, 1090, 1851
                                               )
                        )
                UNION
                SELECT
                    result.result_value,
                    'M' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1072, 1091, 1848
                                        )
                        )
                UNION
                SELECT
                    result.result_value,
                    'MW' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1095, 1849
                                        )
                        )
                UNION
                SELECT
                    result.result_value,
                    'N' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1074, 1093, 1850
                                        )
                        )
                UNION
                SELECT
                    result.result_value,
                    'GP' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1075, 1094, 1846
                                        )
                        )
                UNION
                SELECT
                    result.result_value,
                    'HM' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (result.analyte_key IN (
                                                   1073, 1092, 1847
                                               )
                        )
            ) AS result_1
    --WHERE        (prep_code = q1.prep_code)
    )                AS aluminum_plus_half_iron_oxalat,

    --caco3_lt_20_mm (calc)
    (
        SELECT TOP (1)
            CAST(ROUND(CAST(result_value AS REAL), 0) AS DECIMAL(10, 0)) AS Expr1
        --	(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 3)) AS Expr1
        FROM
            (
                SELECT
                    result.result_value,
                    'S' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (result.analyte_key IN (
                                                   623
                                               )
                        )
            ) AS result_1
    -- WHERE        (prep_code = q1.prep_code)
    )                AS caco3_lt_20_mm,

    --gypsum_lt_20_mm (calc) 
    (
        SELECT TOP (1)
            CAST(ROUND(CAST(result_value AS REAL), 0) AS DECIMAL(10, 0)) AS Expr1
        --	(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 3)) AS Expr1
        FROM
            (
                SELECT
                    result.result_value,
                    'S' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (result.analyte_key IN (
                                                   624
                                               )
                        )
            ) AS result_1
    )                AS gypsum_lt_20_mm,

    --ca_to_mg_ratio (Calc)
    (
        SELECT TOP (1)
            CAST(ROUND(CAST(result_value AS REAL), 1) AS DECIMAL(10, 1)) AS Expr1
        --(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '5.1') AS decimal(10, 2)) AS Expr1
        FROM
            (
                SELECT
                    result.result_value --, 'S' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (result.analyte_key IN (
                                                   1930
                                               )
                        )
            ) AS result_1
    )                AS ca_to_mg_ratio,

    --total_estimated_salts_satx (Calc)
    (
        SELECT TOP (1)
            CAST(ROUND(CAST(result_value AS REAL), 1) AS DECIMAL(10, 1)) AS Expr1
        --(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.1') AS decimal(10, 3)) AS Expr1
        FROM
            (
                SELECT
                    result.result_value,
                    'S' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (result.analyte_key IN (
                                                   570, 1030, 1522, 2096
                                               )
                        )
                UNION
                SELECT
                    result.result_value,
                    'N' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1171, 1329, 1523, 2097
                                        )
                        )
                UNION
                SELECT
                    result.result_value,
                    'HM' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1172
                                        )
                        )
                UNION
                SELECT
                    result.result_value,
                    'GP' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (result.analyte_key IN (
                                                   1173
                                               )
                        )
            ) AS result_1
    -- WHERE       (prep_code = q1.prep_code)
    )                AS total_estimated_salts_satx,

    --exchangeable_sodium (Calc) --Recheck above if still not working
    (
        SELECT TOP (1)
            CAST(ROUND(CAST(result_value AS REAL), 0) AS DECIMAL(10, 0)) AS Expr1
        --(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 3)) AS Expr1
        FROM
            (
                SELECT
                    result.result_value,
                    'S' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (result.analyte_key IN (
                                                   531, 620, 651, 668, 669, 670, 675, 676, 677, 754, 755, 756, 757,
                                                   758, 759, 760, 761, 762, 800, 801, 1444, 1445, 1446, 1512, 1513,
                                                   1514, 1515, 1516, 1517, 1518
                                               )
                        )
                UNION
                SELECT
                    result.result_value,
                    'N' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1174, 1177
                                        )
                        )
                UNION
                SELECT
                    result.result_value,
                    'M' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1183
                                        )
                        )
                UNION
                SELECT
                    result.result_value,
                    'HM' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1175, 1178
                                        )
                        )
                UNION
                SELECT
                    result.result_value,
                    'GP' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (result.analyte_key IN (
                                                   1176, 1179
                                               )
                        )
            ) AS result_1
    --WHERE       (prep_code = q1.prep_code)
    )                AS exchangeable_sodium,

    --sodium_absorption_ratio (Calc)
    (
        SELECT TOP (1)
            CAST(ROUND(CAST(result_value AS REAL), 0) AS DECIMAL(10, 0)) AS Expr1
        --(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 3)) AS Expr1
        FROM
            (
                SELECT
                    result.result_value,
                    'S' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (result.analyte_key IN (
                                                   563, 636, 803, 1520, 2094
                                               )
                        )
                UNION
                SELECT
                    result.result_value,
                    'N' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1180, 1521, 2095
                                        )
                        )
                UNION
                SELECT
                    result.result_value,
                    'HM' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1181
                                        )
                        )
                UNION
                SELECT
                    result.result_value,
                    'GP' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (result.analyte_key IN (
                                                   1182
                                               )
                        )
            ) AS result_1
    --WHERE      (prep_code = q1.prep_code)
    )                AS sodium_absorption_ratio,

    --phosphorus_anion_resin_capacito (Calc)
    (
        SELECT TOP (1)
            CAST(ROUND(CAST(result_value AS REAL), 1) AS DECIMAL(10, 1)) AS Expr1
        --(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.1') AS decimal(10, 3)) AS Expr1
        FROM
            (
                SELECT
                    result.result_value,
                    'S' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (result.analyte_key IN (
                                                   1887
                                               )
                        )
                UNION
                SELECT
                    result.result_value,
                    'N' AS prep_code
                FROM
                    result_light AS result
                WHERE
                    (result.result_type = 'layer result')
                    AND (result.result_value <> '')
                    AND (NOT (result.result_value IS NULL))
                    AND (result.result_source_key = q1.result_source_key)
                    AND (result.analyte_key IN (
                                                   1888
                                               )
                        )
            ) AS result_1
    )                AS phosphorus_anion_resin_capacit
FROM
    dbo.layer
    INNER JOIN
        result_light AS q1
            ON dbo.layer.layer_key = q1.result_source_key;



----------- this is needed for a different step - temporary table in ncsslabdata database - will be dropped when all steps are complete
DROP TABLE IF EXISTS lab_chemical_properties_layer_results_1;
SELECT DISTINCT
    labsampnum,
    result_source_key,
    prep_code,
    sum_of_nh4_ph_7_Ext_bases,
    sum_of_cations_cec_pH_8_2,
    ecec_base_plus_aluminum,
    aluminum_saturation,
    base_sat_sum_of_cations_ph_8_2,
    base_sat_nh4oac_ph_7,
    estimated_organic_carbon,
    carbon_to_nitrogen_ratio,
    aluminum_plus_half_iron_oxalat,
    caco3_lt_20_mm,
    gypsum_lt_20_mm,
    ca_to_mg_ratio,
    total_estimated_salts_satx,
    exchangeable_sodium,
    sodium_absorption_ratio,
    phosphorus_anion_resin_capacit
INTO
    lab_chemical_properties_layer_results_1
FROM
    #temp_results_step2;

CREATE INDEX lab_chemical_properties_layer_results_1_idx1c
    ON lab_chemical_properties_layer_results_1 (labsampnum, result_source_key)
    INCLUDE (prep_code);
CREATE INDEX lab_chemical_properties_layer_results_1_result_source_key_idx2
    ON lab_chemical_properties_layer_results_1 (result_source_key);
CREATE INDEX lab_chemical_properties_layer_results_1_prep_code_idx5
    ON lab_chemical_properties_layer_results_1 (prep_code);

GO
