set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_G_TipoCultura.sql
**		Name: SP_G_TipoCultura
**		Desc: Seleciona os registros da tabela TipoCultura
**
**		Auth: Roberto Chaparro
**		Date: Mar 10 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_TipoCultura]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_TipoCultura]
END
GO

CREATE PROCEDURE [dbo].[SP_G_TipoCultura]
	 @cdTipoCulturaSEQ				bigint			= null
	,@dsTipoCultura					varchar(30)		= null
	,@cdIndicadorStatusTipoCultura	int				= null

AS

	DECLARE
		@lsComando		varchar(max)


	select
		 @lsComando = 'SELECT ' 

		,@lsComando = @lsComando + '	  		 A.cdTipoCulturaSEQ'
		,@lsComando = @lsComando + '	  		,A.cdTipoCulturaERP'
		,@lsComando = @lsComando + '	  		,A.dsTipoCultura'
		,@lsComando = @lsComando + '	  		,A.cdIndicadorStatusTipoCultura'
		,@lsComando = @lsComando + '	  		,A.wkTipoCultura'
		,@lsComando = @lsComando + '	  		,A.dtUltimaAlteracao'
		,@lsComando = @lsComando + '	  		,A.cdUsuarioUltimaAlteracao'
		,@lsComando = @lsComando + '            ,A.nuOrdemApresentacaoTipoCultura'

		,@lsComando = @lsComando + '	  		,('
		,@lsComando = @lsComando + '	  			SELECT'
		,@lsComando = @lsComando + '	  				wkDominioCodigoReferenciado'
		,@lsComando = @lsComando + '	  			FROM'
		,@lsComando = @lsComando + '	  				dbo.CodigoReferenciado			(nolock)'
		,@lsComando = @lsComando + '	  			WHERE'
		,@lsComando = @lsComando + '	  				vrDominioCodigoReferenciado		= A.cdIndicadorStatusTipoCultura'
		,@lsComando = @lsComando + '	  			AND	dsDominioCodigoReferenciado		= ''DMESPINDICADORATIVOINATIVO'' '
		,@lsComando = @lsComando + '	  		)	as dsIndicadorStatusTipoCultura'



		,@lsComando = @lsComando + '	  	FROM'
		,@lsComando = @lsComando + '	  		dbo.TipoCultura				A (nolock)'
		,@lsComando = @lsComando + '		WHERE '
		,@lsComando = @lsComando + '			cdTipoCulturaSEQ > 0 ' 


		IF NOT @cdTipoCulturaSEQ is null
		BEGIN
			select
				@lsComando = @lsComando + '	AND	A.cdTipoCulturaSEQ	= ' + convert(varchar, @cdTipoCulturaSEQ) + ' '
		END


		IF NOT @dsTipoCultura is null
		BEGIN
			select
				 @lsComando = @lsComando + 'AND	 upper(ltrim(rtrim(dsTipoCultura))) like ''' + '%'
				,@lsComando = @lsComando + upper(ltrim(rtrim(@dsTipoCultura)))
				,@lsComando = @lsComando + '%' + '''' 
		END

		IF NOT @cdIndicadorStatusTipoCultura is null
		BEGIN
			select
				@lsComando = @lsComando + '	AND	A.cdIndicadorStatusTipoCultura	= ' + convert(varchar, @cdIndicadorStatusTipoCultura) + ' '
		END

	select
		 @lsComando = @lsComando + '	  	ORDER BY'
		,@lsComando = @lsComando + '	  		A.nuOrdemApresentacaoTipoCultura, A.dsTipoCultura'
		

	exec(@lsComando)

SET QUOTED_IDENTIFIER OFF

