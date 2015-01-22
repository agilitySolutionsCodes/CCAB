set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_S_GrupoAcesso
**		Name: SP_S_GrupoAcesso
**		Desc: Seleciona os registros na tabela GrupoAcesso
**
**		Auth: Roberto Chaparro
**		Date: Jun 3 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_S_GrupoAcesso]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_S_GrupoAcesso]
END
GO

CREATE PROCEDURE [dbo].[SP_S_GrupoAcesso]
	 @cdGrupoAcessoSEQ			bigint
AS

	SELECT
		 cdGrupoAcessoSEQ
		,dsGrupoAcesso
		,cdIndicadorStatusGrupoAcesso
		,cdSistemaGrupoAcesso
		,wkGrupoAcesso
		,dtUltimaAlteracao
		,cdUsuarioUltimaAlteracao
	FROM
		dbo.GrupoAcesso
	WHERE
		cdGrupoAcessoSEQ			= @cdGrupoAcessoSEQ



SET QUOTED_IDENTIFIER OFF

