/******************************************************************************
**		File: SP_G_CooperativaContaOrdem.SQL
**		Name: SP_G_CooperativaContaOrdem
**		Desc: Listar Registros
**
**		Auth: Ronaldo Mega (Convergence)
**		Date: 24/05/2010
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**		
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_CooperativaContaOrdem]'))

	BEGIN
		DROP PROCEDURE [dbo].[SP_G_CooperativaContaOrdem]
	END

GO
 
CREATE PROCEDURE [dbo].[SP_G_CooperativaContaOrdem]
(
	@cdCooperativaContaOrdemSEQ		bigint			= NULL,	
	@cdCronogramaSafraSEQ			bigint			= NULL,	
	@cdCooperativaSEQ				bigint			= NULL,
	@cdIndicadorContaOrdem			int				= NULL,	
	@wkCooperativaContaOrdem		varchar(255)	= NULL,	
	@cdUsuarioUltimaAlteracao		bigint			= NULL
)	
AS

	BEGIN 
		
		SELECT
			A.cdCooperativaContaOrdemSEQ,
			A.cdCronogramaSafraSEQ,				
			A.cdCooperativaSEQ,
			A.wkCooperativaContaOrdem,
			A.dtUltimaAlteracao,	
			A.cdUsuarioUltimaAlteracao,
			A.cdIndicadorContaOrdem,
			PES.nmPessoa + ' - ' + PES.cdPessoaERP  dsAgente,			
			
			(SELECT 
				wkDominioCodigoReferenciado 
			FROM  
				dbo.CodigoReferenciado 
			WHERE 
				vrDominioCodigoReferenciado	= A.cdIndicadorContaOrdem 
				AND	dsDominioCodigoReferenciado	= 'DMESPINDICADORSIMNAO'				
			)as dsIndicadorContaOrdem		
			
			
		FROM
			CooperativaContaOrdem		A	WITH(NOLOCK)
			INNER JOIN Pessoa			PES WITH(NOLOCK) ON (PES.cdPessoaSEQ = A.cdCooperativaSEQ)						
		WHERE
			(cdCooperativaContaOrdemSEQ = @cdCooperativaContaOrdemSEQ OR @cdCooperativaContaOrdemSEQ IS NULL)
			AND (cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ OR @cdCronogramaSafraSEQ IS NULL)
			AND (cdCooperativaSEQ = @cdCooperativaSEQ OR @cdCooperativaSEQ IS NULL)
			AND (wkCooperativaContaOrdem = @wkCooperativaContaOrdem OR @wkCooperativaContaOrdem IS NULL)			
			AND (A.cdUsuarioUltimaAlteracao = @cdUsuarioUltimaAlteracao OR @cdUsuarioUltimaAlteracao IS NULL)		
	
	END
	
GO
	
 






