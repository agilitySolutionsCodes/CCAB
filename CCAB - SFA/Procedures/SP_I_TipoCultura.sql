set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_I_TipoCultura.sql
**		Name: SP_I_TipoCultura
**		Desc: Insere registros na tabela TipoCultura
**
**		Auth: Roberto Chaparro
**		Date: Mar 10 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_I_TipoCultura]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_I_TipoCultura]
END
GO

CREATE PROCEDURE [dbo].[SP_I_TipoCultura]
	 @cdTipoCulturaERP				bigint				= null
	,@dsTipoCultura					varchar(30)
	,@nuOrdemApresentacaoTipoCultura int				= null
	,@wkTipoCultura					varchar(255)		= null
	,@cdUsuarioUltimaAlteracao		bigint

	,@cdTipoCulturaSEQ				bigint				OUTPUT
AS


	INSERT INTO	dbo.TipoCultura
		(cdTipoCulturaERP
		,dsTipoCultura
		,cdIndicadorStatusTipoCultura
		,nuOrdemApresentacaoTipoCultura
		,wkTipoCultura
		,dtUltimaAlteracao
		,cdUsuarioUltimaAlteracao)
	VALUES
		(@cdTipoCulturaERP
		,@dsTipoCultura
		,1 -- Ativo
		,@nuOrdemApresentacaoTipoCultura
		,@wkTipoCultura
		,getdate()
		,@cdUsuarioUltimaAlteracao)



	select
		@cdTipoCulturaSEQ = SCOPE_IDENTITY()



--	--Inserção automática
--	exec SP_I_TipoCultura_Produto	
--		 @cdTipoCulturaSEQ			= @cdTipoCulturaSEQ
--		,@cdUsuarioUltimaAlteracao	= @cdUsuarioUltimaAlteracao


	select
		@cdTipoCulturaSEQ	as cdTipoCulturaSEQ


SET QUOTED_IDENTIFIER OFF

