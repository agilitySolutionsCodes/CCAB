set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_S_CooperativaSafraVencimento.sql
**		Name: SP_S_CooperativaSafraVencimento
**		Desc: Obtem um registro da tabela CronogramaSafraVencimentoCooperativa
**
**		Auth: Convergence
**		Date: 17/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_S_CooperativaSafraVencimento]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_S_CooperativaSafraVencimento]
END
GO
 
CREATE PROCEDURE [dbo].[SP_S_CooperativaSafraVencimento]
	 @cdCronogramaSafraVencimentoCoopSEQ	BIGINT
 
 
AS
 
	--seleção
	SELECT
		 cdCronogramaSafraVencimentoCoopSEQ		
		,cdCronogramaSafraVencimentoSEQ			
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
		
	FROM
		CronogramaSafraVencimentoCooperativa WITH(NOLOCK)
	WHERE
		cdCronogramaSafraVencimentoCoopSEQ = @cdCronogramaSafraVencimentoCoopSEQ 

 

