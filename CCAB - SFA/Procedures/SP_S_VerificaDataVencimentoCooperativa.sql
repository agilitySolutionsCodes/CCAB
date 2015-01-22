set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_S_VerificaDataVencimentoCooperativa.sql
**		Name: SP_S_VerificaDataVencimentoCooperativa
**		Desc: Verifica Disponibilidade para cadastro Cooperativa x Data de Vencimento
**
**		Auth: Convergence
**		Date: 10/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_S_VerificaDataVencimentoCooperativa]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_S_VerificaDataVencimentoCooperativa]
END
GO
 
CREATE PROCEDURE [dbo].[SP_S_VerificaDataVencimentoCooperativa]
	  @cdCronogramaSafraVencimentoSEQ bigint
	 ,@cdCooperativaSEQ bigint
  
AS
 
	SELECT
		cdCronogramaSafraVencimentoCoopSEQ
	FROM	
		CronogramaSafraVencimentoCooperativa
	WHERE
		cdCronogramaSafraVencimentoSEQ = @cdCronogramaSafraVencimentoSEQ
	AND
		cdCooperativaSEQ = @cdCooperativaSEQ
 
 

