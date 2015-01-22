set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: TR_PessoaTabelaPrecoProduto.sql
**		Name: TR_PessoaTabelaPrecoProduto
**		Desc: Trigger de históricos da tabela PessoaTabelaPrecoProduto
**
**		Auth: Convergence
**		Date: 30/04/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TR_PessoaTabelaPrecoProduto]'))
BEGIN
	DROP TRIGGER [dbo].[TR_PessoaTabelaPrecoProduto]
END
GO
 
CREATE TRIGGER [dbo].[TR_PessoaTabelaPrecoProduto] ON dbo.PessoaTabelaPrecoProduto
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
	INSERT INTO PessoaTabelaPrecoProdutoHistorico
	(
		 cdPessoaTabelaPrecoProdutoSEQ
		,cdPessoaSEQ
		,cdCronogramaSafraSEQ
		,cdProdutoSEQ
		,cdCronogramaSafraVencimentoSEQ
		,vrDolarPessoaTabelaPrecoProduto
		,vrRealPessoaTabelaPrecoProduto
		,pcDescontoPontualidadePessoaTabelaPrecoProduto
		,wkPessoaTabelaPrecoProduto
		,cdTipoEventoHistorico
		,dtOcorrenciaHistorico
		,cdUsuarioOcorrenciaHistorico
	)
	SELECT
		 cdPessoaTabelaPrecoProdutoSEQ
		,cdPessoaSEQ
		,cdCronogramaSafraSEQ
		,cdProdutoSEQ
		,cdCronogramaSafraVencimentoSEQ
		,vrDolarPessoaTabelaPrecoProduto
		,vrRealPessoaTabelaPrecoProduto
		,pcDescontoPontualidadePessoaTabelaPrecoProduto
		,wkPessoaTabelaPrecoProduto
		,@cdTipoEventoHistorico
		,getdate()
		,cdUsuarioUltimaAlteracao

	FROM
		inserted
