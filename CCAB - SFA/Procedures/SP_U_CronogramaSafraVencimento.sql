set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_U_CronogramaSafraVencimento.sql
**		Name: SP_U_CronogramaSafraVencimento
**		Desc: Altera um registro na tabela CronogramaSafraVencimento
**
**		Auth: Convergence
**		Date: 17/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_U_CronogramaSafraVencimento]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_U_CronogramaSafraVencimento]
END
GO
 
CREATE PROCEDURE [dbo].[SP_U_CronogramaSafraVencimento]
	 @cdCronogramaSafraVencimentoSEQ	BIGINT
	,@cdCronogramaSafraSEQ	BIGINT
	,@cdTipoCronogramaSafraVencimento	INT = NULL
	,@dtCronogramaSafraVencimento	DATETIME = NULL
	,@pcCorrecaoPrecoTipoCulturaVencimento	numeric(8,4)
	,@wkCronogramaSafraVencimento	VARCHAR(255) = NULL
	,@cdUsuarioUltimaAlteracao	BIGINT
	,@pcDescontoPontualidade	numeric(8,4)
	
	,@pcParcela1CronogramaSafraVencimento	numeric(8,4)
	,@pcParcela2CronogramaSafraVencimento	numeric(8,4)
	,@pcParcela3CronogramaSafraVencimento	numeric(8,4)
	,@pcParcela4CronogramaSafraVencimento	numeric(8,4)
	,@pcParcela5CronogramaSafraVencimento	numeric(8,4)
	,@pcParcela6CronogramaSafraVencimento	numeric(8,4)
	,@dtParcela1CronogramaSafraVencimento	DATETIME = NULL
	,@dtParcela2CronogramaSafraVencimento	DATETIME = NULL
	,@dtParcela3CronogramaSafraVencimento	DATETIME = NULL
	,@dtParcela4CronogramaSafraVencimento	DATETIME = NULL
	,@dtParcela5CronogramaSafraVencimento	DATETIME = NULL
	,@dtParcela6CronogramaSafraVencimento	DATETIME = NULL
	
 
AS
 
 	-- Verifica o tipo de Vencimento
	if @cdTipoCronogramaSafraVencimento = 1
	begin
		set @dtCronogramaSafraVencimento = null
	end
 
	--atualização
	UPDATE CronogramaSafraVencimento SET
		 cdCronogramaSafraSEQ						= @cdCronogramaSafraSEQ
		,cdTipoCronogramaSafraVencimento			= @cdTipoCronogramaSafraVencimento
		,dtCronogramaSafraVencimento				= @dtCronogramaSafraVencimento
		,pcCorrecaoPrecoTipoCulturaVencimento		= @pcCorrecaoPrecoTipoCulturaVencimento
		,wkCronogramaSafraVencimento				= @wkCronogramaSafraVencimento
		,dtUltimaAlteracao							= getdate()
		,cdUsuarioUltimaAlteracao					= @cdUsuarioUltimaAlteracao
		,pcDescontoPontualidade						= @pcDescontoPontualidade
		
		,pcParcela1CronogramaSafraVencimento		= @pcParcela1CronogramaSafraVencimento	
		,pcParcela2CronogramaSafraVencimento		= @pcParcela2CronogramaSafraVencimento	
		,pcParcela3CronogramaSafraVencimento		= @pcParcela3CronogramaSafraVencimento	
		,pcParcela4CronogramaSafraVencimento		= @pcParcela4CronogramaSafraVencimento	
		,pcParcela5CronogramaSafraVencimento		= @pcParcela5CronogramaSafraVencimento	
		,pcParcela6CronogramaSafraVencimento		= @pcParcela6CronogramaSafraVencimento	
		,dtParcela1CronogramaSafraVencimento		= @dtParcela1CronogramaSafraVencimento	
		,dtParcela2CronogramaSafraVencimento		= @dtParcela2CronogramaSafraVencimento	
		,dtParcela3CronogramaSafraVencimento		= @dtParcela3CronogramaSafraVencimento	
		,dtParcela4CronogramaSafraVencimento		= @dtParcela4CronogramaSafraVencimento	
		,dtParcela5CronogramaSafraVencimento		= @dtParcela5CronogramaSafraVencimento	
		,dtParcela6CronogramaSafraVencimento		= @dtParcela6CronogramaSafraVencimento	
		

	WHERE 
		 cdCronogramaSafraVencimentoSEQ = @cdCronogramaSafraVencimentoSEQ
 
 
