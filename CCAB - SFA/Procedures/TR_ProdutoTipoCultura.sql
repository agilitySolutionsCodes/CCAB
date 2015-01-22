set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: TR_ProdutoTipoCultura.sql
**		Name: TR_ProdutoTipoCultura
**		Desc: Trigger de históricos da tabela ProdutoTipoCultura
**
**		Auth: Convergence
**		Date: 30/04/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TR_ProdutoTipoCultura]'))
BEGIN
	DROP TRIGGER [dbo].[TR_ProdutoTipoCultura]
END
GO
 
CREATE TRIGGER [dbo].[TR_ProdutoTipoCultura] ON dbo.ProdutoTipoCultura
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
	INSERT INTO ProdutoTipoCulturaHistorico
	(
		 cdProdutoSEQ
		,cdTipoCulturaSEQ
		,cdIndicadorStatusProdutoTipoCultura
		,wkProdutoTipoCultura
		,dtOcorrenciaHistorico
		,cdUsuarioOcorrenciaHistorico
		,cdProdutoTipoCulturaSEQ
		,cdTipoEventoHistorico
	)
	SELECT
		 cdProdutoSEQ
		,cdTipoCulturaSEQ
		,cdIndicadorStatusProdutoTipoCultura
		,wkProdutoTipoCultura
		,getdate()
		,cdUsuarioUltimaAlteracao
		,cdProdutoTipoCulturaSEQ
		,@cdTipoEventoHistorico

	FROM
		inserted
