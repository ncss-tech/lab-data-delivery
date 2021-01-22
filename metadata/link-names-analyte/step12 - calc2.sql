------------ time 30 minutes
USE ncsslabdata;
GO

------------ insert data into #result_light table
DROP TABLE IF EXISTS #result_light;

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
         
			 INTO #result_light
               FROM  dbo.result r
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
                                           574, 583, 576, 573, 555, 556, 599, 612, 611, 604, 602, 596, 609, 608, 607,
                                           605, 587, 603, 601, 595, 628, 631, 630, 606, 547
                                       )
                );


----------- this is needed for a different step - temporary table in ncsslabdata database - will be dropped when all steps are complete
DROP TABLE IF EXISTS lab_calculations_including_estimates_and_default_values2;

-------- load data into above table
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
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(15, 3)) AS Expr1
        FROM
            #result_light AS result_27
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 574)
    )                AS volume_pct_lt_2_mm_third_ws,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(15, 3)) AS Expr1
        FROM
            #result_light AS result_26
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 583)
    )                AS volume_pct_usda_sand_ws,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(15, 3)) AS Expr1
        FROM
            #result_light AS result_25
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 576)
    )                AS vol_pct_usda_silt_third_bar_ws,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(15, 3)) AS Expr1
        FROM
            #result_light AS result_24
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 573)
    )                AS volume_pct_usda_clay_ws,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(15, 3)) AS Expr1
        FROM
            #result_light result
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 555)
    )                AS pct_pores_drained_third_bar_ws,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(15, 3)) AS Expr1
        FROM
            #result_light AS result_35
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 556)
    )                AS pct_pores_filled_third_bar_ws,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(15, 3)) AS Expr1
        FROM
            #result_light AS result_1
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 599)
    )                AS wt_pct_gt_2_mm_clay_free_ws,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(15, 3)) AS Expr1
        FROM
            #result_light AS result_20
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 612)
    )                AS wt_pct_2_75_mm_clay_free_ws,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(15, 3)) AS Expr1
        FROM
            #result_light AS result_19
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 611)
    )                AS wt_pct_2_20_mm_clay_free_ws,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(15, 3)) AS Expr1
        FROM
            #result_light AS result_18
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 604)
    )                AS wt_pct_sand_clay_free_ws,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(15, 3)) AS Expr1
        FROM
            #result_light AS result_17
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 602)
    )                AS wt_pct_silt_clay_free_ws,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(15, 3)) AS Expr1
        FROM
            #result_light AS result_16
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 596)
    )                AS wt_pct_tot_clay_clay_free_ws,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(15, 3)) AS Expr1
        FROM
            #result_light AS result_15
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 609)
    )                AS wt_pct_vcs_clay_free_lt2mmbase,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(15, 3)) AS Expr1
        FROM
            #result_light AS result_14
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 608)
    )                AS wt_pct_cs_clay_free_lt2mmbase,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(15, 3)) AS Expr1
        FROM
            #result_light AS result_13
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 607)
    )                AS wt_pct_ms_clay_free_lt2mmbase,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(15, 3)) AS Expr1
        FROM
            #result_light AS result_12
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 605)
    )                AS wt_pct_fs_clay_free_lt2mmbase,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(15, 3)) AS Expr1
        FROM
            #result_light AS result_11
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 587)
    )                AS wt_pct_vfs_clay_free_lt2mmbase,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(15, 3)) AS Expr1
        FROM
            #result_light AS result_10
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 603)
    )                AS wt_pct_csi_clay_free_lt2mmbase,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(15, 3)) AS Expr1
        FROM
            #result_light AS result_9
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 601)
    )                AS wt_pct_fsi_clay_free_lt2mmbase,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(15, 3)) AS Expr1
        FROM
            #result_light AS result_8
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 595)
    )                AS wt_pct_clay_clay_free_2mmbase,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(10, 3)) AS Expr1
        FROM
            #result_light AS result_5
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (ISNUMERIC(result_value) = 1)
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 628)
    )                AS wf_25,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(10, 3)) AS Expr1
        FROM
            #result_light AS result_4
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (ISNUMERIC(result_value) = 1)
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 631)
    )                AS wf_520,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(10, 3)) AS Expr1
        FROM
            #result_light AS result_3
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (ISNUMERIC(result_value) = 1)
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 630)
    )                AS wf_2075,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(10, 3)) AS Expr1
        FROM
            #result_light AS result_2
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (ISNUMERIC(result_value) = 1)
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 606)
    )                AS wf_0175,
    (
        SELECT TOP (1)
            CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(10, 0)) AS Expr1
        FROM
            #result_light result
        WHERE
            (result_type = 'layer result')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (analyte_key = 547)
    )                AS percent_passing_3_inch_sieve
INTO
    lab_calculations_including_estimates_and_default_values2
FROM
    dbo.layer
    INNER JOIN
        #result_light AS q1
            ON dbo.layer.layer_key = q1.result_source_key;

CREATE INDEX lab_calculations_including_estimates_and_default_values2_idx1c
    ON lab_calculations_including_estimates_and_default_values2 (labsampnum, result_source_key)
    INCLUDE (prep_code);
CREATE INDEX lab_calculations_including_estimates_and_default_values2_result_source_key_idx2
    ON lab_calculations_including_estimates_and_default_values2 (result_source_key);
CREATE INDEX lab_calculations_including_estimates_and_default_values2_prep_code_idx5
    ON lab_calculations_including_estimates_and_default_values2 (prep_code);

GO
