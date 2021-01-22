USE ncsslabdata;
GO

------------ insert data into result_light table
TRUNCATE TABLE dbo.result_light;
INSERT INTO result_light (
result_key,
                result_source_key,
                prep_key,
                result_type,
                result_reliability,
                analyte_key,
                procedure_key,
                source_system_key,
                result_value,
                prep_code,
                proced_code
				)
            SELECT 
                result_key,
                result_source_key,
                r.prep_key,
                result_type,
                result_reliability,
                analyte_key,
                r.procedure_key,
                r.source_system_key,
                result_value,
                p.prep_code,
                b.proced_code
            FROM
                dbo.result r
                LEFT OUTER JOIN
                    dbo.preparation AS p
                        ON r.prep_key = p.prep_key
                LEFT OUTER JOIN
                    dbo.bridge_proced_ss AS b
                        ON r.procedure_key = b.procedure_key
                           AND r.source_system_key = b.source_system_key
            WHERE
                (
                    result_value IS NOT NULL
                    AND result_type = 'layer result'
                    AND CASE
                            WHEN result_reliability IS NULL
                                THEN 1
                            WHEN result_reliability = '0'
                                THEN 1
                            ELSE
                                2
                        END = 1
                    AND analyte_key IN (
                                           516, 600, 614, 617, 610, 613, 615
                                       )
                )
            GROUP BY
                result_key,
                result_source_key,
                r.prep_key,
                result_type,
                result_reliability,
                analyte_key,
                r.procedure_key,
                r.source_system_key,
                result_value,
                p.prep_code,
                b.proced_code;



----------- this is needed for a different step - temporary table in ncsslabdata database - will be dropped when all steps are complete
DROP TABLE IF EXISTS lab_calculations_including_estimates_and_default_values3;

----------- load data into above table 
SELECT DISTINCT
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
                    ORDER BY
                        CASE
                            WHEN prep_code = 's'
                                THEN 1
                            ELSE
                                2
                        END ASC
                )                AS prep_code,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result.result_value, '4.2') AS DECIMAL(15, 3)) AS Expr1
        FROM
            result_light result
        WHERE
            (result.result_type = 'layer result')
            AND (result.result_source_key = q1.result_source_key)
            AND (CASE
                     WHEN result.result_reliability IS NULL
                         THEN 1
                     WHEN result.result_reliability = '0'
                         THEN 1
                     ELSE
                         2
                 END = 1
                )
            AND (analyte_key = 516)
    )                AS bulk_density_whole_soil_moist,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result.result_value, '4.2') AS DECIMAL(15, 3)) AS Expr1
        FROM
            result_light result
        WHERE
            (result.result_type = 'layer result')
            AND (result.result_source_key = q1.result_source_key)
            AND (CASE
                     WHEN result.result_reliability IS NULL
                         THEN 1
                     WHEN result.result_reliability = '0'
                         THEN 1
                     ELSE
                         2
                 END = 1
                )
            AND (analyte_key = 600)
    )                AS weight_percent_gt_2_mm_ws,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result.result_value, '3.0') AS DECIMAL(15, 3)) AS Expr1
        FROM
            result_light result
        WHERE
            (result.result_type = 'layer result')
            AND (result.result_source_key = q1.result_source_key)
            AND (CASE
                     WHEN result.result_reliability IS NULL
                         THEN 1
                     WHEN result.result_reliability = '0'
                         THEN 1
                     ELSE
                         2
                 END = 1
                )
            AND (analyte_key = 614)
    )                AS weight_percent_gt_250_mm_ws,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result.result_value, '3.0') AS DECIMAL(15, 3)) AS Expr1
        FROM
            result_light result
        WHERE
            (result.result_type = 'layer result')
            AND (result.result_source_key = q1.result_source_key)
            AND (CASE
                     WHEN result.result_reliability IS NULL
                         THEN 1
                     WHEN result.result_reliability = '0'
                         THEN 1
                     ELSE
                         2
                 END = 1
                )
            AND (analyte_key = 617)
    )                AS weight_pct_75_to_250_mm_ws,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result.result_value, '3.0') AS DECIMAL(15, 3)) AS Expr1
        FROM
            result_light result
        WHERE
            (result.result_type = 'layer result')
            AND (result.result_source_key = q1.result_source_key)
            AND (CASE
                     WHEN result.result_reliability IS NULL
                         THEN 1
                     WHEN result.result_reliability = '0'
                         THEN 1
                     ELSE
                         2
                 END = 1
                )
            AND (analyte_key = 610)
    )                AS weight_pct_2_to_75_mm_ws,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result.result_value, '3.0') AS DECIMAL(15, 3)) AS Expr1
        FROM
            result_light result
        WHERE
            (result.result_type = 'layer result')
            AND (result.result_source_key = q1.result_source_key)
            AND (CASE
                     WHEN result.result_reliability IS NULL
                         THEN 1
                     WHEN result.result_reliability = '0'
                         THEN 1
                     ELSE
                         2
                 END = 1
                )
            AND (analyte_key = 613)
    )                AS weight_pct_20_to_75_mm_ws,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result.result_value, '3.0') AS DECIMAL(15, 3)) AS Expr1
        FROM
            result_light result
        WHERE
            (result.result_type = 'layer result')
            AND (result.result_source_key = q1.result_source_key)
            AND (CASE
                     WHEN result.result_reliability IS NULL
                         THEN 1
                     WHEN result.result_reliability = '0'
                         THEN 1
                     ELSE
                         2
                 END = 1
                )
            AND (analyte_key = 615)
    )                AS weight_pct_5_to_20_mm_ws
INTO
    lab_calculations_including_estimates_and_default_values3
FROM
    dbo.layer
    INNER JOIN
        result_light AS q1
            ON dbo.layer.layer_key = q1.result_source_key;

CREATE INDEX lab_calculations_including_estimates_and_default_values3_idx1c
    ON lab_calculations_including_estimates_and_default_values3 (labsampnum, result_source_key)
    INCLUDE (prep_code);
CREATE INDEX lab_calculations_including_estimates_and_default_values3_result_source_key_idx2
    ON lab_calculations_including_estimates_and_default_values3 (result_source_key);
CREATE INDEX lab_calculations_including_estimates_and_default_values3_prep_code_idx5
    ON lab_calculations_including_estimates_and_default_values3 (prep_code);

GO
