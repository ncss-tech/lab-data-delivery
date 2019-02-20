USE [master]
GO
ALTER DATABASE [ncsslabdata] SET COMPATIBILITY_LEVEL = 130
GO

SELECT @@VERSION AS SQL_Server_Version

USE ncsslabdata
go


	  DROP TABLE IF EXISTS result_light
	  DROP TABLE IF EXISTS #tempXX
	  DROP TABLE IF EXISTS SDA_Calculations_Including_Estimates_And_Default_Values4
	  DROP TABLE IF EXISTS SDA_Calculations_Including_Estimates_And_Default_Values


 CREATE TABLE result_light (result_key INT NOT NULL  , result_source_key INT, 
	  prep_key int,  result_type VARCHAR(128), result_reliability VARCHAR(20), 
	  analyte_key int, procedure_key int, source_system_key int, result_value VARCHAR(128) , 
	  prep_code VARCHAR(64) , proced_code VARCHAR(12),
	   CONSTRAINT pk_result_light PRIMARY KEY CLUSTERED (result_key))
	  go


	  INSERT INTO result_light
	  SELECT result_key, result_source_key, r.prep_key,  result_type, result_reliability, analyte_key, r.procedure_key, r.source_system_key, result_value, p.prep_code  , b.proced_code

	FROM dbo.result r
    LEFT OUTER JOIN dbo.preparation AS p  ON r.prep_key = p.prep_key
    LEFT OUTER JOIN dbo.bridge_proced_ss AS b  ON r.procedure_key = b.procedure_key AND r.source_system_key = b.source_system_key 
            WHERE 
		   (result_value IS NOT NULL AND result_type = 'layer result' AND
		    analyte_key 
		   IN (525, 524,523,530, 529, 527,534, 533, 538, 537,539, 571,572, 586, 555, 556))

  	CREATE INDEX  result_light_idx1c ON  result_light (analyte_key, result_type, result_source_key,  result_reliability) INCLUDE (result_value, proced_code,prep_code)
	CREATE INDEX  result_light_idx1b ON  result_light (analyte_key,  result_reliability)
	CREATE INDEX  result_light_result_source_key_idx2 ON  result_light (result_source_key )
	CREATE INDEX  result_light_prep_key_idx3 ON  result_light (prep_key)
	CREATE INDEX  result_source_system_key_idx4 ON result_light (source_system_key)
	CREATE INDEX  result_light_prep_code_idx5 ON  result_light (prep_code)

GO
SET STATISTICS IO ON
GO

SELECT  natural_key AS labsampnum, result_source_key, prep_code ,

                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM result_light  AS result_52
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =525)) 
                         AS cumulative_curve_lt_1_fourthmm,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM result_light  AS result_51
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =524)) 
                         AS cumulative_curve_lt_1_tenth_mm,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM result_light  AS result_50
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =523)) 
                         AS cumulative_curve_lt_5_hundredt,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '5.2') AS decimal(12, 2)) AS Expr1
                               FROM result_light  AS result_49
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =530)) 
                         AS cumulative_curve_size_lt_60_pe,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '6.3') AS decimal(13, 3)) AS Expr1
                               FROM result_light  AS result_48
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =529)) 
                         AS cumulative_curve_size_lt_50_pe,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '6.3') AS decimal(13, 3)) AS Expr1
                               FROM result_light  AS result_47
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =527)) 
                         AS cumulative_curve_size_lt_10_pe,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '7.1') AS decimal(13, 1)) AS Expr1
                               FROM result_light  AS result_44
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =534)) 
                         AS gradiation_uniformity,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.1') AS decimal(11, 1)) AS Expr1
                               FROM result_light  AS result_43
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =533)) 
                         AS gradation_curvature,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.1') AS decimal(15, 3)) AS Expr1
                               FROM result_light  AS result_7
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =538)) 
						AS le_third_ovendry_whole_soi,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.1') AS decimal(15, 3)) AS Expr1
                               FROM result_light  AS result_7
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =537)) 
						AS le_third_bar_to_oven_dry_rewet,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.1') AS decimal(15, 3)) AS Expr1
                               FROM result_light  AS result_8
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =539)) 
						AS le_third_fifteen_whole_soil,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.2') AS decimal(15, 3)) AS Expr1
                               FROM result_light  AS result_31
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =571)) 
                         AS void_ratio_third_bar_lt_2_mm,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.2') AS decimal(15, 3)) AS Expr1
                               FROM result_light  AS result_32
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =572)) 
                         AS void_ratio_third_bar_whole_soi,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.2') AS decimal(15, 3)) AS Expr1
                               FROM result_light  AS result_32
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =586)) 
                         AS water_retention_difference_ws,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.2') AS decimal(15, 3)) AS Expr1
                               FROM result_light  AS result_32
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =555)) 
                         AS pores_drained_third_bar_ws,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.2') AS decimal(15, 3)) AS Expr1
                               FROM result_light  AS result_32
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =556)) 
                         AS pores_filled_third_bar_ws



INTO SDA_Calculations_Including_Estimates_And_Default_Values4
FROM  dbo.layer 
INNER JOIN result_light AS q1 ON dbo.layer.layer_key = q1.result_source_key 

CREATE INDEX  SDA_Calculations_Including_Estimates_And_Default_Values4_idx1c ON  SDA_Calculations_Including_Estimates_And_Default_Values4 (labsampnum, result_source_key) INCLUDE (prep_code)
CREATE INDEX  SDA_Calculations_Including_Estimates_And_Default_Values4_result_source_key_idx2 ON  SDA_Calculations_Including_Estimates_And_Default_Values4 (result_source_key )
CREATE INDEX SDA_Calculations_Including_Estimates_And_Default_Values4_prep_code_idx5 ON  SDA_Calculations_Including_Estimates_And_Default_Values4 (prep_code)

GO
SET STATISTICS IO OFF
GO