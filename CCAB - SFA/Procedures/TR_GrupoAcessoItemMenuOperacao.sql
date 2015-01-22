set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: TR_GrupoAcessoItemMenuOperacao.sql
**		Name: TR_GrupoAcessoItemMenuOperacao
**		Desc: Trigger de históricos da tabela GrupoAcessoItemMenuOperacao
**
**		Auth: Convergence
**		Date: 30/04/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TR_GrupoAcessoItemMenuOperacao]'))
BEGIN
	DROP TRIGGER [dbo].[TR_GrupoAcessoItemMenuOperacao]
END
GO
 
CREATE TRIGGER [dbo].[TR_GrupoAcessoItemMenuOperacao] ON dbo.GrupoAcessoItemMenuOperacao
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
	INSERT INTO GrupoAcessoItemMenuOperacaoHistorico
	(
		 cdGrupoAcessoSEQ
		,cdItemMenuSEQ
		,cdIndicadorTipoMenuOperacao
		,cdIndicadorStatusGrupoAcessoItemMenuOperacao
		,cdTipoEventoHistorico
		,dtOcorrenciaHistorico
		,cdUsuarioOcorrenciaHistorico
	)
	SELECT
		 cdGrupoAcessoSEQ
		,cdItemMenuSEQ
		,cdIndicadorTipoMenuOperacao
		,cdIndicadorStatusGrupoAcessoItemMenuOperacao
		,@cdTipoEventoHistorico
		,getdate()
		,cdUsuarioUltimaAlteracao

	FROM
		inserted
