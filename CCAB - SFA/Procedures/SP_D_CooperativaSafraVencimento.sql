set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_D_CooperativaSafraVencimento
**		Name: SP_D_CooperativaSafraVencimento
**		Desc: Exclui o registro da tabela CronogramaSafraVencimentoCooperativa
**
**		Auth: Roberto Chaparro
**		Date: Mar 20 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_D_CooperativaSafraVencimento]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_D_CooperativaSafraVencimento]
END
GO

CREATE PROCEDURE [dbo].[SP_D_CooperativaSafraVencimento]
	 @cdCronogramaSafraVencimentoCoopSEQ	bigint
AS


	--Histórico
	DELETE 
		dbo.CronogramaSafraCooperativaHistorico
	WHERE
		cdCronogramaSafraVencimentoCoopSEQ	= @cdCronogramaSafraVencimentoCoopSEQ

	--Principal
	DELETE 
		dbo.CronogramaSafraVencimentoCooperativa
	WHERE
		cdCronogramaSafraVencimentoCoopSEQ	= @cdCronogramaSafraVencimentoCoopSEQ





