USE [master]
GO
ALTER DATABASE [ncsslabdata] SET COMPATIBILITY_LEVEL = 130
GO

SELECT @@VERSION AS SQL_Server_Version

USE ncsslabdata
go

	  DROP TABLE IF EXISTS result_light
	  DROP TABLE IF EXISTS result_light_calcEst
	  DROP TABLE IF EXISTS #tempXX
	  DROP TABLE IF EXISTS SDA_Calculations_Including_Estimates_And_Default_Values5
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
		   (result_value IS NOT NULL AND result_type = 'layer result' AND CASE WHEN result_reliability IS NULL THEN 1 WHEN result_reliability = '0' THEN 1 ELSE 2 END = 1 AND
		    analyte_key 
		   IN (594, 598, 575, 580, 582, 578, 579, 581, 577))
		   GROUP BY result_key, result_source_key, r.prep_key,  result_type, result_reliability, analyte_key, r.procedure_key, r.source_system_key, result_value, p.prep_code  , b.proced_code

  	CREATE INDEX  result_light_idx1c ON  result_light (analyte_key, result_type, result_source_key,  result_reliability) INCLUDE (result_value, proced_code,prep_code)
	CREATE INDEX  result_light_idx1b ON  result_light (analyte_key,  result_reliability)
	CREATE INDEX  result_light_result_source_key_idx2 ON  result_light (result_source_key )
	CREATE INDEX  result_light_prep_key_idx3 ON  result_light (prep_key)
	CREATE INDEX  result_source_system_key_idx4 ON result_light (source_system_key)
	CREATE INDEX  result_light_prep_code_idx5 ON  result_light (prep_code)

 
SELECT DISTINCT natural_key AS labsampnum, result_source_key, prep_code,

 (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.0') AS decimal(15, 3)) AS Expr1
				                          FROM result_light  result
	                               WHERE       (result.result_type = 'layer result') AND (result.result_source_key = q1.result_source_key)  AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1 ) AND (analyte_key = 594)) 	AS weight_pct_2_to_5_mm_ws,	
								   
(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.0') AS decimal(15, 3)) AS Expr1
				                          FROM result_light  result
	                               WHERE       (result.result_type = 'layer result') AND (result.result_source_key = q1.result_source_key) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1 ) AND (analyte_key = 598)) 	AS weight_pct_less_than_2_mm_ws,						
(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.0') AS decimal(15, 3)) AS Expr1
				                          FROM result_light  result
	                               WHERE       (result.result_type = 'layer result') AND (result.result_source_key = q1.result_source_key)  AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1 ) AND (analyte_key = 575)) 	AS  volume_pct_gt_2_mm_thirdbarws,	

				         (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM result_light  AS result_33
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =580)) 
						AS volume_pct_gt_250_mm_thirdbarw,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM result_light  AS result_32
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =582)) 
						AS volume_pct_75_to_250_mm_third,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM result_light  AS result_31
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =578)) 
						AS volume_pct_2_to_75_mm_third_ws,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM result_light  AS result_30
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =579)) 
						AS volume_pct_20_to_75_mm_third_w,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM result_light  AS result_29
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =581)) 
						AS volume_pct_5_to_20_mm_third_ws,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM result_light  AS result_28
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =577)) 
						AS volume_pct_2_to_5_mm_third_ws

INTO SDA_Calculations_Including_Estimates_And_Default_Values5
FROM  dbo.layer 
INNER JOIN result_light AS q1 ON dbo.layer.layer_key = q1.result_source_key 

CREATE INDEX  SDA_Calculations_Including_Estimates_And_Default_Values5_idx1c ON  SDA_Calculations_Including_Estimates_And_Default_Values5 (labsampnum, result_source_key) INCLUDE (prep_code)
CREATE INDEX  SDA_Calculations_Including_Estimates_And_Default_Values5_result_source_key_idx2 ON  SDA_Calculations_Including_Estimates_And_Default_Values5 (result_source_key )
CREATE INDEX SDA_Calculations_Including_Estimates_And_Default_Values5_prep_code_idx5 ON  SDA_Calculations_Including_Estimates_And_Default_Values5 (prep_code)

GO
SET STATISTICS IO OFF
GO