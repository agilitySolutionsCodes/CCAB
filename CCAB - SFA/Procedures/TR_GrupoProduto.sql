set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: TR_GrupoProduto.sql
**		Name: TR_GrupoProduto
**		Desc: Trigger de históricos da tabela GrupoProduto
**
**		Auth: Convergence
**		Date: 30/04/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TR_GrupoProduto]'))
BEGIN
	DROP TRIGGER [dbo].[TR_GrupoProduto]
END
GO
 
CREATE TRIGGER [dbo].[TR_GrupoProduto] ON dbo.GrupoProduto
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
	INSERT INTO GrupoProdutoHistorico
	(
		 cdGrupoProdutoSEQ
		,cdGrupoProdutoERP
		,dsGrupoProduto
		,cdIndicadorStatusGrupoProduto
		,cdRecnoMicrosiga
		,cdTipoEventoHistorico
		,dtOcorrenciaHistorico
		,cdUsuarioOcorrenciaHistorico
	)
	SELECT
		 cdGrupoProdutoSEQ
		,cdGrupoProdutoERP
		,dsGrupoProduto
		,cdIndicadorStatusGrupoProduto
		,cdRecnoMicrosiga
		,@cdTipoEventoHistorico
		,getdate()
		,cdUsuarioUltimaAlteracao

	FROM
		inserted
