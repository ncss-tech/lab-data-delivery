USE ncsslabdata;
GO


------------ insert data into result_light table
TRUNCATE TABLE dbo.result_light;
INSERT INTO result_light
    (
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
                    AND analyte_key IN (
                                           544, 542, 543, 548, 549, 553, 551, 554, 552, 546, 550, 545, 528, 526
                                       )
                );


----------- this is needed for a different step - temporary table in ncsslabdata database - will be dropped when all steps are complete
DROP TABLE IF EXISTS lab_calculations_including_estimates_and_default_values6;

----------- load data into above table
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
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(10, 0)) AS Expr1
        FROM
            result_light result
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 544)
    )                AS percent_passing_2_inch_sieve,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(10, 0)) AS Expr1
        FROM
            result_light AS result_65
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 542)
    )                AS percent_passing_1_and_1_half,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(10, 0)) AS Expr1
        FROM
            result_light AS result_64
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 543)
    )                AS percent_passing_1_inch_sieve,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(10, 0)) AS Expr1
        FROM
            result_light AS result_63
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 548)
    )                AS percent_passing_3_quarter_inch,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(10, 0)) AS Expr1
        FROM
            result_light AS result_62
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 549)
    )                AS percent_passing_3_eights_inch,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(10, 0)) AS Expr1
        FROM
            result_light AS result_61
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 553)
    )                AS percent_passing_no_4_sieve,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(10, 0)) AS Expr1
        FROM
            result_light AS result_60
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 551)
    )                AS percent_passing_no_10_sieve,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(10, 0)) AS Expr1
        FROM
            result_light AS result_59
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 554)
    )                AS percent_passing_no_40_sieve,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(10, 0)) AS Expr1
        FROM
            result_light AS result_58
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 552)
    )                AS percent_passing_no_200_sieve,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(10, 0)) AS Expr1
        FROM
            result_light AS result_57
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 546)
    )                AS percent_passing_20_micron_siev,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(10, 0)) AS Expr1
        FROM
            result_light AS result_56
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 550)
    )                AS percent_passing_5_micron_sieve,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(10, 0)) AS Expr1
        FROM
            result_light AS result_55
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 545)
    )                AS percent_passing_2_micron_sieve,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(10, 0)) AS Expr1
        FROM
            result_light AS result_54
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 528)
    )                AS cumulative_curve_less_than_1mm,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(10, 0)) AS Expr1
        FROM
            result_light AS result_53
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 526)
    )                AS cumulative_curve_lt_1_half_mm
INTO
    lab_calculations_including_estimates_and_default_values6
FROM
    dbo.layer
    INNER JOIN
        result_light AS q1
            ON dbo.layer.layer_key = q1.result_source_key;

CREATE INDEX lab_calculations_including_estimates_and_default_values6_idx1c
    ON lab_calculations_including_estimates_and_default_values6 (labsampnum, result_source_key)
    INCLUDE (prep_code);
CREATE INDEX lab_calculations_including_estimates_and_default_values2_result_source_key_idx6
    ON lab_calculations_including_estimates_and_default_values6 (result_source_key);
CREATE INDEX lab_calculations_including_estimates_and_default_values2_prep_code_idx6
    ON lab_calculations_including_estimates_and_default_values6 (prep_code);

GO
