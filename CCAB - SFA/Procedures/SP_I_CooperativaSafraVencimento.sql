set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_I_CooperativaSafraVencimento.sql
**		Name: SP_I_CooperativaSafraVencimento
**		Desc: Insere um registro na tabela CooperativaSafraVencimento
**
**		Auth: Convergence
**		Date: 17/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_I_CooperativaSafraVencimento]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_I_CooperativaSafraVencimento]
END
GO
 
CREATE PROCEDURE [dbo].[SP_I_CooperativaSafraVencimento]
	 @cdCronogramaSafraVencimentoSEQ		bigint
	,@cdCooperativaSEQ						bigint
	,@pcCorrecaoPreco						numeric(8,4)
	,@pcDescontoPontualidade				numeric(8,4)
	,@wkCronogramaSafraVencimentoCooperativa varchar(255) = null
	,@cdUsuarioUltimaAlteracao				bigint
	
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
	
	,@cdCronogramaSafraVencimentoCoopSEQ	bigint output
AS
 
	--inserção
	INSERT INTO CronogramaSafraVencimentoCooperativa
	(
	 cdCronogramaSafraVencimentoSEQ
	,cdCooperativaSEQ
	,pcCorrecaoPreco
	,pcDescontoPontualidade
	,wkCronogramaSafraVencimentoCooperativa
	,dtUltimaAlteracao
	,cdUsuarioUltimaAlteracao
	
	,pcParcela1CronogramaSafraVencimento	
	,pcParcela2CronogramaSafraVencimento	
	,pcParcela3CronogramaSafraVencimento	
	,pcParcela4CronogramaSafraVencimento	
	,pcParcela5CronogramaSafraVencimento	
	,pcParcela6CronogramaSafraVencimento	
	,dtParcela1CronogramaSafraVencimento	
	,dtParcela2CronogramaSafraVencimento	
	,dtParcela3CronogramaSafraVencimento	
	,dtParcela4CronogramaSafraVencimento	
	,dtParcela5CronogramaSafraVencimento	
	,dtParcela6CronogramaSafraVencimento	
	
	)
	VALUES
	(
	 @cdCronogramaSafraVencimentoSEQ
	,@cdCooperativaSEQ
	,@pcCorrecaoPreco
	,@pcDescontoPontualidade
	,@wkCronogramaSafraVencimentoCooperativa
	,getdate()
	,@cdUsuarioUltimaAlteracao
	
	,@pcParcela1CronogramaSafraVencimento	
	,@pcParcela2CronogramaSafraVencimento	
	,@pcParcela3CronogramaSafraVencimento	
	,@pcParcela4CronogramaSafraVencimento	
	,@pcParcela5CronogramaSafraVencimento	
	,@pcParcela6CronogramaSafraVencimento	
	,@dtParcela1CronogramaSafraVencimento	
	,@dtParcela2CronogramaSafraVencimento	
	,@dtParcela3CronogramaSafraVencimento	
	,@dtParcela4CronogramaSafraVencimento	
	,@dtParcela5CronogramaSafraVencimento	
	,@dtParcela6CronogramaSafraVencimento	
	
	)
 
	--retornos
	SELECT
		@cdCronogramaSafraVencimentoCoopSEQ = SCOPE_IDENTITY()
	SELECT
		@cdCronogramaSafraVencimentoCoopSEQ as cdCronogramaSafraVencimentoCoopSEQ
 
 

