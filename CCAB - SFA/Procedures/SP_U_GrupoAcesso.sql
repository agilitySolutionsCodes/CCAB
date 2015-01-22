set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_U_GrupoAcesso.sql
**		Name: SP_U_GrupoAcesso
**		Desc: Altera um registro na tabela GrupoAcesso
**
**		Auth: Convergence
**		Date: 02/06/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_U_GrupoAcesso]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_U_GrupoAcesso]
END
GO
 
CREATE PROCEDURE [dbo].[SP_U_GrupoAcesso]
	 @cdGrupoAcessoSEQ	BIGINT
	,@dsGrupoAcesso	VARCHAR(70)
	,@cdIndicadorStatusGrupoAcesso	int
	,@wkGrupoAcesso	VARCHAR(255) = NULL
	,@cdUsuarioUltimaAlteracao	BIGINT
 
AS
 
	--atualização
	UPDATE GrupoAcesso SET
		 dsGrupoAcesso = @dsGrupoAcesso
		,cdIndicadorStatusGrupoAcesso	= @cdIndicadorStatusGrupoAcesso
		,wkGrupoAcesso = @wkGrupoAcesso
		,dtUltimaAlteracao = getdate()
		,cdUsuarioUltimaAlteracao = @cdUsuarioUltimaAlteracao

	WHERE 
		 cdGrupoAcessoSEQ = @cdGrupoAcessoSEQ
 
 
/*
-----------------------------------------------
Método C#
 
Parâmetros:
Int64 cdGrupoAcessoSEQ, string dsGrupoAcesso, int cdIndicadorStatusGrupoAcesso, Int64 cdSistemaGrupoAcesso, string wkGrupoAcesso, Int64 cdUsuarioUltimaAlteracao
 
Corpo:
			loSqlCommand.Parameters.Add("@cdGrupoAcessoSEQ", SqlDbType.BigInt);
			loSqlCommand.Parameters["@cdGrupoAcessoSEQ"].Value = cdGrupoAcessoSEQ;

			loSqlCommand.Parameters.Add("@dsGrupoAcesso", SqlDbType.VarChar, 70);
			loSqlCommand.Parameters["@dsGrupoAcesso"].Value = dsGrupoAcesso;

			loSqlCommand.Parameters.Add("@cdIndicadorStatusGrupoAcesso", SqlDbType.Int);
			loSqlCommand.Parameters["@cdIndicadorStatusGrupoAcesso"].Value = cdIndicadorStatusGrupoAcesso;

			loSqlCommand.Parameters.Add("@cdSistemaGrupoAcesso", SqlDbType.BigInt);
			loSqlCommand.Parameters["@cdSistemaGrupoAcesso"].Value = cdSistemaGrupoAcesso;

		if (wkGrupoAcesso.Trim() != "")
		{
			loSqlCommand.Parameters.Add("@wkGrupoAcesso", SqlDbType.VarChar, 255);
			loSqlCommand.Parameters["@wkGrupoAcesso"].Value = wkGrupoAcesso;
		}

			loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
			loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

 
Consistências:
		//Consistências
		if (cdGrupoAcessoSEQ == 0)
		{
			return " " + moPadrao.MensagemObrigatorio;
		}

		if (dsGrupoAcesso.Trim() == "")
		{
			return " " + moPadrao.MensagemObrigatorio;
		}

		if (cdIndicadorStatusGrupoAcesso == 0)
		{
			return " " + moPadrao.MensagemObrigatorio;
		}

		if (cdSistemaGrupoAcesso == 0)
		{
			return " " + moPadrao.MensagemObrigatorio;
		}

		if (cdUsuarioUltimaAlteracao == 0)
		{
			return " " + moPadrao.MensagemObrigatorio;
		}

*/
