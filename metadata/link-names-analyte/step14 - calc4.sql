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
                                           525, 524, 523, 530, 529, 527, 534, 533, 538, 537, 539, 571, 572, 586, 555,
                                           556
                                       )
                );


----------- this is needed for a different step - temporary table in ncsslabdata database - will be dropped when all steps are complete
DROP TABLE IF EXISTS lab_calculations_including_estimates_and_default_values4;

---------- load data into above table
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
            result_light AS result_52
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 525)
    )                AS cumulative_curve_lt_1_fourthmm,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(10, 0)) AS Expr1
        FROM
            result_light AS result_51
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 524)
    )                AS cumulative_curve_lt_1_tenth_mm,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(10, 0)) AS Expr1
        FROM
            result_light AS result_50
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 523)
    )                AS cumulative_curve_lt_5_hundredt,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '5.2') AS DECIMAL(12, 2)) AS Expr1
        FROM
            result_light AS result_49
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 530)
    )                AS cumulative_curve_size_lt_60_pe,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '6.3') AS DECIMAL(13, 3)) AS Expr1
        FROM
            result_light AS result_48
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 529)
    )                AS cumulative_curve_size_lt_50_pe,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '6.3') AS DECIMAL(13, 3)) AS Expr1
        FROM
            result_light AS result_47
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 527)
    )                AS cumulative_curve_size_lt_10_pe,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '7.1') AS DECIMAL(13, 1)) AS Expr1
        FROM
            result_light AS result_44
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 534)
    )                AS gradiation_uniformity,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '4.1') AS DECIMAL(11, 1)) AS Expr1
        FROM
            result_light AS result_43
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 533)
    )                AS gradation_curvature,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '4.1') AS DECIMAL(15, 3)) AS Expr1
        FROM
            result_light AS result_7
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 538)
    )                AS le_third_ovendry_whole_soi,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '4.1') AS DECIMAL(15, 3)) AS Expr1
        FROM
            result_light AS result_7
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 537)
    )                AS le_third_bar_to_oven_dry_rewet,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '4.1') AS DECIMAL(15, 3)) AS Expr1
        FROM
            result_light AS result_8
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 539)
    )                AS le_third_fifteen_whole_soil,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '4.2') AS DECIMAL(15, 3)) AS Expr1
        FROM
            result_light AS result_31
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 571)
    )                AS void_ratio_third_bar_lt_2_mm,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '4.2') AS DECIMAL(15, 3)) AS Expr1
        FROM
            result_light AS result_32
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 572)
    )                AS void_ratio_third_bar_whole_soi,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '4.2') AS DECIMAL(15, 3)) AS Expr1
        FROM
            result_light AS result_32
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 586)
    )                AS water_retention_difference_ws,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '4.2') AS DECIMAL(15, 3)) AS Expr1
        FROM
            result_light AS result_32
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 555)
    )                AS pores_drained_third_bar_ws,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '4.2') AS DECIMAL(15, 3)) AS Expr1
        FROM
            result_light AS result_32
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 556)
    )                AS pores_filled_third_bar_ws
INTO
    lab_calculations_including_estimates_and_default_values4
FROM
    dbo.layer
    INNER JOIN
        result_light AS q1
            ON dbo.layer.layer_key = q1.result_source_key;

CREATE INDEX lab_calculations_including_estimates_and_default_values4_idx1c
    ON lab_calculations_including_estimates_and_default_values4 (labsampnum, result_source_key)
    INCLUDE (prep_code);
CREATE INDEX lab_calculations_including_estimates_and_default_values4_result_source_key_idx2
    ON lab_calculations_including_estimates_and_default_values4 (result_source_key);
CREATE INDEX lab_calculations_including_estimates_and_default_values4_prep_code_idx5
    ON lab_calculations_including_estimates_and_default_values4 (prep_code);

GO
SET STATISTICS IO OFF;
GO