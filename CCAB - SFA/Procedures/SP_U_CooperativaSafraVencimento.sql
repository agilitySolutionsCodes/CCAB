set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_U_CooperativaSafraVencimento.sql
**		Name: SP_U_CooperativaSafraVencimento
**		Desc: Altera um registro na tabela CronogramaSafraVencimentoCooperativa
**
**		Auth: Convergence
**		Date: 17/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_U_CooperativaSafraVencimento]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_U_CooperativaSafraVencimento]
END
GO
 
CREATE PROCEDURE [dbo].[SP_U_CooperativaSafraVencimento]
	 @cdCronogramaSafraVencimentoCoopSEQ		bigint
 	,@cdCronogramaSafraVencimentoSEQ			bigint
	,@cdCooperativaSEQ							bigint
	,@pcCorrecaoPreco							numeric(8,4)
	,@pcDescontoPontualidade					numeric(8,4)
	,@wkCronogramaSafraVencimentoCooperativa	varchar(255) = null
	,@cdUsuarioUltimaAlteracao					bigint
	
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
 
	--atualização
	UPDATE CronogramaSafraVencimentoCooperativa SET
 		 cdCronogramaSafraVencimentoSEQ				= @cdCronogramaSafraVencimentoSEQ
		,cdCooperativaSEQ							= @cdCooperativaSEQ
		,pcCorrecaoPreco							= @pcCorrecaoPreco
		,pcDescontoPontualidade						= @pcDescontoPontualidade
		,wkCronogramaSafraVencimentoCooperativa		= @wkCronogramaSafraVencimentoCooperativa
		,cdUsuarioUltimaAlteracao					= @cdUsuarioUltimaAlteracao
		,dtUltimaAlteracao							= getdate()

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
		cdCronogramaSafraVencimentoCoopSEQ = @cdCronogramaSafraVencimentoCoopSEQ
 

