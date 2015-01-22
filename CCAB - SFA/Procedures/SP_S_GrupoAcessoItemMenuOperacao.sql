set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_S_GrupoAcessoItemMenuOperacao.sql
**		Name: SP_S_GrupoAcessoItemMenuOperacao
**		Desc: Obtem um registro da tabela GrupoAcessoItemMenuOperacao
**
**		Auth: Convergence
**		Date: 18/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_S_GrupoAcessoItemMenuOperacao]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_S_GrupoAcessoItemMenuOperacao]
END
GO
 
CREATE PROCEDURE [dbo].[SP_S_GrupoAcessoItemMenuOperacao]
	 @cdGrupoAcessoSEQ	BIGINT
 
 
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
	WHERE 
		cdGrupoAcessoSEQ = @cdGrupoAcessoSEQ
 
 
/*
-----------------------------------------------
Método C#
 
Parâmetros:
Int64 cdGrupoAcessoSEQ
 
Corpo:
loSqlCommand.Parameters.Add("@cdGrupoAcessoSEQ", SqlDbType.BigInt);
loSqlCommand.Parameters["@cdGrupoAcessoSEQ"].Value = cdGrupoAcessoSEQ;
*/
