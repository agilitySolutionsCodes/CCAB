DECLARE @cdCronogramaSafraSEQ	BIGINT
DECLARE @dsCronogramaSafra		VARCHAR(30)
DECLARE @dsCooperativa			VARCHAR(30)
DECLARE @cdPessoaSEQ			BIGINT

DECLARE crSafra CURSOR FOR 

	SELECT 
		cdCronogramaSafraSEQ,
		dsCronogramaSafra
	FROM
		CronogramaSafra
		
OPEN crSafra

	FETCH  NEXT FROM crSafra INTO @cdCronogramaSafraSEQ, @dsCronogramaSafra
	
	WHILE @@FETCH_STATUS = 0
	
		BEGIN
			
			DECLARE crAgente CURSOR FOR 
			
				SELECT
					cdPessoaSEQ,
					nmPessoa			
				FROM
					dbo.Pessoa	PES
				WHERE
					cdIndicadorTipoPerfilPessoa	= 3
					AND cdIndicadorTipoAgenteComercialPessoa = 1
					
			OPEN crAgente
			
				FETCH NEXT FROM crAgente INTO @cdPessoaSEQ, @dsCooperativa
				
				WHILE @@FETCH_STATUS = 0
				
					BEGIN
					
						INSERT INTO CooperativaPrincipioAtivo VALUES (@cdCronogramaSafraSEQ , @cdPessoaSEQ, 4785, 1, 'Cadastrado via Script', GetDate(), 4)				
						PRINT 'Incluindo Safra: ' + @dsCronogramaSafra + ' Cooperativa: ' +  @dsCooperativa
						FETCH NEXT FROM crAgente INTO @cdPessoaSEQ, @dsCooperativa
					
					END
				
			CLOSE crAgente
			DEALLOCATE crAgente
			
		
			FETCH  NEXT FROM crSafra INTO @cdCronogramaSafraSEQ, @dsCronogramaSafra
		END
		
CLOSE crSafra
DEALLOCATE crSafra

