set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_G_GrupoAcessoItemMenuOperacao.sql
**		Name: SP_G_GrupoAcessoItemMenuOperacao
**		Desc: Obtem registros da tabela GrupoAcessoItemMenuOperacao
**
**		Auth: Convergence
**		Date: 18/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_GrupoAcessoItemMenuOperacao]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_GrupoAcessoItemMenuOperacao]
END
GO
 
CREATE PROCEDURE [dbo].[SP_G_GrupoAcessoItemMenuOperacao]
AS
 
	--seleção
	SELECT 
		 cdGrupoAcessoSEQ
		,cdItemMenuSEQ
		,cdIndicadorTipoMenuOperacao
		,cdIndicadorStatusGrupoAcessoItemMenuOperacao
		,dtUltimaAlteracao
		,cdUsuarioUltimaAlteracao

	FROM
		GrupoAcessoItemMenuOperacao (nolock)
