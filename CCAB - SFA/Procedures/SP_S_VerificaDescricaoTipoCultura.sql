set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_S_VerificaDescricaoTipoCultura.sql
**		Name: SP_S_VerificaDescricaoTipoCultura
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
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_S_VerificaDescricaoTipoCultura]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_S_VerificaDescricaoTipoCultura]
END
GO
 
CREATE PROCEDURE [dbo].[SP_S_VerificaDescricaoTipoCultura]
	  @dsTipoCultura	varchar(30)
	 ,@cdTipoCulturaSEQ bigint 
  
AS
 
	IF @cdTipoCulturaSEQ is NULL or @cdTipoCulturaSEQ = 0
	BEGIN
 
		--seleção
		SELECT 
			cdTipoCulturaSEQ
		FROM
			TipoCultura (nolock)
		WHERE 
			dsTipoCultura = @dsTipoCultura

	END
	ELSE
	BEGIN
	
		--seleção
		SELECT 
			cdTipoCulturaSEQ
		FROM
			TipoCultura (nolock)
		WHERE 
			dsTipoCultura = @dsTipoCultura
		AND cdTipoCulturaSEQ <> @cdTipoCulturaSEQ
		
	END
	