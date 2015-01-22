set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_G_CronogramaSafraAno.sql
**		Name: SP_G_CronogramaSafraAno
**		Desc: Obtem os anos tabela CronogramaSafra
**
**		Auth: Chaparro
**		Date: 2/05/2011
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_CronogramaSafraAno]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_CronogramaSafraAno]
END
GO
 
CREATE PROCEDURE [dbo].[SP_G_CronogramaSafraAno]

AS

	SELECT
		 'Todos'											AS Ano
		,0													AS Ordem

	UNION
	
	SELECT DISTINCT 
		 CONVERT(VARCHAR, YEAR(dtInicioCronogramaSafra))	AS Ano 
		,1													AS Ordem		
	FROM 
		CronogramaSafra 
		
		
	ORDER BY 
		Ordem