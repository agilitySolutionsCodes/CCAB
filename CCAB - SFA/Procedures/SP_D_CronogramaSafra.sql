set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_D_CronogramaSafra
**		Name: SP_D_CronogramaSafra
**		Desc: Exclui o registro da tabela CronogramaSafra
**
**		Auth: Roberto Chaparro
**		Date: Mar 20 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_D_CronogramaSafra]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_D_CronogramaSafra]
END
GO

CREATE PROCEDURE [dbo].[SP_D_CronogramaSafra]
	 @cdCronogramaSafraSEQ						bigint
AS


	--Histórico
	DELETE 
		dbo.CronogramaSafraHistorico
	WHERE
		cdCronogramaSafraSEQ						= @cdCronogramaSafraSEQ
		

	--Principal
	DELETE 
		dbo.CronogramaSafra
	WHERE
		cdCronogramaSafraSEQ						= @cdCronogramaSafraSEQ




