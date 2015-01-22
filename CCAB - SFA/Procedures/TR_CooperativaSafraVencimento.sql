set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: TR_CooperativaSafraVencimento.sql
**		Name: TR_CooperativaSafraVencimento
**		Desc: Trigger de históricos da tabela CronogramaSafraVencimentoCooperativa
**
**		Auth: Convergence
**		Date: 30/04/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TR_CooperativaSafraVencimento]'))
BEGIN
	DROP TRIGGER [dbo].[TR_CooperativaSafraVencimento]
END
GO
 
CREATE TRIGGER [dbo].[TR_CooperativaSafraVencimento] ON dbo.CronogramaSafraVencimentoCooperativa
AFTER INSERT, UPDATE
AS
 
declare
	@cdTipoEventoHistorico		int
 
	IF EXISTS (SELECT * FROM deleted)	-- Alteração
	BEGIN
		select
			@cdTipoEventoHistorico	= 2
	END
	ELSE
	BEGIN
		select
			@cdTipoEventoHistorico	= 1
	END
 
	--inserção
	INSERT INTO CronogramaSafraCooperativaHistorico
	(
	 cdCronogramaSafraVencimentoCoopSEQ
	,cdCronogramaSafraVencimentoSEQ
	,cdCooperativaSEQ
	,pcCorrecaoPreco
	,pcDescontoPontualidade
	,wkCronogramaSafraVencimentoCooperativa
	,cdTipoEventoHistorico
	,dtOcorrenciaHistorico
	,cdUsuarioOcorrenciaHistorico
	
	,pcParcela1CronogramaSafraVencimento
	,pcParcela2CronogramaSafraVencimento
	,pcParcela3CronogramaSafraVencimento
	,pcParcela4CronogramaSafraVencimento
	,pcParcela5CronogramaSafraVencimento
	,pcParcela6CronogramaSafraVencimento
	,dtParcela1CronogramaSafraVencimento
	,dtParcela2CronogramaSafraVencimento
	,dtParcela3CronogramaSafraVencimento
	,dtParcela4CronogramaSafraVencimento
	,dtParcela5CronogramaSafraVencimento
	,dtParcela6CronogramaSafraVencimento
	
	)
	SELECT
		 cdCronogramaSafraVencimentoCoopSEQ
		,cdCronogramaSafraVencimentoSEQ
		,cdCooperativaSEQ
		,pcCorrecaoPreco
		,pcDescontoPontualidade
		,wkCronogramaSafraVencimentoCooperativa
		,@cdTipoEventoHistorico
		,dtUltimaAlteracao
		,cdUsuarioUltimaAlteracao

		,pcParcela1CronogramaSafraVencimento
		,pcParcela2CronogramaSafraVencimento
		,pcParcela3CronogramaSafraVencimento
		,pcParcela4CronogramaSafraVencimento
		,pcParcela5CronogramaSafraVencimento
		,pcParcela6CronogramaSafraVencimento
		,dtParcela1CronogramaSafraVencimento
		,dtParcela2CronogramaSafraVencimento
		,dtParcela3CronogramaSafraVencimento
		,dtParcela4CronogramaSafraVencimento
		,dtParcela5CronogramaSafraVencimento
		,dtParcela6CronogramaSafraVencimento
		
	FROM
		inserted

