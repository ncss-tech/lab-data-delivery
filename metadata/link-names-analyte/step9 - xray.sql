USE ncsslabdata;
GO

----------- insert data into temp #result_light table
drop TABLE IF EXISTS #result_light;

	  CREATE TABLE #result_light(result_key INT NOT NULL  , result_source_key INT, 
	  prep_key int,  result_type VARCHAR(128), result_reliability VARCHAR(20), 
	  analyte_key int, procedure_key int, source_system_key int, result_value VARCHAR(128) , 
	  prep_code VARCHAR(64) , proced_code VARCHAR(12), analyzed_size_frac VARCHAR(128)
	   CONSTRAINT pk_result_light PRIMARY KEY CLUSTERED (result_key)
	  )
	  go

	  INSERT INTO #result_light 
	  SELECT result_key, result_source_key, r.prep_key,  result_type, result_reliability, r.analyte_key, r.procedure_key, r.source_system_key,   result_value, p.prep_code  , b.proced_code, r.analyzed_size_frac
FROM  dbo.layer AS l
INNER JOIN dbo.result AS r ON l.layer_key = r.result_source_key 
INNER JOIN dbo.analyte AS a ON r.analyte_key = a.analyte_key 
LEFT JOIN dbo.preparation AS p ON r.prep_key = p.prep_key 
LEFT JOIN dbo.bridge_proced_ss AS b ON r.procedure_key = b.procedure_key AND 
                         r.source_system_key = b.source_system_key
            WHERE  (r.analyte_key IN (397, 398, 399, 400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416, 417, 418, 419, 420, 421, 422, 423, 424, 
                         425, 426, 427, 428, 429, 430, 431, 432, 433, 434, 435, 436, 437, 438, 439, 440, 441, 442, 443, 444, 445, 446, 447, 448, 449, 450, 811, 812, 813, 42, 43, 364, 365, 366, 
                         367, 809, 810, 814, 815, 816, 1122, 1123, 1201, 1205, 1231, 1242, 1751, 1758, 1759, 1760, 1881, 2085, 2157, 2158, 2159, 2160, 2161, 2162, 2163, 2172, 1099, 1433, 
                         1524, 1525, 1883, 1885, 1886, 1884, 1148, 1149, 1150, 1185, 1186, 1187, 1434, 1435, 1436)) AND (r.result_reliability IS NULL OR
                         r.result_reliability = '0')

	CREATE INDEX  result_light_idx1c ON #result_light (analyte_key, result_type, result_source_key,  result_reliability) INCLUDE (result_value, proced_code,prep_code)
	CREATE INDEX  result_light_idx1b ON  #result_light (analyte_key,  result_reliability)
	CREATE INDEX  result_light_result_source_key_idx2 ON  #result_light (result_source_key )
	CREATE INDEX result_light_prep_key_idx3 ON  #result_light (prep_key)
	CREATE INDEX result_source_system_key_idx4 ON #result_light (source_system_key)
	CREATE INDEX result_light_prep_code_idx5 ON  #result_light (prep_code)


GO

------ drop temp table
DROP TABLE IF EXISTS #temp_results_step9;

SELECT
    natural_key       AS labsampnum,
    result_source_key,
    prep_code,
    analyzed_size_frac,
    (
        SELECT TOP (1)
            ISNULL(dbo.bridge_proced_ss.proced_code, '') AS Expr1
        FROM
            #result_light
            INNER JOIN
                dbo.preparation
                    ON #result_light.prep_key = dbo.preparation.prep_key
            LEFT OUTER JOIN
                dbo.bridge_proced_ss
                    ON #result_light.procedure_key = dbo.bridge_proced_ss.procedure_key
                       AND #result_light.source_system_key = dbo.bridge_proced_ss.source_system_key
        WHERE
            (#result_light.result_type = 'layer analyte')
            AND (#result_light.result_value <> '')
            AND (NOT (#result_light.result_value IS NULL))
            AND (#result_light.result_source_key = q1.result_source_key)
            AND (dbo.preparation.prep_code = q1.prep_code)
            AND (
                    #result_light.result_reliability IS NULL
                    OR #result_light.result_reliability = '0'
                )
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (#result_light.analyte_key IN (
                                                 397, 398, 399, 400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410,
                                                 411, 412, 413, 414, 415, 416, 417, 418, 419, 420, 421, 422, 423, 424,
                                                 425, 426, 427, 428, 429, 430, 431, 432, 433, 434, 435, 436, 437, 438,
                                                 439, 440, 441, 442, 443, 444, 445, 446, 447, 448, 449, 450, 811, 812,
                                                 813, 1122, 1123, 1201, 1231, 1242, 1751, 2085, 2172
                                             )
                )
    )                 AS X_Ray_Method,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_70
            LEFT JOIN
                preparation
                    ON result_70.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 397)
    )                 AS AM_Amphibole_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_69
            LEFT JOIN
                preparation
                    ON result_69.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 398)
    )                 AS LC_Anacime_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_68
            LEFT JOIN
                preparation
                    ON result_68.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 399)
    )                 AS AE_Anatase_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_67
            LEFT JOIN
                preparation
                    ON result_67.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 400)
    )                 AS AG_Antigoite_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_66
            LEFT JOIN
                preparation
                    ON result_66.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 401)
    )                 AS AO_Aragonite_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_65
            LEFT JOIN
                preparation
                    ON result_65.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 402)
    )                 AS BT_Biotite_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_64
            LEFT JOIN
                preparation
                    ON result_64.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 403)
    )                 AS BC_Biotite_Chlorite_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_63
            LEFT JOIN
                preparation
                    ON result_63.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 404)
    )                 AS BR_Brucite_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_62
            LEFT JOIN
                preparation
                    ON result_62.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 405)
    )                 AS CA_Calcite_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_61
            LEFT JOIN
                preparation
                    ON result_61.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 406)
    )                 AS CL_Chlorite_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_60
            LEFT JOIN
                preparation
                    ON result_60.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 407)
    )                 AS CM_Chlorite_Mica_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_59
            LEFT JOIN
                preparation
                    ON result_59.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 408)
    )                 AS CR_Cristobalite_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_58
            LEFT JOIN
                preparation
                    ON result_58.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 409)
    )                 AS DL_Dolomite_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_57
            LEFT JOIN
                preparation
                    ON result_57.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 410)
    )                 AS EN_Enstatite_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_56
            LEFT JOIN
                preparation
                    ON result_56.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 411)
    )                 AS FD_Feldspar_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_55
            LEFT JOIN
                preparation
                    ON result_55.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 412)
    )                 AS GI_Gibbsite_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_54
            LEFT JOIN
                preparation
                    ON result_54.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 413)
    )                 AS GL_Glauconite_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_53
            LEFT JOIN
                preparation
                    ON result_53.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 414)
    )                 AS GE_Geothite_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_52
            LEFT JOIN
                preparation
                    ON result_52.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 415)
    )                 AS GY_Gypsum_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_51
            LEFT JOIN
                preparation
                    ON result_51.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 416)
    )                 AS KH_Halloysite_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_50
            LEFT JOIN
                preparation
                    ON result_50.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 417)
    )                 AS HE_Hematite_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_49
            LEFT JOIN
                preparation
                    ON result_49.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 418)
    )                 AS HN_Hornblende_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_48
            LEFT JOIN
                preparation
                    ON result_48.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 419)
    )                 AS HB_Hydrobiotite_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_47
            LEFT JOIN
                preparation
                    ON result_47.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 420)
    )                 AS IL_Illite_Hydromuscovite_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_46
            LEFT JOIN
                preparation
                    ON result_46.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 421)
    )                 AS KK_Kaolinite_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_45
            LEFT JOIN
                preparation
                    ON result_45.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 422)
    )                 AS FL_Labradorite_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_44
            LEFT JOIN
                preparation
                    ON result_44.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 423)
    )                 AS LE_Lepidocrocite_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_43
            LEFT JOIN
                preparation
                    ON result_43.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 424)
    )                 AS MH_Maghemite_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_42
            LEFT JOIN
                preparation
                    ON result_42.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 425)
    )                 AS MG_Magnetite_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_41
            LEFT JOIN
                preparation
                    ON result_41.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 426)
    )                 AS MI_Mica_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_40
            LEFT JOIN
                preparation
                    ON result_40.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 427)
    )                 AS MT_Montmorillonite_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_39
            LEFT JOIN
                preparation
                    ON result_39.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 428)
    )                 AS MC_Montmorillonite_Chlorite_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_38
            LEFT JOIN
                preparation
                    ON result_38.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 429)
    )                 AS MM_Montmorillonite_Mica_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_37
            LEFT JOIN
                preparation
                    ON result_37.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 430)
    )                 AS MV_Montmorillonite_Vermiculite_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_36
            LEFT JOIN
                preparation
                    ON result_36.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 431)
    )                 AS MS_Muscovite_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_35
            LEFT JOIN
                preparation
                    ON result_35.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 432)
    )                 AS NX_Non_Crystalline_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_34
            LEFT JOIN
                preparation
                    ON result_34.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 433)
    )                 AS FO_Oligoclase_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_33
            LEFT JOIN
                preparation
                    ON result_33.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 434)
    )                 AS FR_Orthoclase_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_32
            LEFT JOIN
                preparation
                    ON result_32.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 435)
    )                 AS PG_Palygorskite_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_31
            LEFT JOIN
                preparation
                    ON result_31.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 436)
    )                 AS PL_Phlogophite_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_30
            LEFT JOIN
                preparation
                    ON result_30.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 437)
    )                 AS FP_Plagioclase_Feldspar_X_Ra,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_29
            LEFT JOIN
                preparation
                    ON result_29.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 438)
    )                 AS FK_Potassium_Feldspar_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_28
            LEFT JOIN
                preparation
                    ON result_28.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 439)
    )                 AS PY_Pyrophyllite_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_27
            LEFT JOIN
                preparation
                    ON result_27.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 440)
    )                 AS QZ_Quartz_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_26
            LEFT JOIN
                preparation
                    ON result_26.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 441)
    )                 AS RE_Resistant_Minerals_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_25
            LEFT JOIN
                preparation
                    ON result_25.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 442)
    )                 AS SE_Sepiolite_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_24
            LEFT JOIN
                preparation
                    ON result_24.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 443)
    )                 AS TA_Talc_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_23
            LEFT JOIN
                preparation
                    ON result_23.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 444)
    )                 AS TH_Thenardite_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_22
            LEFT JOIN
                preparation
                    ON result_22.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 445)
    )                 AS TD_Tridymite_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_21
            LEFT JOIN
                preparation
                    ON result_21.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 446)
    )                 AS VR_Vermiculite_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_20
            LEFT JOIN
                preparation
                    ON result_20.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 447)
    )                 AS VC_Vermiculite_Chlorite_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_19
            LEFT JOIN
                preparation
                    ON result_19.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 448)
    )                 AS VH_Vermiculite_Hydrobiotite_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_18
            LEFT JOIN
                preparation
                    ON result_18.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 449)
    )                 AS VM_Vermiculite_Mica_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_17
            LEFT JOIN
                preparation
                    ON result_17.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 450)
    )                 AS ZE_Zeolite_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_16
            LEFT JOIN
                preparation
                    ON result_16.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 811)
    )                 AS HA_Halite_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_15
            LEFT JOIN
                preparation
                    ON result_15.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 812)
    )                 AS HS_Hydroxy_Interlayered_Smectite_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_14
            LEFT JOIN
                preparation
                    ON result_14.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 813)
    )                 AS HV_Hydroxy_Interlayered_Vermiculite_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_15
            LEFT JOIN
                preparation
                    ON result_15.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 1122)
    )                 AS FT_Fluorapatite_XRay,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_14
            LEFT JOIN
                preparation
                    ON result_14.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 1123)
    )                 AS NU_Natrojarosite_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_16
            LEFT JOIN
                preparation
                    ON result_16.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 1201)
    )                 AS HA_PT_Paragonite_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_75
            LEFT JOIN
                preparation
                    ON result_75.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 1231)
    )                 AS NA_Natron_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_74
            LEFT JOIN
                preparation
                    ON result_74.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 1242)
    )                 AS JO_Jarosite_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_73
            LEFT JOIN
                preparation
                    ON result_73.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 1751)
    )                 AS SZ_Serpentine_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_72
            LEFT JOIN
                preparation
                    ON result_72.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 2085)
    )                 AS BE_Boehmite_X_Ray,
    (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_71
            LEFT JOIN
                preparation
                    ON result_71.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 2172)
    )                 AS BD_Beidellite_X_Ray,
    (
        SELECT TOP (1)
            result_value AS Expr1
        FROM
            (
                SELECT
                    result_value,
                    'S'         AS prep_code,
                    '<0.002 mm' AS analyzed_size_frac
                FROM
                    #result_light
                WHERE
                    (result_type = 'layer result')
                    AND (result_value <> '')
                    AND (NOT (result_value IS NULL))
                    AND (result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1099, 1524, 1884
                                        )
                        )
                UNION
                SELECT
                    result_value,
                    'N'         AS prep_code,
                    '<0.002 mm' AS analyzed_size_frac
                FROM
                    #result_light
                WHERE
                    (result_type = 'layer result')
                    AND (result_value <> '')
                    AND (NOT (result_value IS NULL))
                    AND (result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1883, 1886
                                        )
                        )
                UNION
                SELECT
                    result_value,
                    'GP'        AS prep_code,
                    '<0.002 mm' AS analyzed_size_frac
                FROM
                    #result_light
                WHERE
                    (result_type = 'layer result')
                    AND (result_value <> '')
                    AND (NOT (result_value IS NULL))
                    AND (result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1433, 1525, 1885
                                        )
                        )
            ) AS result_1
        WHERE
            (prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
    )                 AS Clay_Mineral_Interpretation,
    (
        SELECT TOP (1)
            result_value AS Expr1
        FROM
            (
                SELECT
                    result_value,
                    'S'            AS prep_code,
                    '0.02-0.05 mm' AS analyzed_size_frac
                FROM
                    #result_light
                WHERE
                    (result_type = 'layer result')
                    AND (result_value <> '')
                    AND (NOT (result_value IS NULL))
                    AND (result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1148
                                        )
                        )
                UNION
                SELECT
                    result_value,
                    'N'            AS prep_code,
                    '0.02-0.05 mm' AS analyzed_size_frac
                FROM
                    #result_light
                WHERE
                    (result_type = 'layer result')
                    AND (result_value <> '')
                    AND (NOT (result_value IS NULL))
                    AND (result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1185
                                        )
                        )
                UNION
                SELECT
                    result_value,
                    'GP'           AS prep_code,
                    '0.02-0.05 mm' AS analyzed_size_frac
                FROM
                    #result_light
                WHERE
                    (result_type = 'layer result')
                    AND (result_value <> '')
                    AND (NOT (result_value IS NULL))
                    AND (result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1434
                                        )
                        )
            ) AS result_1
        WHERE
            (prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
    )                 AS Coarse_Silt_Mineral_Interpretation,
    (
        SELECT TOP (1)
            result_value AS Expr1
        FROM
            (
                SELECT
                    result_value,
                    'S'           AS prep_code,
                    '0.1-0.25 mm' AS analyzed_size_frac
                FROM
                    #result_light
                WHERE
                    (result_type = 'layer result')
                    AND (result_value <> '')
                    AND (NOT (result_value IS NULL))
                    AND (result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1149
                                        )
                        )
                UNION
                SELECT
                    result_value,
                    'N'           AS prep_code,
                    '0.1-0.25 mm' AS analyzed_size_frac
                FROM
                    #result_light
                WHERE
                    (result_type = 'layer result')
                    AND (result_value <> '')
                    AND (NOT (result_value IS NULL))
                    AND (result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1186
                                        )
                        )
                UNION
                SELECT
                    result_value,
                    'GP'          AS prep_code,
                    '0.1-0.25 mm' AS analyzed_size_frac
                FROM
                    #result_light
                WHERE
                    (result_type = 'layer result')
                    AND (result_value <> '')
                    AND (NOT (result_value IS NULL))
                    AND (result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1435
                                        )
                        )
            ) AS result_1
        WHERE
            (prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
    )                 AS Fine_Sand_Mineral_Interpretation,
    (
        SELECT TOP (1)
            result_value AS Expr1
        FROM
            (
                SELECT
                    result_value,
                    'S'           AS prep_code,
                    '0.05-0.1 mm' AS analyzed_size_frac
                FROM
                    #result_light
                WHERE
                    (result_type = 'layer result')
                    AND (result_value <> '')
                    AND (NOT (result_value IS NULL))
                    AND (result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1150
                                        )
                        )
                UNION
                SELECT
                    result_value,
                    'N'           AS prep_code,
                    '0.05-0.1 mm' AS analyzed_size_frac
                FROM
                    #result_light
                WHERE
                    (result_type = 'layer result')
                    AND (result_value <> '')
                    AND (NOT (result_value IS NULL))
                    AND (result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1187
                                        )
                        )
                UNION
                SELECT
                    result_value,
                    'GP'          AS prep_code,
                    '0.05-0.1 mm' AS analyzed_size_frac
                FROM
                    #result_light
                WHERE
                    (result_type = 'layer result')
                    AND (result_value <> '')
                    AND (NOT (result_value IS NULL))
                    AND (result_source_key = q1.result_source_key)
                    AND (analyte_key IN (
                                            1436
                                        )
                        )
            ) AS result_1
        WHERE
            (prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
    )                 AS Very_Fine_Sand_Mineral_Interpretation,
    (
        SELECT TOP (1)
            ISNULL(bridge_proced_ss_2.proced_code, '') AS Expr1
        FROM
            #result_light AS result_13
            INNER JOIN
                dbo.preparation AS preparation_2
                    ON result_13.prep_key = preparation_2.prep_key
            LEFT OUTER JOIN
                dbo.bridge_proced_ss AS bridge_proced_ss_2
                    ON result_13.procedure_key = bridge_proced_ss_2.procedure_key
                       AND result_13.source_system_key = bridge_proced_ss_2.source_system_key
        WHERE
            (result_13.result_type = 'layer analyte')
            AND (result_13.result_value <> '')
            AND (NOT (result_13.result_value IS NULL))
            AND (result_13.result_source_key = q1.result_source_key)
            AND (preparation_2.prep_code = q1.prep_code)
            AND (
                    result_13.result_reliability IS NULL
                    OR result_13.result_reliability = '0'
                )
            AND (result_13.analyte_key IN (
                                              42, 43, 2157, 2158, 2159, 2160, 2161, 2162, 2163
                                          )
                )
    )                 AS Differential_Scanning_Calorimeter_Method,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(3, 0)) AS Expr1
        FROM
            #result_light AS result_12
            LEFT JOIN
                preparation
                    ON result_12.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key IN (
                                    42
                                )
                )
    )                 AS GI_Gibbsite_Differential_Scanning_Calorimetry,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(3, 0)) AS Expr1
        FROM
            #result_light AS result_12
            LEFT JOIN
                preparation
                    ON result_12.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key IN (
                                    43
                                )
                )
    )                 AS KK_Kaolinite_Differential_Scanning_Calorimetry,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(3, 0)) AS Expr1
        FROM
            #result_light AS result_12
            LEFT JOIN
                preparation
                    ON result_12.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key IN (
                                    2157
                                )
                )
    )                 AS GE_Geothite_Differential_Scanning_Calorimetry,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(3, 0)) AS Expr1
        FROM
            #result_light AS result_12
            LEFT JOIN
                preparation
                    ON result_12.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key IN (
                                    2158
                                )
                )
    )                 AS GY_Gypsum_Differential_Scanning_Calorimetry,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(3, 0)) AS Expr1
        FROM
            #result_light AS result_12
            LEFT JOIN
                preparation
                    ON result_12.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key IN (
                                    2159
                                )
                )
    )                 AS AT_Alunite_Differential_Scanning_Calorimetry,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(3, 0)) AS Expr1
        FROM
            #result_light AS result_12
            LEFT JOIN
                preparation
                    ON result_12.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key IN (
                                    2160
                                )
                )
    )                 AS SM_Smectite_Differential_Scanning_Calorimetry,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(3, 0)) AS Expr1
        FROM
            #result_light AS result_12
            LEFT JOIN
                preparation
                    ON result_12.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key IN (
                                    2161
                                )
                )
    )                 AS KH_Halloysite_Differential_Scanning_Calorimetry,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(3, 0)) AS Expr1
        FROM
            #result_light AS result_12
            LEFT JOIN
                preparation
                    ON result_12.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key IN (
                                    2162
                                )
                )
    )                 AS QZ_Quartz_Differential_Scanning_Calorimetry,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(3, 0)) AS Expr1
        FROM
            #result_light AS result_12
            LEFT JOIN
                preparation
                    ON result_12.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key IN (
                                    2163
                                )
                )
    )                 AS VR_Vermiculite_Differential_Calorimetry,
    (
        SELECT TOP (1)
            ISNULL(bridge_proced_ss_1.proced_code, '') AS Expr1
        FROM
            #result_light AS result_10
            INNER JOIN
                dbo.preparation AS preparation_1
                    ON result_10.prep_key = preparation_1.prep_key
            LEFT OUTER JOIN
                dbo.bridge_proced_ss AS bridge_proced_ss_1
                    ON result_10.procedure_key = bridge_proced_ss_1.procedure_key
                       AND result_10.source_system_key = bridge_proced_ss_1.source_system_key
        WHERE
            (result_10.result_type = 'layer analyte')
            AND (result_10.result_value <> '')
            AND (NOT (result_10.result_value IS NULL))
            AND (result_10.result_source_key = q1.result_source_key)
            AND (preparation_1.prep_code = q1.prep_code)
            AND (
                    result_10.result_reliability IS NULL
                    OR result_10.result_reliability = '0'
                )
            AND (result_10.analyte_key IN (
                                              364, 365, 366, 367, 1205, 1758, 1759, 1760, 1881
                                          )
                )
    )                 AS Thermal_Gravimetric_Method,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(3, 0)) AS Expr1
        FROM
            #result_light AS result_12
            LEFT JOIN
                preparation
                    ON result_12.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key IN (
                                    364
                                )
                )
    )                 AS AG_Gypsum_Thermal_Gravimetric_Analysis,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(3, 0)) AS Expr1
        FROM
            #result_light AS result_12
            LEFT JOIN
                preparation
                    ON result_12.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key IN (
                                    365
                                )
                )
    )                 AS GI_Gibbsite_Thermal_Gravimetric_Analysis,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(3, 0)) AS Expr1
        FROM
            #result_light AS result_12
            LEFT JOIN
                preparation
                    ON result_12.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key IN (
                                    366
                                )
                )
    )                 AS GE_Kaolinite_Differential_Thermal_Analysis,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(3, 0)) AS Expr1
        FROM
            #result_light AS result_12
            LEFT JOIN
                preparation
                    ON result_12.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key IN (
                                    367
                                )
                )
    )                 AS KK_Kaolinite_Thermal_Gravimetric_Analysis,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(3, 0)) AS Expr1
        FROM
            #result_light AS result_12
            LEFT JOIN
                preparation
                    ON result_12.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key IN (
                                    1205
                                )
                )
    )                 AS AG_Antigorite_Thermal_Gravimetric_Analysis,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(3, 0)) AS Expr1
        FROM
            #result_light AS result_12
            LEFT JOIN
                preparation
                    ON result_12.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key IN (
                                    1758
                                )
                )
    )                 AS KH_Halloysite_Thermal_Gravimetric_Analysis,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(3, 0)) AS Expr1
        FROM
            #result_light AS result_12
            LEFT JOIN
                preparation
                    ON result_12.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key IN (
                                    1759
                                )
                )
    )                 AS MT_Montmorillonite_Thermal_Gravimetric_Analysis,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(3, 0)) AS Expr1
        FROM
            #result_light AS result_12
            LEFT JOIN
                preparation
                    ON result_12.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key IN (
                                    1760
                                )
                )
    )                 AS PG_Palygorskite_Thermal_Gravimetric_Analysis,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(3, 0)) AS Expr1
        FROM
            #result_light AS result_12
            LEFT JOIN
                preparation
                    ON result_12.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key IN (
                                    1881
                                )
                )
    )                 AS CA_Calcite_Thermal_Gravimetric_Analysis,
    (
        SELECT TOP (1)
            ISNULL(bridge_proced_ss_1.proced_code, '') AS Expr1
        FROM
            #result_light AS result_10
            INNER JOIN
                dbo.preparation AS preparation_1
                    ON result_10.prep_key = preparation_1.prep_key
            LEFT OUTER JOIN
                dbo.bridge_proced_ss AS bridge_proced_ss_1
                    ON result_10.procedure_key = bridge_proced_ss_1.procedure_key
                       AND result_10.source_system_key = bridge_proced_ss_1.source_system_key
        WHERE
            (result_10.result_type = 'layer analyte')
            AND (result_10.result_value <> '')
            AND (NOT (result_10.result_value IS NULL))
            AND (result_10.result_source_key = q1.result_source_key)
            AND (preparation_1.prep_code = q1.prep_code)
            AND (
                    result_10.result_reliability IS NULL
                    OR result_10.result_reliability = '0'
                )
            AND (result_10.analyte_key IN (
                                              809, 810, 814, 815, 816
                                          )
                )
    )                 AS Differential_Thermal_Analysis_Method,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(3, 0)) AS Expr1
        FROM
            #result_light AS result_12
            LEFT JOIN
                preparation
                    ON result_12.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key IN (
                                    809
                                )
                )
    )                 AS GI_Gibbsite_Differential_Thermal_Analysis,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(3, 0)) AS Expr1
        FROM
            #result_light AS result_12
            LEFT JOIN
                preparation
                    ON result_12.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key IN (
                                    810
                                )
                )
    )                 AS KK_Kaolinite_Differential_Thermal_Analysis,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(3, 0)) AS Expr1
        FROM
            #result_light AS result_12
            LEFT JOIN
                preparation
                    ON result_12.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key IN (
                                    814
                                )
                )
    )                 AS GE_Geothite_Differential_Thermal_Analysis,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(3, 0)) AS Expr1
        FROM
            #result_light AS result_12
            LEFT JOIN
                preparation
                    ON result_12.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key IN (
                                    815
                                )
                )
    )                 AS KH_Halloysite_Differential_Thermal_Analysi,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(3, 0)) AS Expr1
        FROM
            #result_light AS result_12
            LEFT JOIN
                preparation
                    ON result_12.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key IN (
                                    816
                                )
                )
    )                 AS QZ_Quartz_Differential_Thermal_Analysis
INTO
    #temp_results_step9
FROM
    dbo.layer
    INNER JOIN
        #result_light AS q1
            ON dbo.layer.layer_key = q1.result_source_key;


----------- this is needed for a different step - temporary table in ncsslabdata database - will be dropped when all steps are complete
DROP TABLE IF EXISTS lab_xray_and_thermal;


SELECT
    labsampnum,
    result_source_key,
    prep_code,
    [analyzed_size_frac],
    [X_Ray_Method],
    [AM_Amphibole_X_Ray],
    [LC_Anacime_X_Ray],
    [AE_Anatase_X_Ray],
    [AG_Antigoite_X_Ray],
    [AO_Aragonite_X_Ray],
    [BT_Biotite_X_Ray],
    [BC_Biotite_Chlorite_X_Ray],
    [BR_Brucite_X_Ray],
    [CA_Calcite_X_Ray],
    [CL_Chlorite_X_Ray],
    [CM_Chlorite_Mica_X_Ray],
    [CR_Cristobalite_X_Ray],
    [DL_Dolomite_X_Ray],
    [EN_Enstatite_X_Ray],
    [FD_Feldspar_X_Ray],
    [GI_Gibbsite_X_Ray],
    [GL_Glauconite_X_Ray],
    [GE_Geothite_X_Ray],
    [GY_Gypsum_X_Ray],
    [KH_Halloysite_X_Ray],
    [HE_Hematite_X_Ray],
    [HN_Hornblende_X_Ray],
    [HB_Hydrobiotite_X_Ray],
    [IL_Illite_Hydromuscovite_X_Ray],
    [KK_Kaolinite_X_Ray],
    [FL_Labradorite_X_Ray],
    [LE_Lepidocrocite_X_Ray],
    [MH_Maghemite_X_Ray],
    [MG_Magnetite_X_Ray],
    [MI_Mica_X_Ray],
    [MT_Montmorillonite_X_Ray],
    [MC_Montmorillonite_Chlorite_X_Ray],
    [MM_Montmorillonite_Mica_X_Ray],
    [MV_Montmorillonite_Vermiculite_X_Ray],
    [MS_Muscovite_X_Ray],
    [NX_Non_Crystalline_X_Ray],
    [FO_Oligoclase_X_Ray],
    [FR_Orthoclase_X_Ray],
    [PG_Palygorskite_X_Ray],
    [PL_Phlogophite_X_Ray],
    [FP_Plagioclase_Feldspar_X_Ra],
    [FK_Potassium_Feldspar_X_Ray],
    [PY_Pyrophyllite_X_Ray],
    [QZ_Quartz_X_Ray],
    [RE_Resistant_Minerals_X_Ray],
    [SE_Sepiolite_X_Ray],
    [TA_Talc_X_Ray],
    [TH_Thenardite_X_Ray],
    [TD_Tridymite_X_Ray],
    [VR_Vermiculite_X_Ray],
    [VC_Vermiculite_Chlorite_X_Ray],
    [VH_Vermiculite_Hydrobiotite_X_Ray],
    [VM_Vermiculite_Mica_X_Ray],
    [ZE_Zeolite_X_Ray],
    [HA_Halite_X_Ray],
    [HS_Hydroxy_Interlayered_Smectite_X_Ray],
    [HV_Hydroxy_Interlayered_Vermiculite_X_Ray],
    [FT_Fluorapatite_XRay],
    [NU_Natrojarosite_X_Ray],
    [HA_PT_Paragonite_X_Ray],
    [NA_Natron_X_Ray],
    [JO_Jarosite_X_Ray],
    [SZ_Serpentine_X_Ray],
    [BE_Boehmite_X_Ray],
    [BD_Beidellite_X_Ray],
    [Clay_Mineral_Interpretation],
    [Coarse_Silt_Mineral_Interpretation],
    [Fine_Sand_Mineral_Interpretation],
    [Very_Fine_Sand_Mineral_Interpretation],
    [Differential_Scanning_Calorimeter_Method],
    [GI_Gibbsite_Differential_Scanning_Calorimetry],
    [KK_Kaolinite_Differential_Scanning_Calorimetry],
    [GE_Geothite_Differential_Scanning_Calorimetry],
    [GY_Gypsum_Differential_Scanning_Calorimetry],
    [AT_Alunite_Differential_Scanning_Calorimetry],
    [SM_Smectite_Differential_Scanning_Calorimetry],
    [KH_Halloysite_Differential_Scanning_Calorimetry],
    [QZ_Quartz_Differential_Scanning_Calorimetry],
    [VR_Vermiculite_Differential_Calorimetry],
    [Thermal_Gravimetric_Method],
    [AG_Gypsum_Thermal_Gravimetric_Analysis],
    [GI_Gibbsite_Thermal_Gravimetric_Analysis],
    [GE_Kaolinite_Differential_Thermal_Analysis],
    [KK_Kaolinite_Thermal_Gravimetric_Analysis],
    [AG_Antigorite_Thermal_Gravimetric_Analysis],
    [KH_Halloysite_Thermal_Gravimetric_Analysis],
    [MT_Montmorillonite_Thermal_Gravimetric_Analysis],
    [PG_Palygorskite_Thermal_Gravimetric_Analysis],
    [CA_Calcite_Thermal_Gravimetric_Analysis],
    [Differential_Thermal_Analysis_Method],
    [GI_Gibbsite_Differential_Thermal_Analysis],
    [KK_Kaolinite_Differential_Thermal_Analysis],
    [GE_Geothite_Differential_Thermal_Analysis],
    [KH_Halloysite_Differential_Thermal_Analysi],
    [QZ_Quartz_Differential_Thermal_Analysis]
INTO
    lab_xray_and_thermal
FROM
    #temp_results_step9
GROUP BY
    labsampnum,
    result_source_key,
    prep_code,
    [analyzed_size_frac],
    [X_Ray_Method],
    [AM_Amphibole_X_Ray],
    [LC_Anacime_X_Ray],
    [AE_Anatase_X_Ray],
    [AG_Antigoite_X_Ray],
    [AO_Aragonite_X_Ray],
    [BT_Biotite_X_Ray],
    [BC_Biotite_Chlorite_X_Ray],
    [BR_Brucite_X_Ray],
    [CA_Calcite_X_Ray],
    [CL_Chlorite_X_Ray],
    [CM_Chlorite_Mica_X_Ray],
    [CR_Cristobalite_X_Ray],
    [DL_Dolomite_X_Ray],
    [EN_Enstatite_X_Ray],
    [FD_Feldspar_X_Ray],
    [GI_Gibbsite_X_Ray],
    [GL_Glauconite_X_Ray],
    [GE_Geothite_X_Ray],
    [GY_Gypsum_X_Ray],
    [KH_Halloysite_X_Ray],
    [HE_Hematite_X_Ray],
    [HN_Hornblende_X_Ray],
    [HB_Hydrobiotite_X_Ray],
    [IL_Illite_Hydromuscovite_X_Ray],
    [KK_Kaolinite_X_Ray],
    [FL_Labradorite_X_Ray],
    [LE_Lepidocrocite_X_Ray],
    [MH_Maghemite_X_Ray],
    [MG_Magnetite_X_Ray],
    [MI_Mica_X_Ray],
    [MT_Montmorillonite_X_Ray],
    [MC_Montmorillonite_Chlorite_X_Ray],
    [MM_Montmorillonite_Mica_X_Ray],
    [MV_Montmorillonite_Vermiculite_X_Ray],
    [MS_Muscovite_X_Ray],
    [NX_Non_Crystalline_X_Ray],
    [FO_Oligoclase_X_Ray],
    [FR_Orthoclase_X_Ray],
    [PG_Palygorskite_X_Ray],
    [PL_Phlogophite_X_Ray],
    [FP_Plagioclase_Feldspar_X_Ra],
    [FK_Potassium_Feldspar_X_Ray],
    [PY_Pyrophyllite_X_Ray],
    [QZ_Quartz_X_Ray],
    [RE_Resistant_Minerals_X_Ray],
    [SE_Sepiolite_X_Ray],
    [TA_Talc_X_Ray],
    [TH_Thenardite_X_Ray],
    [TD_Tridymite_X_Ray],
    [VR_Vermiculite_X_Ray],
    [VC_Vermiculite_Chlorite_X_Ray],
    [VH_Vermiculite_Hydrobiotite_X_Ray],
    [VM_Vermiculite_Mica_X_Ray],
    [ZE_Zeolite_X_Ray],
    [HA_Halite_X_Ray],
    [HS_Hydroxy_Interlayered_Smectite_X_Ray],
    [HV_Hydroxy_Interlayered_Vermiculite_X_Ray],
    [FT_Fluorapatite_XRay],
    [NU_Natrojarosite_X_Ray],
    [HA_PT_Paragonite_X_Ray],
    [NA_Natron_X_Ray],
    [JO_Jarosite_X_Ray],
    [SZ_Serpentine_X_Ray],
    [BE_Boehmite_X_Ray],
    [BD_Beidellite_X_Ray],
    [Clay_Mineral_Interpretation],
    [Coarse_Silt_Mineral_Interpretation],
    [Fine_Sand_Mineral_Interpretation],
    [Very_Fine_Sand_Mineral_Interpretation],
    [Differential_Scanning_Calorimeter_Method],
    [GI_Gibbsite_Differential_Scanning_Calorimetry],
    [KK_Kaolinite_Differential_Scanning_Calorimetry],
    [GE_Geothite_Differential_Scanning_Calorimetry],
    [GY_Gypsum_Differential_Scanning_Calorimetry],
    [AT_Alunite_Differential_Scanning_Calorimetry],
    [SM_Smectite_Differential_Scanning_Calorimetry],
    [KH_Halloysite_Differential_Scanning_Calorimetry],
    [QZ_Quartz_Differential_Scanning_Calorimetry],
    [VR_Vermiculite_Differential_Calorimetry],
    [Thermal_Gravimetric_Method],
    [AG_Gypsum_Thermal_Gravimetric_Analysis],
    [GI_Gibbsite_Thermal_Gravimetric_Analysis],
    [GE_Kaolinite_Differential_Thermal_Analysis],
    [KK_Kaolinite_Thermal_Gravimetric_Analysis],
    [AG_Antigorite_Thermal_Gravimetric_Analysis],
    [KH_Halloysite_Thermal_Gravimetric_Analysis],
    [MT_Montmorillonite_Thermal_Gravimetric_Analysis],
    [PG_Palygorskite_Thermal_Gravimetric_Analysis],
    [CA_Calcite_Thermal_Gravimetric_Analysis],
    [Differential_Thermal_Analysis_Method],
    [GI_Gibbsite_Differential_Thermal_Analysis],
    [KK_Kaolinite_Differential_Thermal_Analysis],
    [GE_Geothite_Differential_Thermal_Analysis],
    [KH_Halloysite_Differential_Thermal_Analysi],
    [QZ_Quartz_Differential_Thermal_Analysis];

GO


----- create indexes
CREATE INDEX lab_xray_and_thermal_idx1c
    ON lab_xray_and_thermal (labsampnum, result_source_key)
    INCLUDE (prep_code);
CREATE INDEX lab_xray_and_thermal_result_source_key_idx2
    ON lab_xray_and_thermal (result_source_key);
CREATE INDEX lab_xray_and_thermal_prep_code_idx5
    ON lab_xray_and_thermal (prep_code);

GO