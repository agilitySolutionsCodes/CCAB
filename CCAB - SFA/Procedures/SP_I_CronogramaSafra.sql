set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_I_CronogramaSafra.sql
**		Name: SP_I_CronogramaSafra
**		Desc: Insere um registro na tabela CronogramaSafra
**
**		Auth: Convergence
**		Date: 17/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_I_CronogramaSafra]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_I_CronogramaSafra]
END
GO
 
CREATE PROCEDURE [dbo].[SP_I_CronogramaSafra]
	 @dsCronogramaSafra	VARCHAR(30)
	,@dtInicioCronogramaSafra	DATETIME
	,@dtFimCronogramaSafra	DATETIME
	,@dtLimiteLiberacaoCCCronogramaSafra	DATETIME
	,@dtLimiteAprovacaoCCCronogramaSafra	DATETIME
	,@dtLimiteLiberacaoPVCronogramaSafra	DATETIME
	,@dtLimiteAprovacaoPVRCCronogramaSafra	DATETIME
	,@dtLimiteAprovacaoPVACCronogramaSafra	DATETIME
	,@wkCronogramaSafra	VARCHAR(255) = NULL
	,@cdIndicadorStatusCronogramaSafra int 
	,@cdUsuarioUltimaAlteracao	BIGINT
	,@qtProdutoPrecoCronogramaSafra int
 
	,@cdCronogramaSafraSEQ	BIGINT	OUTPUT
AS
 
	--inserção
	INSERT INTO CronogramaSafra
	(
	 dsCronogramaSafra
	,dtInicioCronogramaSafra
	,dtFimCronogramaSafra
	,dtLimiteLiberacaoCCCronogramaSafra
	,dtLimiteAprovacaoCCCronogramaSafra
	,dtLimiteLiberacaoPVCronogramaSafra
	,dtLimiteAprovacaoPVRCCronogramaSafra
	,dtLimiteAprovacaoPVACCronogramaSafra
	,wkCronogramaSafra
	,cdIndicadorSituacaoCronogramaSafra
	,dtUltimaAlteracao
	,cdUsuarioUltimaAlteracao
	,qtProdutoPrecoCronogramaSafra
	)
	VALUES
	(
	 @dsCronogramaSafra
	,@dtInicioCronogramaSafra
	,@dtFimCronogramaSafra
	,@dtLimiteLiberacaoCCCronogramaSafra
	,@dtLimiteAprovacaoCCCronogramaSafra
	,@dtLimiteLiberacaoPVCronogramaSafra
	,@dtLimiteAprovacaoPVRCCronogramaSafra
	,@dtLimiteAprovacaoPVACCronogramaSafra
	,@wkCronogramaSafra
	,@cdIndicadorStatusCronogramaSafra
	,getdate()
	,@cdUsuarioUltimaAlteracao
	,@qtProdutoPrecoCronogramaSafra
	)
 
	--retornos
	SELECT
		@cdCronogramaSafraSEQ = SCOPE_IDENTITY()
	SELECT
		@cdCronogramaSafraSEQ as cdCronogramaSafraSEQ
 
 
/*
-----------------------------------------------
Método C#
 
Parâmetros:
string dsCronogramaSafra, DateTime dtInicioCronogramaSafra, DateTime dtFimCronogramaSafra, DateTime dtLimiteLiberacaoCCCronogramaSafra, DateTime dtLimiteAprovacaoCCCronogramaSafra, DateTime dtLimiteLiberacaoPVCronogramaSafra, DateTime dtLimiteAprovacaoPVRCCronogramaSafra, DateTime dtLimiteAprovacaoPVACCronogramaSafra, string wkCronogramaSafra, Int64 cdUsuarioUltimaAlteracao
 
Corpo:
			loSqlCommand.Parameters.Add("@dsCronogramaSafra", SqlDbType.VarChar, 30);
			loSqlCommand.Parameters["@dsCronogramaSafra"].Value = dsCronogramaSafra;

			loSqlCommand.Parameters.Add("@dtInicioCronogramaSafra", SqlDbType.DateTime);
			loSqlCommand.Parameters["@dtInicioCronogramaSafra"].Value = dtInicioCronogramaSafra;

			loSqlCommand.Parameters.Add("@dtFimCronogramaSafra", SqlDbType.DateTime);
			loSqlCommand.Parameters["@dtFimCronogramaSafra"].Value = dtFimCronogramaSafra;

			loSqlCommand.Parameters.Add("@dtLimiteLiberacaoCCCronogramaSafra", SqlDbType.DateTime);
			loSqlCommand.Parameters["@dtLimiteLiberacaoCCCronogramaSafra"].Value = dtLimiteLiberacaoCCCronogramaSafra;

			loSqlCommand.Parameters.Add("@dtLimiteAprovacaoCCCronogramaSafra", SqlDbType.DateTime);
			loSqlCommand.Parameters["@dtLimiteAprovacaoCCCronogramaSafra"].Value = dtLimiteAprovacaoCCCronogramaSafra;

			loSqlCommand.Parameters.Add("@dtLimiteLiberacaoPVCronogramaSafra", SqlDbType.DateTime);
			loSqlCommand.Parameters["@dtLimiteLiberacaoPVCronogramaSafra"].Value = dtLimiteLiberacaoPVCronogramaSafra;

			loSqlCommand.Parameters.Add("@dtLimiteAprovacaoPVRCCronogramaSafra", SqlDbType.DateTime);
			loSqlCommand.Parameters["@dtLimiteAprovacaoPVRCCronogramaSafra"].Value = dtLimiteAprovacaoPVRCCronogramaSafra;

			loSqlCommand.Parameters.Add("@dtLimiteAprovacaoPVACCronogramaSafra", SqlDbType.DateTime);
			loSqlCommand.Parameters["@dtLimiteAprovacaoPVACCronogramaSafra"].Value = dtLimiteAprovacaoPVACCronogramaSafra;

		if (wkCronogramaSafra.Trim() != "")
		{
			loSqlCommand.Parameters.Add("@wkCronogramaSafra", SqlDbType.VarChar, 255);
			loSqlCommand.Parameters["@wkCronogramaSafra"].Value = wkCronogramaSafra;
		}

			loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
			loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

		loSqlCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
		loSqlCommand.Parameters["@cdCronogramaSafraSEQ"].Direction = ParameterDirection.Output;
 
Consistências:
		//Consistências
		if (dsCronogramaSafra.Trim() == "")
		{
			return " " + moPadrao.MensagemObrigatorio;
		}

		if (dtInicioCronogramaSafra == DateTime.MinValue)
		{
			return " " + moPadrao.MensagemObrigatorio;
		}

		if (dtFimCronogramaSafra == DateTime.MinValue)
		{
			return " " + moPadrao.MensagemObrigatorio;
		}

		if (dtLimiteLiberacaoCCCronogramaSafra == DateTime.MinValue)
		{
			return " " + moPadrao.MensagemObrigatorio;
		}

		if (dtLimiteAprovacaoCCCronogramaSafra == DateTime.MinValue)
		{
			return " " + moPadrao.MensagemObrigatorio;
		}

		if (dtLimiteLiberacaoPVCronogramaSafra == DateTime.MinValue)
		{
			return " " + moPadrao.MensagemObrigatorio;
		}

		if (dtLimiteAprovacaoPVRCCronogramaSafra == DateTime.MinValue)
		{
			return " " + moPadrao.MensagemObrigatorio;
		}

		if (dtLimiteAprovacaoPVACCronogramaSafra == DateTime.MinValue)
		{
			return " " + moPadrao.MensagemObrigatorio;
		}

		if (cdUsuarioUltimaAlteracao == 0)
		{
			return " " + moPadrao.MensagemObrigatorio;
		}

*/
