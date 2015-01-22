set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_U_TipoCultura.sql
**		Name: SP_U_TipoCultura
**		Desc: Altera um registro na tabela TipoCultura
**
**		Auth: Convergence
**		Date: 17/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_U_TipoCultura]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_U_TipoCultura]
END
GO
 
CREATE PROCEDURE [dbo].[SP_U_TipoCultura]
	 @cdTipoCulturaSEQ	BIGINT
	,@cdTipoCulturaERP	VARCHAR(30) = NULL
	,@dsTipoCultura	VARCHAR(30)
	,@cdIndicadorStatusTipoCultura	INT
	,@nuOrdemApresentacaoTipoCultura int = null
	,@wkTipoCultura	VARCHAR(255) = NULL
	,@cdUsuarioUltimaAlteracao	BIGINT
 
AS
 
	--atualização
	UPDATE TipoCultura SET
		 cdTipoCulturaERP = @cdTipoCulturaERP
		,dsTipoCultura = @dsTipoCultura
		,cdIndicadorStatusTipoCultura = @cdIndicadorStatusTipoCultura
		,nuOrdemApresentacaoTipoCultura = @nuOrdemApresentacaoTipoCultura
		,wkTipoCultura = @wkTipoCultura
		,dtUltimaAlteracao = getdate()
		,cdUsuarioUltimaAlteracao = @cdUsuarioUltimaAlteracao

	WHERE 
		 cdTipoCulturaSEQ = @cdTipoCulturaSEQ
 
 
/*
-----------------------------------------------
Método C#
 
Parâmetros:
Int64 cdTipoCulturaSEQ, string cdTipoCulturaERP, string dsTipoCultura, int cdIndicadorStatusTipoCultura, string wkTipoCultura, Int64 cdUsuarioUltimaAlteracao
 
Corpo:
			loSqlCommand.Parameters.Add("@cdTipoCulturaSEQ", SqlDbType.BigInt);
			loSqlCommand.Parameters["@cdTipoCulturaSEQ"].Value = cdTipoCulturaSEQ;

			loSqlCommand.Parameters.Add("@cdTipoCulturaERP", SqlDbType.VarChar, 30);
			loSqlCommand.Parameters["@cdTipoCulturaERP"].Value = cdTipoCulturaERP;

			loSqlCommand.Parameters.Add("@dsTipoCultura", SqlDbType.VarChar, 30);
			loSqlCommand.Parameters["@dsTipoCultura"].Value = dsTipoCultura;

			loSqlCommand.Parameters.Add("@cdIndicadorStatusTipoCultura", SqlDbType.Int);
			loSqlCommand.Parameters["@cdIndicadorStatusTipoCultura"].Value = cdIndicadorStatusTipoCultura;

		if (wkTipoCultura.Trim() != "")
		{
			loSqlCommand.Parameters.Add("@wkTipoCultura", SqlDbType.VarChar, 255);
			loSqlCommand.Parameters["@wkTipoCultura"].Value = wkTipoCultura;
		}

			loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
			loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

*/
