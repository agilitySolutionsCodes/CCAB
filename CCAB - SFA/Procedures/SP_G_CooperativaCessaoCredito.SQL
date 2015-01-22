/******************************************************************************
**		File: SP_G_CooperativaCessaoCredito.SQL
**		Name: SP_G_CooperativaCessaoCredito
**		Desc: Listar Registros
**
**		Auth: Roberto (Convergence)
**		Date: 05/05/2000
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**		
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_CooperativaCessaoCredito]'))

	BEGIN
		DROP PROCEDURE [dbo].[SP_G_CooperativaCessaoCredito]
	END

GO
 
CREATE PROCEDURE [dbo].[SP_G_CooperativaCessaoCredito]
(
	@cdCooperativaCessaoCreditoSEQ		bigint			= NULL,	
	@cdCronogramaSafraSEQ			bigint			= NULL,	
	@cdCooperativaSEQ				bigint			= NULL,
	@cdIndicadorCessaoCredito			int				= NULL,	
	@wkCooperativaCessaoCredito		varchar(255)	= NULL,	
	@cdUsuarioUltimaAlteracao		bigint			= NULL
)	
AS

	BEGIN 
		
		SELECT
			A.cdCooperativaCessaoCreditoSEQ,
			A.cdCronogramaSafraSEQ,				
			A.cdCooperativaSEQ,
			A.wkCooperativaCessaoCredito,
			A.dtUltimaAlteracao,	
			A.cdUsuarioUltimaAlteracao,
			A.cdIndicadorCessaoCredito,
			PES.nmPessoa + ' - ' + PES.cdPessoaERP  dsAgente,			
			
			(SELECT 
				wkDominioCodigoReferenciado 
			FROM  
				dbo.CodigoReferenciado 
			WHERE 
				vrDominioCodigoReferenciado	= A.cdIndicadorCessaoCredito 
				AND	dsDominioCodigoReferenciado	= 'DMESPINDICADORSIMNAO'				
			)as dsIndicadorCessaoCredito		
			
			
			
			,A.cdIndicadorPedidoNormal
			,A.cdIndicadorPedidoContaOrdem


			,(SELECT 
				wkDominioCodigoReferenciado 
			FROM  
				dbo.CodigoReferenciado 
			WHERE 
				vrDominioCodigoReferenciado	= A.cdIndicadorPedidoNormal 
				AND	dsDominioCodigoReferenciado	= 'DMESPINDICADORSIMNAO'				
			)as dsIndicadorPedidoNormal		


			,(SELECT 
				wkDominioCodigoReferenciado 
			FROM  
				dbo.CodigoReferenciado 
			WHERE 
				vrDominioCodigoReferenciado	= A.cdIndicadorPedidoContaOrdem 
				AND	dsDominioCodigoReferenciado	= 'DMESPINDICADORSIMNAO'				
			)as dsIndicadorPedidoContaOrdem		
			
		FROM
			CooperativaCessaoCredito		A	WITH(NOLOCK)
			INNER JOIN Pessoa			PES WITH(NOLOCK) ON (PES.cdPessoaSEQ = A.cdCooperativaSEQ)						
		WHERE
			(cdCooperativaCessaoCreditoSEQ = @cdCooperativaCessaoCreditoSEQ OR @cdCooperativaCessaoCreditoSEQ IS NULL)
			AND (cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ OR @cdCronogramaSafraSEQ IS NULL)
			AND (cdCooperativaSEQ = @cdCooperativaSEQ OR @cdCooperativaSEQ IS NULL)
			AND (wkCooperativaCessaoCredito = @wkCooperativaCessaoCredito OR @wkCooperativaCessaoCredito IS NULL)			
			AND (A.cdUsuarioUltimaAlteracao = @cdUsuarioUltimaAlteracao OR @cdUsuarioUltimaAlteracao IS NULL)		
	
	END
	
GO
	
 






