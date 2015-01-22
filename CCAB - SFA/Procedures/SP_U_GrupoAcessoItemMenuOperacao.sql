set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_U_GrupoAcessoItemMenuOperacao.sql
**		Name: SP_U_GrupoAcessoItemMenuOperacao
**		Desc: Altera um registro na tabela GrupoAcessoItemMenuOperacao
**
**		Auth: Convergence
**		Date: 18/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_U_GrupoAcessoItemMenuOperacao]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_U_GrupoAcessoItemMenuOperacao]
END
GO
 
CREATE PROCEDURE [dbo].[SP_U_GrupoAcessoItemMenuOperacao]
	 @cdGrupoAcessoSEQ	BIGINT
	,@cdItemMenuSEQ	BIGINT
	,@cdIndicadorTipoMenuOperacao	INT
	,@cdIndicadorStatusGrupoAcessoItemMenuOperacao	INT
	,@cdUsuarioUltimaAlteracao	BIGINT
 
AS
 
	--atualização
	UPDATE GrupoAcessoItemMenuOperacao SET
		 cdItemMenuSEQ = @cdItemMenuSEQ
		,cdIndicadorTipoMenuOperacao = @cdIndicadorTipoMenuOperacao
		,cdIndicadorStatusGrupoAcessoItemMenuOperacao = @cdIndicadorStatusGrupoAcessoItemMenuOperacao
		,dtUltimaAlteracao = getdate()
		,cdUsuarioUltimaAlteracao = @cdUsuarioUltimaAlteracao

	WHERE 
		 cdGrupoAcessoSEQ = @cdGrupoAcessoSEQ
 
 
/*
-----------------------------------------------
Método C#
 
Parâmetros:
Int64 cdGrupoAcessoSEQ, Int64 cdItemMenuSEQ, int cdIndicadorTipoMenuOperacao, int cdIndicadorStatusGrupoAcessoItemMenuOperacao, Int64 cdUsuarioUltimaAlteracao
 
Corpo:
			loSqlCommand.Parameters.Add("@cdGrupoAcessoSEQ", SqlDbType.BigInt);
			loSqlCommand.Parameters["@cdGrupoAcessoSEQ"].Value = cdGrupoAcessoSEQ;

			loSqlCommand.Parameters.Add("@cdItemMenuSEQ", SqlDbType.BigInt);
			loSqlCommand.Parameters["@cdItemMenuSEQ"].Value = cdItemMenuSEQ;

			loSqlCommand.Parameters.Add("@cdIndicadorTipoMenuOperacao", SqlDbType.Int);
			loSqlCommand.Parameters["@cdIndicadorTipoMenuOperacao"].Value = cdIndicadorTipoMenuOperacao;

			loSqlCommand.Parameters.Add("@cdIndicadorStatusGrupoAcessoItemMenuOperacao", SqlDbType.Int);
			loSqlCommand.Parameters["@cdIndicadorStatusGrupoAcessoItemMenuOperacao"].Value = cdIndicadorStatusGrupoAcessoItemMenuOperacao;

			loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
			loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

 
Consistências:
		//Consistências
		if (cdGrupoAcessoSEQ == 0)
		{
			return " " + moPadrao.MensagemObrigatorio;
		}

		if (cdItemMenuSEQ == 0)
		{
			return " " + moPadrao.MensagemObrigatorio;
		}

		if (cdIndicadorTipoMenuOperacao == 0)
		{
			return " " + moPadrao.MensagemObrigatorio;
		}

		if (cdIndicadorStatusGrupoAcessoItemMenuOperacao == 0)
		{
			return " " + moPadrao.MensagemObrigatorio;
		}

		if (cdUsuarioUltimaAlteracao == 0)
		{
			return " " + moPadrao.MensagemObrigatorio;
		}

*/
