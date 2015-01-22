set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_S_VerificaDescricaoCronogramaSafra.sql
**		Name: SP_S_VerificaDescricaoCronogramaSafra
**		Desc: Verifica Disponibilidade para cadastro de Compromisso
**
**		Auth: Convergence
**		Date: 10/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_S_VerificaDescricaoCronogramaSafra]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_S_VerificaDescricaoCronogramaSafra]
END
GO
 
CREATE PROCEDURE [dbo].[SP_S_VerificaDescricaoCronogramaSafra]
	  @dsCronogramaSafra	varchar(30)
	 ,@cdCronogramaSafraSEQ bigint 
  
AS
 
	IF @cdCronogramaSafraSEQ is NULL or @cdCronogramaSafraSEQ = 0
	BEGIN
 
		--seleção
		SELECT 
			cdCronogramaSafraSEQ
		FROM
			CronogramaSafra (nolock)
		WHERE 
			dsCronogramaSafra = @dsCronogramaSafra

	END
	ELSE
	BEGIN
	
		--seleção
		SELECT 
			cdCronogramaSafraSEQ
		FROM
			CronogramaSafra (nolock)
		WHERE 
			dsCronogramaSafra = @dsCronogramaSafra
		AND cdCronogramaSafraSEQ <> @cdCronogramaSafraSEQ
		
	END
	