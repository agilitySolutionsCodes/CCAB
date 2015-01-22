set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: TR_ProdutoKit.sql
**		Name: TR_ProdutoKit
**		Desc: Trigger de históricos da tabela ProdutoKit
**
**		Auth: Convergence
**		Date: 17/06/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TR_ProdutoKit]'))
BEGIN
	DROP TRIGGER [dbo].[TR_ProdutoKit]
END
GO
 
CREATE TRIGGER [dbo].[TR_ProdutoKit] ON dbo.ProdutoKit
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
	INSERT INTO ProdutoKitHistorico
	(
		 cdProdutoPai
		,cdProdutoKitSEQ
		,qtComposicaoBaseProdutoKit
		,qtComposicaoProdutoKit
		,cdProdutoFilho
		,cdIndicadorStatusProdutoKit
		,cdRecnoMicrosiga
		,dtOcorrenciaHistorico
		,cdUsuarioOcorrenciaHistorico
		,cdTipoEventoHistorico
	)
	SELECT
		 cdProdutoPai
		,cdProdutoKitSEQ
		,qtComposicaoBaseProdutoKit
		,qtComposicaoProdutoKit
		,cdProdutoFilho
		,cdIndicadorStatusProdutoKit
		,cdRecnoMicrosiga
		,getdate()
		,cdUsuarioUltimaAlteracao
		,@cdTipoEventoHistorico

	FROM
		inserted
