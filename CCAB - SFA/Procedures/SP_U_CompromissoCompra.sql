set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_U_CompromissoCompra.sql
**		Name: SP_U_CompromissoCompra
**		Desc: Efetiva a Gravação do Pedido
**
**		Auth: Convergence
**		Date: 16/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_U_CompromissoCompra]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_U_CompromissoCompra]
END
GO
 
CREATE PROCEDURE [dbo].[SP_U_CompromissoCompra]
	 @tmpCompromissoCompraSEQ			BIGINT
	,@cdCompromissoCompraSEQ			BIGINT	
	,@cdUsuarioUltimaAlteracao	BIGINT
AS

	-- Define Variaveis CompromissoCompra
	declare @cdAgenteComercialCooperativaCompromissoCompra	bigint
	declare	@cdAgenteComercialCCABCompromissoCompra			bigint
	declare	@cdAgenteComercialRCCompromissoCompra				bigint
	declare	@cdCronogramaSafraSEQ						bigint
	declare	@dtEmissaoCompromissoCompra						datetime
	declare	@cdIndicadorStatusCompromissoCompra				int
	declare	@cdIndicadorMoedaCompromissoCompra				int
	declare	@vrTotalMoedaCompromissoCompra					numeric(22,4)
	declare	@vrTotalAbertoMoedaCompromissoCompra				numeric(22,4)
	declare @cdPessoaOrigemFaturamento					bigint

	-- Define Variaveis CompromissoCompraItem	
	declare @tmpCompromissoCompraItemSEQ						bigint
	declare @cdProdutoSEQ								bigint
	declare @cdCronogramaSafraVencimentoSEQ				bigint
	declare @qtCompromissoCompraItem							numeric(22,4)
	declare @qtAbertoCompromissoCompraItem					numeric(22,4)
	declare @vrUnitarioMoedaCompromissoCompraItem				numeric(22,4)
	declare @vrTotalMoedaCompromissoCompraItem				numeric(22,4)
	declare @vrTotalMoedaAbertoCompromissoCompraItem			numeric(22,4)
	declare @Fetch_tmpCompromissoCompraItem					int

	-- Busca Valor total do Compromisso
	set @vrTotalMoedaCompromissoCompra = 0
	select @vrTotalMoedaCompromissoCompra = sum(vrTotalMoedaCompromissoCompraItem)
	from tmpCompromissoCompraItem
	where tmpCompromissoCompraSEQ = @tmpCompromissoCompraSEQ

	-- Busca Valor total em Aberto do Compromisso
	set @vrTotalAbertoMoedaCompromissoCompra = 0
	select @vrTotalAbertoMoedaCompromissoCompra = sum(vrTotalMoedaCompromissoCompraItem)
	from tmpCompromissoCompraItem
	where tmpCompromissoCompraSEQ = @tmpCompromissoCompraSEQ
	
	-- Atualiza Compromisso Compra
	
	IF NOT EXISTS (select 1 from CompromissoCompra where cdCompromissoCompraSEQ = @cdCompromissoCompraSEQ)
	BEGIN
		RAISERROR ('5002 - Erro na Busca do Compromisso de Compra para a Alteração',16,1)
		RETURN	
	END	
	
	SELECT 	@cdAgenteComercialCooperativaCompromissoCompra	= cdAgenteComercialCooperativaCompromissoCompra	
	       ,@cdAgenteComercialCCABCompromissoCompra			= cdAgenteComercialCCABCompromissoCompra			
	       ,@cdAgenteComercialRCCompromissoCompra				= cdAgenteComercialRCCompromissoCompra				
	       ,@cdCompromissoCompraSEQ						= cdCompromissoCompraSEQ
	       ,@cdCronogramaSafraSEQ						= cdCronogramaSafraSEQ						
	       ,@dtEmissaoCompromissoCompra						= dtEmissaoCompromissoCompra						
	       ,@cdIndicadorStatusCompromissoCompra				= cdIndicadorStatusCompromissoCompra				
	       ,@cdIndicadorMoedaCompromissoCompra				= cdIndicadorMoedaCompromissoCompra				
	       ,@cdPessoaOrigemFaturamento					= cdPessoaOrigemFaturamento
	FROM	
		tmpCompromissoCompra
	WHERE
		tmpCompromissoCompraSEQ = @tmpCompromissoCompraSEQ
	
	UPDATE CompromissoCompra
		set  dtEmissaoCompromissoCompra				= @dtEmissaoCompromissoCompra
			,cdIndicadorStatusCompromissoCompra			= @cdIndicadorStatusCompromissoCompra
			,cdIndicadorMoedaCompromissoCompra			= @cdIndicadorMoedaCompromissoCompra
			,vrTotalMoedaCompromissoCompra				= @vrTotalMoedaCompromissoCompra
			,vrTotalAbertoMoedaCompromissoCompra			= @vrTotalAbertoMoedaCompromissoCompra
			,dtUltimaAlteracao						= getdate()
			,cdUsuarioUltimaAlteracao				= @cdUsuarioUltimaAlteracao
			,cdPessoaOrigemFaturamento				= @cdPessoaOrigemFaturamento
	WHERE
		cdCompromissoCompraSEQ = @cdCompromissoCompraSEQ

	IF @@ERROR <> 0  OR @@ROWCOUNT = 0
	BEGIN
		RAISERROR ('5003 - Erro na Alteração do Compromisso',16,1)
		RETURN	
	END
	
	-- Atualiza Pedido Compromisso Compra Item
	DECLARE CS_tmpCompromissoCompraItem CURSOR FOR
	SELECT	 tmpCompromissoCompraItemSEQ
			,cdProdutoSEQ
			,cdCronogramaSafraSEQ
			,cdCronogramaSafraVencimentoSEQ
			,qtCompromissoCompraItem
			,qtAbertoCompromissoCompraItem
			,vrUnitarioMoedaCompromissoCompraItem
			,vrTotalMoedaCompromissoCompraItem
			,vrTotalMoedaAbertoCompromissoCompraItem
	FROM	tmpCompromissoCompraItem
	WHERE	tmpCompromissoCompraSEQ = @tmpCompromissoCompraSEQ

	OPEN CS_tmpCompromissoCompraItem
	FETCH NEXT FROM CS_tmpCompromissoCompraItem
	INTO	 @tmpCompromissoCompraItemSEQ
			,@cdProdutoSEQ
			,@cdCronogramaSafraSEQ
			,@cdCronogramaSafraVencimentoSEQ
			,@qtCompromissoCompraItem
			,@qtAbertoCompromissoCompraItem
			,@vrUnitarioMoedaCompromissoCompraItem
			,@vrTotalMoedaCompromissoCompraItem
			,@vrTotalMoedaAbertoCompromissoCompraItem
						
	SET @Fetch_tmpCompromissoCompraItem = @@FETCH_STATUS

	WHILE @Fetch_tmpCompromissoCompraItem = 0
	BEGIN
	
		if exists (	select	1 
					from	CompromissoCompraitem 
					where	cdCompromissoCompraSEQ = @cdCompromissoCompraSEQ
					and		cdProdutoSEQ = @cdProdutoSEQ
					and     cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
					and     cdCronogramaSafraVencimentoSEQ = @cdCronogramaSafraVencimentoSEQ)
		BEGIN
					
			UPDATE CompromissoCompraItem
			SET	 qtCompromissoCompraItem = @qtCompromissoCompraItem
				,qtAbertoCompromissoCompraItem = @qtAbertoCompromissoCompraItem
				,vrTotalMoedaCompromissoCompraItem = @vrTotalMoedaCompromissoCompraItem
				,vrTotalMoedaAbertoCompromissoCompraItem = @vrTotalMoedaAbertoCompromissoCompraItem
				,dtUltimaAlteracao = getdate()
				,cdUsuarioUltimaAlteracao = @cdUsuarioUltimaAlteracao
				,vrUnitarioMoedaCompromissoCompraItem = @vrUnitarioMoedaCompromissoCompraItem
				,pcDescontoPontualidade = dbo.FN_BuscaPontualidadeCompromisso(@cdCompromissoCompraSEQ, @cdCronogramaSafraVencimentoSEQ,2)			
			WHERE
				cdCompromissoCompraSEQ = @cdCompromissoCompraSEQ
			and cdProdutoSEQ = @cdProdutoSEQ
			and cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
			and cdCronogramaSafraVencimentoSEQ = @cdCronogramaSafraVencimentoSEQ

			IF @@ERROR <> 0  OR @@ROWCOUNT = 0
			BEGIN
				RAISERROR ('5004 - Erro na Alteração dos Itens do Compromisso',16,1)
				CLOSE CS_tmpCompromissoCompraItem
				DEALLOCATE CS_tmpCompromissoCompraItem
				RETURN	
			END
			
		END
		
		ELSE
		
		BEGIN
		
			INSERT INTO CompromissoCompraITEM
			(
				cdCompromissoCompraSEQ
				,cdProdutoSEQ
				,cdCronogramaSafraSEQ
				,cdCronogramaSafraVencimentoSEQ
				,qtCompromissoCompraItem
				,qtAbertoCompromissoCompraItem
				,vrUnitarioMoedaCompromissoCompraItem
				,vrTotalMoedaCompromissoCompraItem
				,vrTotalMoedaAbertoCompromissoCompraItem
				,dtUltimaAlteracao
				,cdUsuarioUltimaAlteracao
				,pcDescontoPontualidade
			)
			VALUES
			(
				@cdCompromissoCompraSEQ
				,@cdProdutoSEQ
				,@cdCronogramaSafraSEQ
				,@cdCronogramaSafraVencimentoSEQ
				,@qtCompromissoCompraItem
				,@qtAbertoCompromissoCompraItem
				,@vrUnitarioMoedaCompromissoCompraItem
				,@vrTotalMoedaCompromissoCompraItem
				,@vrTotalMoedaAbertoCompromissoCompraItem
				,getdate()
				,@cdUsuarioUltimaAlteracao
				,dbo.FN_BuscaPontualidadeCompromisso(@cdCompromissoCompraSEQ, @cdCronogramaSafraVencimentoSEQ,2)			
			)
			
			IF @@ERROR <> 0  
			BEGIN
				RAISERROR ('5005 - Erro na Inclusão dos Itens do Compromisso',16,1)
				CLOSE CS_tmpCompromissoCompraItem
				DEALLOCATE CS_tmpCompromissoCompraItem
				RETURN	
			END
			
		END
		
		FETCH NEXT FROM CS_tmpCompromissoCompraItem
		INTO	 @tmpCompromissoCompraItemSEQ
				,@cdProdutoSEQ
				,@cdCronogramaSafraSEQ
				,@cdCronogramaSafraVencimentoSEQ
				,@qtCompromissoCompraItem
				,@qtAbertoCompromissoCompraItem
				,@vrUnitarioMoedaCompromissoCompraItem
				,@vrTotalMoedaCompromissoCompraItem
				,@vrTotalMoedaAbertoCompromissoCompraItem
				
		SET @Fetch_tmpCompromissoCompraItem = @@FETCH_STATUS				
		
	END		
	
	CLOSE CS_tmpCompromissoCompraItem
	DEALLOCATE CS_tmpCompromissoCompraItem

	-- Exclui as tabelas temporarias
	delete from tmpCompromissoCompra where tmpCompromissoCompraseq = @tmpCompromissoCompraSEQ
	
	delete from tmpCompromissoCompraitem where tmpCompromissoCompraseq = @tmpCompromissoCompraSEQ
	
