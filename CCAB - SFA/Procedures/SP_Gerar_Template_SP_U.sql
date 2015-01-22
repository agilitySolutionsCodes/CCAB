IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_Gerar_Template_SP_U]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_Gerar_Template_SP_U]
END
GO

CREATE PROCEDURE [dbo].[SP_Gerar_Template_SP_U]
	@NomeTabela		varchar(255)
AS

print 'set ANSI_NULLS ON'
print 'set QUOTED_IDENTIFIER ON'

print ''

print '/******************************************************************************'
print '**		File: SP_U_' + @NomeTabela + '.sql'
print '**		Name: SP_U_' + @NomeTabela
print '**		Desc: Altera um registro na tabela ' + @NomeTabela
print '**'
print '**		Auth: Convergence'
print '**		Date: ' + convert(varchar, getdate(), 103)
print '*******************************************************************************'
print '**		Change History'
print '*******************************************************************************'
print '**		Date:			Author:					Description:'
print '**'
print '*******************************************************************************/'

print ''

print 'IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N''[dbo].[SP_U_' + @NomeTabela + ']''))'
print 'BEGIN'
print '	DROP PROCEDURE [dbo].[SP_U_' + @NomeTabela + ']'
print 'END'
print 'GO'

print ''

print 'CREATE PROCEDURE [dbo].[SP_U_' + @NomeTabela + ']'

declare
	 @Nome			varchar(255)
	,@Tipo			varchar(255)
	,@Tamanho		int
	,@Escala		int
	,@PermiteNulo	int
	,@Contador		int
	,@Linha			varchar(max)
	,@LinhaMetodo	varchar(max)
	,@LinhaMetodo2	varchar(max)

	,@MetodoCabeca	varchar(max)
	,@MetodoCorpo	varchar(max)
	,@MetodoTipo	varchar(max)

	,@MetodoIf		varchar(max)

	,@MetodoIfCons	varchar(max)
	,@MetodoCons	varchar(max)

select
	 @Contador		= 0
	,@MetodoCabeca	= ''
	,@MetodoCorpo	= ''
	,@MetodoTipo	= ''
	,@LinhaMetodo2	= ''
	,@MetodoIf		= ''

	,@MetodoIfCons	= ''
	,@MetodoCons	= ''
	

--cursor dos campos
DECLARE Cursor_Campos CURSOR FOR 
	select 
		 syscolumns.name		as Nome
		,systypes.name			as Tipo
		,syscolumns.prec		as Tamanho
		,syscolumns.scale		as Escala
		,syscolumns.isnullable	as PermiteNulo

	from 
		 syscolumns
		,sysobjects
		,systypes
	where 
		upper(sysobjects.name) = upper(@NomeTabela)
	and sysobjects.id = syscolumns.id
	and (sysobjects.xtype='U' or sysobjects.xtype='S')
	and syscolumns.xtype = systypes.xtype
	order by
		syscolumns.colid

OPEN Cursor_Campos

FETCH NEXT FROM Cursor_Campos 
INTO 
	 @Nome
	,@Tipo
	,@Tamanho
	,@Escala
	,@PermiteNulo

WHILE @@FETCH_STATUS = 0
BEGIN
    
	if @Contador > 0
	begin
		select
			 @Linha			= '	,@' + @Nome
			,@LinhaMetodo	= ', ' + @Tipo + ' ' + @Nome
	end
	else
	begin
		select
			 @Linha			= '	 @' + @Nome
			,@LinhaMetodo	= @Tipo + ' ' + @Nome
	end
	

	if @Tipo = 'VARCHAR'
	begin
		select
			 @MetodoTipo = @Tipo + ', ' + convert(varchar, @Tamanho)
	
	end
	else
	begin
		select
			 @MetodoTipo = @Tipo

	end





	select
		 @LinhaMetodo2 = '			loSqlCommand.Parameters.Add(' + char(34) + '@' + @Nome + char(34) + ', SqlDbType.' + @MetodoTipo + ');'
		,@LinhaMetodo2 = @LinhaMetodo2 + char(13) + char(10)
		,@LinhaMetodo2 = @LinhaMetodo2 + '			loSqlCommand.Parameters[' + char(34) + '@' + @Nome + char(34) + '].Value = ' + @Nome + ';'



	
	select
		 @Tipo = upper(@Tipo)
		,@Linha = @Linha + '	' + upper(@Tipo)

	if @Tipo = 'VARCHAR'
	begin
		select
			@Linha = @Linha + '(' + convert(varchar, @Tamanho) + ')'
	end

	if @Tipo = 'NUMERIC'
	begin
		select
			@Linha = @Linha + '(' + convert(varchar, @Tamanho) + ',' + convert(varchar, @Escala) + ')'
	end

	if @PermiteNulo = 1
	begin
		select
			@Linha = @Linha + ' = NULL' 
	end

	if @Nome <> 'dtUltimaAlteracao'
	begin
		print @Linha
	end

	if @Nome <> 'dtUltimaAlteracao'
	begin



		if @Tipo <> 'varchar'
		begin
			if @Tipo <> 'datetime'
			begin
				select
					 @MetodoIf = @Nome +	' != 0'
					,@MetodoIfCons = @Nome +	' == 0'
			end
			else
			begin
				select
					 @MetodoIf = @Nome + ' != DateTime.MinValue'
					,@MetodoIfCons = @Nome + ' == DateTime.MinValue'
			end
		end
		else
		begin
			select
				 @MetodoIf = @Nome + '.Trim() != ' + char(34) + char(34)
				,@MetodoIfCons = @Nome + '.Trim() == ' + char(34) + char(34)
		end

		if @PermiteNulo = 1
		begin
			select
				 @MetodoCorpo = @MetodoCorpo + '		if (' + @MetodoIf + ')' + char(13) + char(10)
				,@MetodoCorpo = @MetodoCorpo + '		{' + char(13) + char(10)
		end
		else
		begin
			select
				 @MetodoCons = @MetodoCons + + '		if (' + @MetodoIfCons + ')' + char(13) + char(10)
				,@MetodoCons = @MetodoCons + '		{' + char(13) + char(10)
				,@MetodoCons = @MetodoCons + '			return ' + char(34) + ' ' +  char(34) + ' + moPadrao.MensagemObrigatorio;'
				,@MetodoCons = @MetodoCons + char(13) + char(10) + '		}' + char(13) + char(10) + char(13) + char(10)
		end


		select
			 @MetodoCabeca = @MetodoCabeca + @LinhaMetodo
			,@MetodoCorpo = @MetodoCorpo + @LinhaMetodo2 

		if @PermiteNulo = 1
		begin
			select
				 @MetodoCorpo = @MetodoCorpo + char(13) + char(10)
				,@MetodoCorpo = @MetodoCorpo + '		}' + char(13) + char(10) + char(13) + char(10)
		end
		else
		begin
			select
				 @MetodoCorpo = @MetodoCorpo + char(13) + char(10) + char(13) + char(10)
		end

	end

	select
		@Contador = @Contador + 1

    FETCH NEXT FROM Cursor_Campos 
    INTO 
		 @Nome
		,@Tipo
		,@Tamanho
		,@Escala
		,@PermiteNulo
END 
CLOSE Cursor_Campos
DEALLOCATE Cursor_Campos

print ''

print 'AS'
print ''

print '	--atualização'

print '	UPDATE ' + @NomeTabela + ' SET'

declare
	 @Campos		varchar(max)
	,@Valores		varchar(max)
	,@LinhaCampos	varchar(max)
	,@LinhaValores	varchar(max)
	,@LinhaFinal	varchar(max)


select
	 @LinhaCampos	= ''
	,@LinhaValores	= ''
	,@Contador		= 0
	,@LinhaFinal	= ''

--cursor dos campos
DECLARE Cursor_Campos CURSOR FOR 
	select 
		 syscolumns.name		as Nome
		,systypes.name			as Tipo
		,syscolumns.prec		as Tamanho
		,syscolumns.scale		as Escala
		,syscolumns.isnullable	as PermiteNulo

	from 
		 syscolumns
		,sysobjects
		,systypes
	where 
		upper(sysobjects.name) = upper(@NomeTabela)
	and sysobjects.id = syscolumns.id
	and (sysobjects.xtype='U' or sysobjects.xtype='S')
	and syscolumns.xtype = systypes.xtype
	order by
		syscolumns.colid

OPEN Cursor_Campos

FETCH NEXT FROM Cursor_Campos 
INTO 
	 @Nome
	,@Tipo
	,@Tamanho
	,@Escala
	,@PermiteNulo

WHILE @@FETCH_STATUS = 0
BEGIN
    
	if @Contador > 1
	begin
		select
			@Campos = '	,' + @Nome 
	end
	else
	begin
		select
			@Campos = '	 ' + @Nome
	end
	
	if @Nome <> 'dtUltimaAlteracao'
	begin
		select
			@Valores = '@' + @Nome
	end
	else
	begin
		select
			@Valores = 'getdate()'
	end

	if @Contador <> 0
	begin
		select
			@LinhaCampos = @LinhaCampos + '	' + @Campos + ' = ' + @Valores + char(13)
	end
	else
	begin
		select
			@LinhaFinal = '	WHERE ' + char(13) + '	' + @Campos + ' = ' + @Valores 
	end







	select
		@Contador = @Contador + 1

    FETCH NEXT FROM Cursor_Campos 
    INTO 
		 @Nome
		,@Tipo
		,@Tamanho
		,@Escala
		,@PermiteNulo
END 
CLOSE Cursor_Campos
DEALLOCATE Cursor_Campos


print @LinhaCampos 
print @LinhaFinal


print ''
print ''
print '/*'
print '-----------------------------------------------'
print 'Método C#'

print ''
print 'Parâmetros:'

select
	 @MetodoCabeca = replace(@MetodoCabeca, upper('bigint'), 'Int64')
	,@MetodoCabeca = replace(@MetodoCabeca, upper('varchar'), 'string')
	,@MetodoCabeca = replace(@MetodoCabeca, upper('numeric'), 'double')
	,@MetodoCabeca = replace(@MetodoCabeca, upper('datetime'), 'DateTime')

print @MetodoCabeca

print ''
print 'Corpo:'
	
select
	 @MetodoCorpo = replace(@MetodoCorpo, upper('.bigint'), '.BigInt')
	,@MetodoCorpo = replace(@MetodoCorpo, upper('.varchar'), '.VarChar')
	,@MetodoCorpo = replace(@MetodoCorpo, upper('.int'), '.Int')
	,@MetodoCorpo = replace(@MetodoCorpo, upper('.numeric'), '.Float')
	,@MetodoCorpo = replace(@MetodoCorpo, upper('.datetime'), '.DateTime')


print @MetodoCorpo

print ''
print 'Consistências:'

print '		//Consistências'
print @MetodoCons

print '*/'




