set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: TR_GrupoAcesso.sql
**		Name: TR_GrupoAcesso
**		Desc: Trigger de históricos da tabela GrupoAcesso
**
**		Auth: Convergence
**		Date: 02/06/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TR_GrupoAcesso]'))
BEGIN
	DROP TRIGGER [dbo].[TR_GrupoAcesso]
END
GO
 
CREATE TRIGGER [dbo].[TR_GrupoAcesso] ON dbo.GrupoAcesso
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
	INSERT INTO GrupoAcessoHistorico
	(
		 cdGrupoAcessoSEQ
		,dsGrupoAcesso
		,cdIndicadorStatusGrupoAcesso
		,cdSistemaGrupoAcesso
		,wkGrupoAcesso
		,cdTipoEventoHistorico
		,dtOcorrenciaHistorico
		,cdUsuarioOcorrenciaHistorico
	)
	SELECT
		 cdGrupoAcessoSEQ
		,dsGrupoAcesso
		,cdIndicadorStatusGrupoAcesso
		,cdSistemaGrupoAcesso
		,wkGrupoAcesso
		,@cdTipoEventoHistorico
		,getdate()
		,cdUsuarioUltimaAlteracao

	FROM
		inserted
