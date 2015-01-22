set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_I_GrupoAcesso.sql
**		Name: SP_I_GrupoAcesso
**		Desc: Insere um registro na tabela GrupoAcesso
**
**		Auth: Convergence
**		Date: 02/06/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_I_GrupoAcesso]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_I_GrupoAcesso]
END
GO
 
CREATE PROCEDURE [dbo].[SP_I_GrupoAcesso]
	 @dsGrupoAcesso	VARCHAR(70)
	,@wkGrupoAcesso	VARCHAR(255) = NULL
	,@cdUsuarioUltimaAlteracao	BIGINT
 
	,@cdGrupoAcessoSEQ	BIGINT	OUTPUT
AS
 
	--inserção
	INSERT INTO GrupoAcesso
	(
	 dsGrupoAcesso
	,cdIndicadorStatusGrupoAcesso
	,cdSistemaGrupoAcesso
	,wkGrupoAcesso
	,dtUltimaAlteracao
	,cdUsuarioUltimaAlteracao
	)
	VALUES
	(
	 @dsGrupoAcesso
	,1
	,1
	,@wkGrupoAcesso
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
string dsGrupoAcesso, int cdIndicadorStatusGrupoAcesso, Int64 cdSistemaGrupoAcesso, string wkGrupoAcesso, Int64 cdUsuarioUltimaAlteracao
 
Corpo:
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

		loSqlCommand.Parameters.Add("@cdGrupoAcessoSEQ", SqlDbType.BigInt);
		loSqlCommand.Parameters["@cdGrupoAcessoSEQ"].Direction = ParameterDirection.Output;
 
Consistências:
		//Consistências
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
