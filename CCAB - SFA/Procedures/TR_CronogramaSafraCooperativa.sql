set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: TR_CronogramaSafraCooperativa.sql
**		Name: TR_CronogramaSafraCooperativa
**		Desc: Trigger de históricos da tabela CronogramaSafraCooperativa
**
**		Auth: Convergence
**		Date: 05/05/2011
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TR_CronogramaSafraCooperativa]'))
BEGIN
	DROP TRIGGER [dbo].[TR_CronogramaSafraCooperativa]
END
GO
 
CREATE TRIGGER [dbo].[TR_CronogramaSafraCooperativa] ON CronogramaSafraCooperativa
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
	INSERT INTO CronogramaSafraCooperativaVNCHistorico
	(

		 cdCronogramaSafraCooperativaSEQ
		,cdCronogramaSafraSEQ
		,cdPessoaSEQ
		,cdIndicadorSituacaoCooperativa
		,wkCronogramaSafraCooperativa

		,cdTipoEventoHistorico
		,dtOcorrenciaHistorico
		,cdUsuarioOcorrenciaHistorico
	
	)
	SELECT
	
		 cdCronogramaSafraCooperativaSEQ
		,cdCronogramaSafraSEQ
		,cdPessoaSEQ
		,cdIndicadorSituacaoCooperativa
		,wkCronogramaSafraCooperativa
		
		,@cdTipoEventoHistorico
		,dtUltimaAlteracao
		,cdUsuarioUltimaAlteracao
	FROM
		inserted

