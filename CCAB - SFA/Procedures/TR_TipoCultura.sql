set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: TR_TipoCultura.sql
**		Name: TR_TipoCultura
**		Desc: Trigger de históricos da tabela TipoCultura
**
**		Auth: Convergence
**		Date: 30/04/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TR_TipoCultura]'))
BEGIN
	DROP TRIGGER [dbo].[TR_TipoCultura]
END
GO
 
CREATE TRIGGER [dbo].[TR_TipoCultura] ON dbo.TipoCultura
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
	INSERT INTO TipoCulturaHistorico
	(
		 cdTipoCulturaSEQ
		,cdTipoCulturaERP
		,dsTipoCultura
		,cdIndicadorStatusTipoCultura
		,nuOrdemApresentacaoTipoCultura
		,wkTipoCultura
		,cdTipoEventoHistorico
		,dtOcorrenciaHistorico
		,cdUsuarioOcorrenciaHistorico
	)
	SELECT
		 cdTipoCulturaSEQ
		,cdTipoCulturaERP
		,dsTipoCultura
		,cdIndicadorStatusTipoCultura
		,nuOrdemApresentacaoTipoCultura
		,wkTipoCultura
		,@cdTipoEventoHistorico
		,getdate()
		,cdUsuarioUltimaAlteracao

	FROM
		inserted
