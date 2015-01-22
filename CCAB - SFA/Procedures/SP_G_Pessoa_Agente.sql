/******************************************************************************
**		File: SP_G_Pessoa_Agente
**		Name: SP_G_Pessoa_Agente
**		Desc: Seleciona registros
**
**		Auth: Ronaldo Mega (Convergence)
**		Date: 06.05.2010 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_Pessoa_Agente]'))
BEGIN
	DROP PROCEDURE [dbo].SP_G_Pessoa_Agente
END
GO

CREATE PROCEDURE [dbo].SP_G_Pessoa_Agente
(
	@CDPESSOASEQ	BIGINT = NULL
)
AS

	BEGIN
	
		SET NOCOUNT ON
		
		SELECT
			 CDPESSOASEQ
			,NMPESSOA 	+ '-' + CDPESSOAERP AS NMPESSOA
		FROM
			PESSOA
		WHERE
			CDINDICADORTIPOPERFILPESSOA = 3	--AGENTE COMERCIAL
			AND (CDPESSOASEQ = @CDPESSOASEQ OR @CDPESSOASEQ IS NULL)
		ORDER BY
			NMPESSOA

		SET NOCOUNT OFF
		
	END
