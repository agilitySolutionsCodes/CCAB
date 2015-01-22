set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_I_GrupoAcessoItemMenuOperacao.sql
**		Name: SP_I_GrupoAcessoItemMenuOperacao
**		Desc: Insere um registro na tabela GrupoAcessoItemMenuOperacao
**
**		Auth: Convergence
**		Date: 18/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_I_GrupoAcessoItemMenuOperacao]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_I_GrupoAcessoItemMenuOperacao]
END
GO
 
CREATE PROCEDURE [dbo].[SP_I_GrupoAcessoItemMenuOperacao]
	 @cdItemMenuSEQ	BIGINT
	,@cdIndicadorTipoMenuOperacao	INT
	,@cdIndicadorStatusGrupoAcessoItemMenuOperacao	INT
	,@cdUsuarioUltimaAlteracao	BIGINT
 
	,@cdGrupoAcessoSEQ	BIGINT	OUTPUT
AS
 
	--inserção
	INSERT INTO GrupoAcessoItemMenuOperacao
	(
	 cdItemMenuSEQ
	,cdIndicadorTipoMenuOperacao
	,cdIndicadorStatusGrupoAcessoItemMenuOperacao
	,dtUltimaAlteracao
	,cdUsuarioUltimaAlteracao
	)
	VALUES
	(
	 @cdItemMenuSEQ
	,@cdIndicadorTipoMenuOperacao
	,@cdIndicadorStatusGrupoAcessoItemMenuOperacao
	,getdate()
	,@cdUsuarioUltimaAlteracao
	)
 
	--retornos
	SELECT
		@cdGrupoAcessoSEQ = SCOPE_IDENTITY()
	SELECT
		@cdGrupoAcessoSEQ as cdGrupoAcessoSEQ
 
 
/*
-----------------------------------------------
Método C#
 
Parâmetros:
Int64 cdItemMenuSEQ, int cdIndicadorTipoMenuOperacao, int cdIndicadorStatusGrupoAcessoItemMenuOperacao, Int64 cdUsuarioUltimaAlteracao
 
Corpo:
			loSqlCommand.Parameters.Add("@cdItemMenuSEQ", SqlDbType.BigInt);
			loSqlCommand.Parameters["@cdItemMenuSEQ"].Value = cdItemMenuSEQ;

			loSqlCommand.Parameters.Add("@cdIndicadorTipoMenuOperacao", SqlDbType.Int);
			loSqlCommand.Parameters["@cdIndicadorTipoMenuOperacao"].Value = cdIndicadorTipoMenuOperacao;

			loSqlCommand.Parameters.Add("@cdIndicadorStatusGrupoAcessoItemMenuOperacao", SqlDbType.Int);
			loSqlCommand.Parameters["@cdIndicadorStatusGrupoAcessoItemMenuOperacao"].Value = cdIndicadorStatusGrupoAcessoItemMenuOperacao;

			loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
			loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

		loSqlCommand.Parameters.Add("@cdGrupoAcessoSEQ", SqlDbType.BigInt);
		loSqlCommand.Parameters["@cdGrupoAcessoSEQ"].Direction = ParameterDirection.Output;
 
Consistências:
		//Consistências
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
