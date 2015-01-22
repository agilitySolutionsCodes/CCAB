set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: TR_CronogramaSafra.sql
**		Name: TR_CronogramaSafra
**		Desc: Trigger de históricos da tabela CronogramaSafra
**
**		Auth: Convergence
**		Date: 30/04/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TR_CronogramaSafra]'))
BEGIN
	DROP TRIGGER [dbo].[TR_CronogramaSafra]
END
GO
 
CREATE TRIGGER [dbo].[TR_CronogramaSafra] ON dbo.CronogramaSafra
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
	INSERT INTO CronogramaSafraHistorico
	(
		 cdCronogramaSafraSEQ
		,dsCronogramaSafra
		,dtInicioCronogramaSafra
		,dtFimCronogramaSafra
		,dtLimiteLiberacaoCCCronogramaSafra
		,dtLimiteAprovacaoCCCronogramaSafra
		,dtLimiteLiberacaoPVCronogramaSafra
		,dtLimiteAprovacaoPVRCCronogramaSafra
		,dtLimiteAprovacaoPVACCronogramaSafra
		,wkCronogramaSafra
		,cdTipoEventoHistorico
		,dtOcorrenciaHistorico
		,cdUsuarioOcorrenciaHistorico
		,cdIndicadorSituacaoCronogramaSafra
		,qtProdutoPrecoCronogramaSafra
	)
	SELECT
		 cdCronogramaSafraSEQ
		,dsCronogramaSafra
		,dtInicioCronogramaSafra
		,dtFimCronogramaSafra
		,dtLimiteLiberacaoCCCronogramaSafra
		,dtLimiteAprovacaoCCCronogramaSafra
		,dtLimiteLiberacaoPVCronogramaSafra
		,dtLimiteAprovacaoPVRCCronogramaSafra
		,dtLimiteAprovacaoPVACCronogramaSafra
		,wkCronogramaSafra
		,@cdTipoEventoHistorico
		,getdate()
		,cdUsuarioUltimaAlteracao
		,cdIndicadorSituacaoCronogramaSafra
		,qtProdutoPrecoCronogramaSafra

	FROM
		inserted
