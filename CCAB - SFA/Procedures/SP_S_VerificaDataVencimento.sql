set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_S_VerificaDataVencimento.sql
**		Name: SP_S_VerificaDataVencimento
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
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_S_VerificaDataVencimento]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_S_VerificaDataVencimento]
END
GO
 
CREATE PROCEDURE [dbo].[SP_S_VerificaDataVencimento]
	  @cdCronogramaSafraSEQ	bigint
	 ,@cdTipoCronogramaSafraVencimento int
	 ,@dtCronogramaSafraVencimento datetime = null
	 ,@cdCronogramaSafraVencimentoSEQ bigint
  
AS
 
	IF @cdCronogramaSafraVencimentoSEQ is NULL or @cdCronogramaSafraVencimentoSEQ = 0
	BEGIN
	
		if @cdTipoCronogramaSafraVencimento = 1 --a vista
		begin
 
			--seleção
			SELECT 
				cdCronogramaSafraVencimentoSEQ
			FROM
				CronogramaSafraVencimento (nolock)
			WHERE 
				cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
			and cdTipoCronogramaSafraVencimento = @cdTipoCronogramaSafraVencimento
			and dtCronogramaSafraVencimento is null
			
		end
		else
		begin

			--seleção
			SELECT 
				cdCronogramaSafraVencimentoSEQ
			FROM
				CronogramaSafraVencimento (nolock)
			WHERE 
				cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
			and cdTipoCronogramaSafraVencimento = @cdTipoCronogramaSafraVencimento
			and dtCronogramaSafraVencimento = @dtCronogramaSafraVencimento
			
		end

	END
	ELSE
	BEGIN
	
		if @cdTipoCronogramaSafraVencimento = 1 --a vista
		begin
 
			--seleção
			SELECT 
				cdCronogramaSafraVencimentoSEQ
			FROM
				CronogramaSafraVencimento (nolock)
			WHERE 
				cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
			and cdTipoCronogramaSafraVencimento = @cdTipoCronogramaSafraVencimento
			and dtCronogramaSafraVencimento is null
			and cdCronogramaSafraVencimentoSEQ <> @cdCronogramaSafraVencimentoSEQ
			
		end
		else
		begin

			--seleção
			SELECT 
				cdCronogramaSafraVencimentoSEQ
			FROM
				CronogramaSafraVencimento (nolock)
			WHERE 
				cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
			and cdTipoCronogramaSafraVencimento = @cdTipoCronogramaSafraVencimento
			and dtCronogramaSafraVencimento = @dtCronogramaSafraVencimento
			and cdCronogramaSafraVencimentoSEQ <> @cdCronogramaSafraVencimentoSEQ
			
		end
		
	END
	