using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;


/// <summary>
/// Summary description for Pessoa
/// </summary>
public class Pessoa
{
    #region Variáveis Modulares

    Padrao moPadrao = new Padrao();
    string msStringConexao;

    #endregion Variáveis Modulares


    #region Propriedades

    public string Erro { get; set; }

    #endregion Propriedades


	public Pessoa()
	{
        msStringConexao = moPadrao.ObterStringConexao();
    }

    #region Métodos

    public string IncluirColaborador(int cdIndicadorTipoPerfilPessoa, string dsLoginPessoa, string nmPessoa, string nuCNPJCPFPessoa, string enEmailPrincipalPessoa, Int64 cdEmpresaColaboradorPessoa, Int64 cdUsuarioUltimaAlteracao)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {
            string MensagemDuplicidade;

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;


		    //Consistências

		    if (cdIndicadorTipoPerfilPessoa == 0)
		    {
			    return "Perfil" + moPadrao.MensagemObrigatorio;
		    }

		    if (nmPessoa.Trim() == "")
		    {
			    return "Nome" + moPadrao.MensagemObrigatorio;
		    }

		    if (cdUsuarioUltimaAlteracao == 0)
		    {
			    return "Usuário" + moPadrao.MensagemObrigatorio;
		    }

            if (dsLoginPessoa.Trim() == "")
            {
                return "Usuário" + moPadrao.MensagemObrigatorio;
            }

            if (moPadrao.VeriricarCaracterInvalido(dsLoginPessoa.Trim()) == true)
            {
                return "Login " + moPadrao.MensagemCaracterInvalido;
            }


            MensagemDuplicidade = moPadrao.VerificarDuplicidadeLogin(0, dsLoginPessoa);
            if (MensagemDuplicidade != "")
            {
                return MensagemDuplicidade;
            }


            /* -- Inibido por Solicitação da Marisa
            MensagemDuplicidade = moPadrao.VerificarDuplicidadeCpfColaborador(0, nuCNPJCPFPessoa);
            if (MensagemDuplicidade != "")
            {
                return MensagemDuplicidade;
            }
            */
            
            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoPessoa");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_I_Pessoa_Colaborador";
            loSqlCommand.CommandType = CommandType.StoredProcedure;

            
			loSqlCommand.Parameters.Add("@cdIndicadorTipoPerfilPessoa", SqlDbType.Int);
			loSqlCommand.Parameters["@cdIndicadorTipoPerfilPessoa"].Value = cdIndicadorTipoPerfilPessoa;
            
		    if (dsLoginPessoa.Trim() != "")
		    {
			    loSqlCommand.Parameters.Add("@dsLoginPessoa", SqlDbType.VarChar, 30);
			    loSqlCommand.Parameters["@dsLoginPessoa"].Value = dsLoginPessoa;
		    }
            
			loSqlCommand.Parameters.Add("@nmPessoa", SqlDbType.VarChar, 70);
			loSqlCommand.Parameters["@nmPessoa"].Value = nmPessoa;

		    if (nuCNPJCPFPessoa.Trim() != "")
		    {
			    loSqlCommand.Parameters.Add("@nuCNPJCPFPessoa", SqlDbType.VarChar, 30);
			    loSqlCommand.Parameters["@nuCNPJCPFPessoa"].Value = nuCNPJCPFPessoa;
		    }

            if (enEmailPrincipalPessoa.Trim() != "")
            {
                loSqlCommand.Parameters.Add("@enEmailPrincipalPessoa", SqlDbType.VarChar, 70);
                loSqlCommand.Parameters["@enEmailPrincipalPessoa"].Value = enEmailPrincipalPessoa;
            }



            loSqlCommand.Parameters.Add("@cdEmpresaColaboradorPessoa", SqlDbType.BigInt);
			loSqlCommand.Parameters["@cdEmpresaColaboradorPessoa"].Value = cdEmpresaColaboradorPessoa;

            loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
			loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

            loSqlCommand.Parameters.Add("@cdPessoaSEQ", SqlDbType.BigInt);
		    loSqlCommand.Parameters["@cdPessoaSEQ"].Direction = ParameterDirection.Output;



            loSqlCommand.ExecuteNonQuery();

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";
        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TransacaoPessoa");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroAlteracao;
        }
    }

    public string AlterarCliente(Int64 cdPessoaSEQ, int cdIndicadorTipoAcessoPessoa, string dsLoginPessoa, int cdIndicadorPrimeiroAcessoPessoa, int cdIndicadorSenhaBloqueadaPessoa, Int64 cdGrupoAcessoSEQ, Int64 cdUsuarioUltimaAlteracao)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {
            string MensagemDuplicidade;

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;

            //Consistências
            if (dsLoginPessoa.Trim() == "")
            {
                return "Usuário" + moPadrao.MensagemObrigatorio;
            }

            if (moPadrao.VeriricarCaracterInvalido(dsLoginPessoa.Trim()) == true)
            {
                return "Login " + moPadrao.MensagemCaracterInvalido;
            }


            MensagemDuplicidade = moPadrao.VerificarDuplicidadeLogin(cdPessoaSEQ, dsLoginPessoa);
            if (MensagemDuplicidade != "")
            {
                return MensagemDuplicidade;
            }


            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoPessoa");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_U_Pessoa_Cliente";
            loSqlCommand.CommandType = CommandType.StoredProcedure;


            loSqlCommand.Parameters.Add("@cdPessoaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdPessoaSEQ"].Value = cdPessoaSEQ;

            loSqlCommand.Parameters.Add("@cdIndicadorTipoAcessoPessoa", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdIndicadorTipoAcessoPessoa"].Value = cdIndicadorTipoAcessoPessoa;
            
            if (dsLoginPessoa.Trim() != "")
            {
                loSqlCommand.Parameters.Add("@dsLoginPessoa", SqlDbType.VarChar, 30);
                loSqlCommand.Parameters["@dsLoginPessoa"].Value = dsLoginPessoa;
            }

            loSqlCommand.Parameters.Add("@cdIndicadorPrimeiroAcessoPessoa", SqlDbType.Int);
            loSqlCommand.Parameters["@cdIndicadorPrimeiroAcessoPessoa"].Value = cdIndicadorPrimeiroAcessoPessoa;

            loSqlCommand.Parameters.Add("@cdIndicadorSenhaBloqueadaPessoa", SqlDbType.Int);
            loSqlCommand.Parameters["@cdIndicadorSenhaBloqueadaPessoa"].Value = cdIndicadorSenhaBloqueadaPessoa;

            if (cdGrupoAcessoSEQ != 0)
            {
                loSqlCommand.Parameters.Add("@cdGrupoAcessoSEQ", SqlDbType.BigInt);
                loSqlCommand.Parameters["@cdGrupoAcessoSEQ"].Value = cdGrupoAcessoSEQ;
            }

            loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;



            



            loSqlCommand.ExecuteNonQuery();

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";
        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TransacaoPessoa");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroAlteracao;
        }
    }

    public string AlterarVendedor(Int64 cdPessoaSEQ, int cdIndicadorTipoAcessoPessoa, string dsLoginPessoa, int cdIndicadorPrimeiroAcessoPessoa, int cdIndicadorSenhaBloqueadaPessoa, Int64 cdGrupoAcessoSEQ, Int64 cdUsuarioUltimaAlteracao, string enEmailPrincipalPessoa)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {
            string MensagemDuplicidade;

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;

            //Consistências
            if (dsLoginPessoa.Trim() == "")
            {
                return "Usuário" + moPadrao.MensagemObrigatorio;
            }

            if (moPadrao.VeriricarCaracterInvalido(dsLoginPessoa.Trim()) == true)
            {
                return "Login " + moPadrao.MensagemCaracterInvalido;
            }


            MensagemDuplicidade = moPadrao.VerificarDuplicidadeLogin(cdPessoaSEQ, dsLoginPessoa);
            if (MensagemDuplicidade != "")
            {
                return MensagemDuplicidade;
            }


            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoPessoa");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_U_Pessoa_Vendedor";
            loSqlCommand.CommandType = CommandType.StoredProcedure;


            loSqlCommand.Parameters.Add("@cdPessoaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdPessoaSEQ"].Value = cdPessoaSEQ;

            loSqlCommand.Parameters.Add("@cdIndicadorTipoAcessoPessoa", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdIndicadorTipoAcessoPessoa"].Value = cdIndicadorTipoAcessoPessoa;

            if (dsLoginPessoa.Trim() != "")
            {
                loSqlCommand.Parameters.Add("@dsLoginPessoa", SqlDbType.VarChar, 30);
                loSqlCommand.Parameters["@dsLoginPessoa"].Value = dsLoginPessoa;
            }

            loSqlCommand.Parameters.Add("@cdIndicadorPrimeiroAcessoPessoa", SqlDbType.Int);
            loSqlCommand.Parameters["@cdIndicadorPrimeiroAcessoPessoa"].Value = cdIndicadorPrimeiroAcessoPessoa;

            loSqlCommand.Parameters.Add("@cdIndicadorSenhaBloqueadaPessoa", SqlDbType.Int);
            loSqlCommand.Parameters["@cdIndicadorSenhaBloqueadaPessoa"].Value = cdIndicadorSenhaBloqueadaPessoa;

            if (cdGrupoAcessoSEQ != 0)
            {
                loSqlCommand.Parameters.Add("@cdGrupoAcessoSEQ", SqlDbType.BigInt);
                loSqlCommand.Parameters["@cdGrupoAcessoSEQ"].Value = cdGrupoAcessoSEQ;
            }

            loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

            loSqlCommand.Parameters.Add("@enEmailPrincipalPessoa", SqlDbType.VarChar, 70);
            loSqlCommand.Parameters["@enEmailPrincipalPessoa"].Value = enEmailPrincipalPessoa;


            loSqlCommand.ExecuteNonQuery();

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";
        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TransacaoPessoa");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroAlteracao;
        }
    }

    public string AlterarColaborador(Int64 cdPessoaSEQ, string nmPessoa, int cdIndicadorTipoPerfilPessoa, string enEmailPrincipalPessoa,  Int64 cdEmpresaColaboradorPessoa, int cdIndicadorStatusPessoa, int cdIndicadorTipoAcessoPessoa, string dsLoginPessoa, int cdIndicadorPrimeiroAcessoPessoa, int cdIndicadorSenhaBloqueadaPessoa, Int64 cdGrupoAcessoSEQ, Int64 cdUsuarioUltimaAlteracao)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {
            string MensagemDuplicidade;

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;

            //Consistências:
            if (cdIndicadorSenhaBloqueadaPessoa == 2)
            {
                if (enEmailPrincipalPessoa.Trim() == "")
                {
                    return "Para desbloquear a senha é necessário informar o e-mail.";
                }
            }

            if (cdPessoaSEQ == 0)
            {
                return "Código Pessoa" + moPadrao.MensagemObrigatorio;
            }


            if (nmPessoa.Trim() == "")
            {
                return "Nome" + moPadrao.MensagemObrigatorio;
            }


            if (cdIndicadorTipoPerfilPessoa == 0)
            {
                return "Perfil" + moPadrao.MensagemObrigatorio;
            }


            if (cdIndicadorStatusPessoa == 0)
            {
                return "Situação" + moPadrao.MensagemObrigatorio;
            }


            if (cdIndicadorTipoAcessoPessoa == 0)
            {
                return "Tipo de Acesso" + moPadrao.MensagemObrigatorio;
            }


            if (cdIndicadorPrimeiroAcessoPessoa == 0)
            {
                return "Primeiro Acesso" + moPadrao.MensagemObrigatorio;
            }


            if (cdIndicadorSenhaBloqueadaPessoa == 0)
            {
                return "Senha Bloqueada" + moPadrao.MensagemObrigatorio;
            }


            if (cdUsuarioUltimaAlteracao == 0)
            {
                return "Usuário" + moPadrao.MensagemObrigatorio;
            }

            if (dsLoginPessoa.Trim() == "")
            {
                return "Usuário" + moPadrao.MensagemObrigatorio;
            }

            if (moPadrao.VeriricarCaracterInvalido(dsLoginPessoa.Trim()) == true)
            {
                return "Login " + moPadrao.MensagemCaracterInvalido;
            }


            MensagemDuplicidade = moPadrao.VerificarDuplicidadeLogin(cdPessoaSEQ, dsLoginPessoa);
            if (MensagemDuplicidade != "")
            {
                return MensagemDuplicidade;
            }

            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoPessoa");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_U_Pessoa_Colaborador";
            loSqlCommand.CommandType = CommandType.StoredProcedure;


            loSqlCommand.Parameters.Add("@cdPessoaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdPessoaSEQ"].Value = cdPessoaSEQ;


            loSqlCommand.Parameters.Add("@nmPessoa", SqlDbType.VarChar, 70);
            loSqlCommand.Parameters["@nmPessoa"].Value = nmPessoa;

            loSqlCommand.Parameters.Add("@cdIndicadorTipoPerfilPessoa", SqlDbType.Int);
            loSqlCommand.Parameters["@cdIndicadorTipoPerfilPessoa"].Value = cdIndicadorTipoPerfilPessoa;

            if (enEmailPrincipalPessoa.Trim() != "")
            {
                loSqlCommand.Parameters.Add("@enEmailPrincipalPessoa", SqlDbType.VarChar, 70);
                loSqlCommand.Parameters["@enEmailPrincipalPessoa"].Value = enEmailPrincipalPessoa;
            }


            loSqlCommand.Parameters.Add("@cdEmpresaColaboradorPessoa", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdEmpresaColaboradorPessoa"].Value = cdEmpresaColaboradorPessoa;

            loSqlCommand.Parameters.Add("@cdIndicadorStatusPessoa", SqlDbType.Int);
            loSqlCommand.Parameters["@cdIndicadorStatusPessoa"].Value = cdIndicadorStatusPessoa;


            loSqlCommand.Parameters.Add("@cdIndicadorTipoAcessoPessoa", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdIndicadorTipoAcessoPessoa"].Value = cdIndicadorTipoAcessoPessoa;

            if (dsLoginPessoa.Trim() != "")
            {
                loSqlCommand.Parameters.Add("@dsLoginPessoa", SqlDbType.VarChar, 30);
                loSqlCommand.Parameters["@dsLoginPessoa"].Value = dsLoginPessoa;
            }

            loSqlCommand.Parameters.Add("@cdIndicadorPrimeiroAcessoPessoa", SqlDbType.Int);
            loSqlCommand.Parameters["@cdIndicadorPrimeiroAcessoPessoa"].Value = cdIndicadorPrimeiroAcessoPessoa;

            loSqlCommand.Parameters.Add("@cdIndicadorSenhaBloqueadaPessoa", SqlDbType.Int);
            loSqlCommand.Parameters["@cdIndicadorSenhaBloqueadaPessoa"].Value = cdIndicadorSenhaBloqueadaPessoa;

            if (cdGrupoAcessoSEQ != 0)
            {
                loSqlCommand.Parameters.Add("@cdGrupoAcessoSEQ", SqlDbType.BigInt);
                loSqlCommand.Parameters["@cdGrupoAcessoSEQ"].Value = cdGrupoAcessoSEQ;
            }

            loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;




            loSqlCommand.ExecuteNonQuery();

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";
        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TransacaoPessoa");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroAlteracao;
        }
    }

    public DataTable ObterHistoricoCliente(Int64 cdPessoaHistoricoSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_PessoaHistorico_Cliente", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;



            if (cdPessoaHistoricoSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPessoaHistoricoSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdPessoaHistoricoSEQ"].Value = cdPessoaHistoricoSEQ;
            }


            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;

        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }
    }

    public DataTable ObterHistoricoVendedor(Int64 cdPessoaHistoricoSEQ)
    {
        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_PessoaHistorico_Vendedor", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;



            if (cdPessoaHistoricoSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPessoaHistoricoSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdPessoaHistoricoSEQ"].Value = cdPessoaHistoricoSEQ;
            }


            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;

        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }
    }

    public DataTable ObterHistoricoColaborador(Int64 cdPessoaHistoricoSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_PessoaHistorico_Colaborador", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;



            if (cdPessoaHistoricoSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPessoaHistoricoSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdPessoaHistoricoSEQ"].Value = cdPessoaHistoricoSEQ;
            }


            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;

        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }
    }

    public DataTable ObterListaHistoricoCliente(Int64 cdPessoaSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_PessoaHistorico_Cliente", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;



            if (cdPessoaSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPessoaSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdPessoaSEQ"].Value = cdPessoaSEQ;
            }


            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;

        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }
    }

    public DataTable ObterListaHistoricoVendedor(Int64 cdPessoaSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_PessoaHistorico_Vendedor", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;



            if (cdPessoaSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPessoaSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdPessoaSEQ"].Value = cdPessoaSEQ;
            }


            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;

        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }
    }

    public DataTable ObterListaHistoricoColaborador(Int64 cdPessoaSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_PessoaHistorico_Colaborador", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;



            if (cdPessoaSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPessoaSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdPessoaSEQ"].Value = cdPessoaSEQ;
            }


            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;

        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }
    }

    public DataTable ObterCliente(Int64 cdPessoaSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_Pessoa_Cliente", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPessoaSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdPessoaSEQ"].Value = cdPessoaSEQ;

            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;


        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }
    }

    public DataTable ObterVendedor(Int64 cdPessoaSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_Pessoa_Vendedor", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPessoaSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdPessoaSEQ"].Value = cdPessoaSEQ;

            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;


        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }
    }

    public DataTable ObterColaborador(Int64 cdPessoaSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_Pessoa_Colaborador", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPessoaSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdPessoaSEQ"].Value = cdPessoaSEQ;

            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;


        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }
    }

    public DataTable ObterListaPedidoAgente(Int64 cdUsuario, Int64 cdIndicadorStatusPessoa)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_Pessoa_Pedido_Agente", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdUsuario", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdUsuario"].Value = cdUsuario;

            if (cdIndicadorStatusPessoa != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorStatusPessoa", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorStatusPessoa"].Value = cdIndicadorStatusPessoa;
            }

            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;


        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }
    }

    public DataTable ObterListaAgente(int AgenteID)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_Pessoa_Agente", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@CDPESSOASEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@CDPESSOASEQ"].Value = AgenteID.Equals(0) ? (object)DBNull.Value : AgenteID;
                       
            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;


        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }
    }


    

    public DataTable ObterListaOrigemFaturamento(Int64 cdIndicadorStatusPessoa)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_Pessoa_OrigemFaturamento", loSqlConnection);

            if (cdIndicadorStatusPessoa != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorStatusPessoa", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorStatusPessoa"].Value = cdIndicadorStatusPessoa;
            }

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;


        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }
    }

    public DataTable ObterListaPedidoClienteFaturamento(Int64 cdAgente)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_Pessoa_Pedido_ClienteFaturamento", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdAgente", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdAgente"].Value = cdAgente;




            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;


        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }
    }
    
    public DataTable ObterListaPedidoClienteFaturamentoAlteracao(Int64 cdPedidoVendaSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_Pessoa_Pedido_ClienteFaturamentoAlteracao", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPedidoVendaSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdPedidoVendaSEQ"].Value = cdPedidoVendaSEQ;

            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;


        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }
    }

    public DataTable ObterListaPedidoClienteEntrega(Int64 cdCliente)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_Pessoa_Pedido_ClienteEntrega", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCliente", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdCliente"].Value = cdCliente;

            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;


        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }
    }

    public DataTable ObterListaPedidoClienteEntregaAlteracao(Int64 cdCliente)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_Pessoa_Pedido_ClienteEntregaAlteracao", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCliente", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdCliente"].Value = cdCliente;

            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;


        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }
    }

    public DataTable ObterListaCliente(string cdPessoaERP, string dsLoginPessoa, string nuCNPJCPFPessoa, string nmFoneticoPessoa, int cdIndicadorStatusPessoa, int cdIndicadorSenhaBloqueadaPessoa, Int64 cdAgenteComercialCooperativaPessoa, Int64 cdAgenteComercialRCPessoa, int cdIndicadorPessoa)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_Pessoa_Cliente", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            string nmFoneticoPessoaConvertido;
            

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;


            if (cdPessoaERP.Trim() != "")
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPessoaERP", SqlDbType.VarChar, 30);
                loSqlDataAdapter.SelectCommand.Parameters["@cdPessoaERP"].Value = cdPessoaERP;
            }

            if (dsLoginPessoa.Trim() != "")
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@dsLoginPessoa", SqlDbType.VarChar, 30);
                loSqlDataAdapter.SelectCommand.Parameters["@dsLoginPessoa"].Value = dsLoginPessoa;
            }

            if (nuCNPJCPFPessoa.Trim() != "")
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@nuCNPJCPFPessoa", SqlDbType.VarChar, 30);
                loSqlDataAdapter.SelectCommand.Parameters["@nuCNPJCPFPessoa"].Value = nuCNPJCPFPessoa;
            }

            if (nmFoneticoPessoa.Trim() != "")
            {

                nmFoneticoPessoaConvertido = moPadrao.ObterFonetico(nmFoneticoPessoa);

                loSqlDataAdapter.SelectCommand.Parameters.Add("@nmFoneticoPessoa", SqlDbType.VarChar, 8000);
                loSqlDataAdapter.SelectCommand.Parameters["@nmFoneticoPessoa"].Value = nmFoneticoPessoaConvertido;
            }

            if (cdIndicadorStatusPessoa != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorStatusPessoa", SqlDbType.Int);
                loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorStatusPessoa"].Value = cdIndicadorStatusPessoa;
            }

            if (cdIndicadorSenhaBloqueadaPessoa != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorSenhaBloqueadaPessoa", SqlDbType.Int);
                loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorSenhaBloqueadaPessoa"].Value = cdIndicadorSenhaBloqueadaPessoa;
            }

            

            if (cdAgenteComercialCooperativaPessoa != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdAgenteComercialCooperativaPessoa", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdAgenteComercialCooperativaPessoa"].Value = cdAgenteComercialCooperativaPessoa;
            }

            if (cdAgenteComercialRCPessoa != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdAgenteComercialRCPessoa", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdAgenteComercialRCPessoa"].Value = cdAgenteComercialRCPessoa;
            }

            if (cdIndicadorPessoa != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorPessoa", SqlDbType.Int);
                loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorPessoa"].Value = cdIndicadorPessoa;
            }

            



            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;


        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }
    }

    public DataTable ObterListaVendedor(string cdPessoaERP, string dsLoginPessoa, string nuCNPJCPFPessoa, string nmFoneticoPessoa, int cdIndicadorStatusPessoa, int cdIndicadorSenhaBloqueadaPessoa, int cdIndicadorTipoAgenteComercialPessoa, int cdIndicadorPessoa)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_Pessoa_Vendedor", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            string nmFoneticoPessoaConvertido;


            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;


            if (cdPessoaERP.Trim() != "")
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPessoaERP", SqlDbType.VarChar, 30);
                loSqlDataAdapter.SelectCommand.Parameters["@cdPessoaERP"].Value = cdPessoaERP;
            }

            if (dsLoginPessoa.Trim() != "")
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@dsLoginPessoa", SqlDbType.VarChar, 30);
                loSqlDataAdapter.SelectCommand.Parameters["@dsLoginPessoa"].Value = dsLoginPessoa;
            }

            if (nuCNPJCPFPessoa.Trim() != "")
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@nuCNPJCPFPessoa", SqlDbType.VarChar, 30);
                loSqlDataAdapter.SelectCommand.Parameters["@nuCNPJCPFPessoa"].Value = nuCNPJCPFPessoa;
            }

            if (nmFoneticoPessoa.Trim() != "")
            {

                nmFoneticoPessoaConvertido = moPadrao.ObterFonetico(nmFoneticoPessoa);

                loSqlDataAdapter.SelectCommand.Parameters.Add("@nmFoneticoPessoa", SqlDbType.VarChar, 8000);
                loSqlDataAdapter.SelectCommand.Parameters["@nmFoneticoPessoa"].Value = nmFoneticoPessoaConvertido;
            }

            if (cdIndicadorStatusPessoa != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorStatusPessoa", SqlDbType.Int);
                loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorStatusPessoa"].Value = cdIndicadorStatusPessoa;
            }

            if (cdIndicadorSenhaBloqueadaPessoa != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorSenhaBloqueadaPessoa", SqlDbType.Int);
                loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorSenhaBloqueadaPessoa"].Value = cdIndicadorSenhaBloqueadaPessoa;
            }

            if (cdIndicadorTipoAgenteComercialPessoa != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorTipoAgenteComercialPessoa", SqlDbType.Int);
                loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorTipoAgenteComercialPessoa"].Value = cdIndicadorTipoAgenteComercialPessoa;
            }

            if (cdIndicadorPessoa != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorPessoa", SqlDbType.Int);
                loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorPessoa"].Value = cdIndicadorPessoa;
            }





            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;


        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }
    }

    public DataTable ObterListaColaborador(Int64 cdPessoaSEQ, string dsLoginPessoa, string nuCNPJCPFPessoa, string nmFoneticoPessoa, int cdIndicadorStatusPessoa, int cdIndicadorSenhaBloqueadaPessoa, int cdIndicadorTipoPerfilPessoa, Int64 cdEmpresaColaboradorPessoa)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_Pessoa_Colaborador", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            string nmFoneticoPessoaConvertido;


            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;


            if (cdPessoaSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPessoaSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdPessoaSEQ"].Value = cdPessoaSEQ;
            }

            if (dsLoginPessoa.Trim() != "")
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@dsLoginPessoa", SqlDbType.VarChar, 30);
                loSqlDataAdapter.SelectCommand.Parameters["@dsLoginPessoa"].Value = dsLoginPessoa;
            }

            if (nuCNPJCPFPessoa.Trim() != "")
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@nuCNPJCPFPessoa", SqlDbType.VarChar, 30);
                loSqlDataAdapter.SelectCommand.Parameters["@nuCNPJCPFPessoa"].Value = nuCNPJCPFPessoa;
            }

            if (nmFoneticoPessoa.Trim() != "")
            {

                nmFoneticoPessoaConvertido = moPadrao.ObterFonetico(nmFoneticoPessoa);

                loSqlDataAdapter.SelectCommand.Parameters.Add("@nmFoneticoPessoa", SqlDbType.VarChar, 8000);
                loSqlDataAdapter.SelectCommand.Parameters["@nmFoneticoPessoa"].Value = nmFoneticoPessoaConvertido;
            }

            if (cdIndicadorStatusPessoa != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorStatusPessoa", SqlDbType.Int);
                loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorStatusPessoa"].Value = cdIndicadorStatusPessoa;
            }

            if (cdIndicadorSenhaBloqueadaPessoa != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorSenhaBloqueadaPessoa", SqlDbType.Int);
                loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorSenhaBloqueadaPessoa"].Value = cdIndicadorSenhaBloqueadaPessoa;
            }

            if (cdIndicadorTipoPerfilPessoa != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorTipoPerfilPessoa", SqlDbType.Int);
                loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorTipoPerfilPessoa"].Value = cdIndicadorTipoPerfilPessoa;
            }

            if (cdEmpresaColaboradorPessoa != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdEmpresaColaboradorPessoa", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdEmpresaColaboradorPessoa"].Value = cdEmpresaColaboradorPessoa;
            }





            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;


        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }
    }

    public DataTable ObterListaOnDemandERP(int cdIndicadorTipoPerfilPessoa, Int64 cdUsuarioUltimaAlteracao, int cdIndicadorTipoAgenteComercialPessoa)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_Pessoa_OnDemand_ERP", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            //loSqlDataAdapter.SelectCommand.Parameters.Add("@dsFiltro", SqlDbType.VarChar, 70);
            //loSqlDataAdapter.SelectCommand.Parameters["@dsFiltro"].Value = dsFiltro;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorTipoPerfilPessoa", SqlDbType.Int);
            loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorTipoPerfilPessoa"].Value = cdIndicadorTipoPerfilPessoa;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorTipoAgenteComercialPessoa", SqlDbType.Int);
            loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorTipoAgenteComercialPessoa"].Value = cdIndicadorTipoAgenteComercialPessoa;


            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;


        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }
    }
    
    public DataTable ObterDadosLogin(string dsLoginPessoa, string dsSenhaLoginPessoa)
    {

        try
        {
            Erro = "";
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_Pessoa_DadosLogin", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;


            if (dsLoginPessoa.Trim() != "")
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@dsLoginPessoa", SqlDbType.VarChar, 30);
                loSqlDataAdapter.SelectCommand.Parameters["@dsLoginPessoa"].Value = dsLoginPessoa;
            }


            if (dsSenhaLoginPessoa.Trim() != "")
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@dsSenhaLoginPessoa", SqlDbType.VarChar, 255);
                loSqlDataAdapter.SelectCommand.Parameters["@dsSenhaLoginPessoa"].Value = dsSenhaLoginPessoa;
            }



            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;
             

        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            Erro = moPadrao.MensagemErroObtencao;
            return null;
        }
    }

    public DataTable ObterDadosLogin(string dsLoginPessoa)
    {

        try
        {
            Erro = "";

            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_Pessoa_DadosLogin", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            if (dsLoginPessoa.Trim() != "")
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@dsLoginPessoa", SqlDbType.VarChar, 30);
                loSqlDataAdapter.SelectCommand.Parameters["@dsLoginPessoa"].Value = dsLoginPessoa;
            }

            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;


        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            Erro = moPadrao.MensagemErroObtencao;
            return null;
        }
    }

    public DataTable ObterDadosPerfil(Int64 cdPessoaSEQ)
    {

        try
        {
            Erro = "";

            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_Pessoa_DadosPerfil", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;


            if (cdPessoaSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPessoaSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdPessoaSEQ"].Value = cdPessoaSEQ;
            }


            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;


        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            Erro = moPadrao.MensagemErroObtencao;
            return null;
        }
    }

    public string AlterarColaborador(
                                        long cdPessoaSEQ,
                                        int cdIndicadorPessoa,
                                        string cdPessoaERP,
                                        string nmPessoa,
                                        string nmReduzidoPessoa,
                                        string enEmailPrincipalPessoa,
                                        string dsLoginPessoa,
                                        string nuInscricaoEstadualPessoa,
                                        string nuInscricaoMunicipalPessoa,
                                        string nuInscricaoRuralPessoa,
                                        int cdNacionalidadePessoa,
                                        string nuRGCedulaEstrangeiroPessoa,
                                        DateTime dtNascimentoPessoa,
                                        int cdIndicadorSexoPessoa,
                                        int cdIndicadorEstadoCivilPessoa,
                                        string nmContatoPrincipalPessoa,
                                        string nmContatoCobrancaPessoa,
                                        int cdIndicadorStatusPessoa,
                                        int cdPaisEnderecoPrincipalPessoa,
                                        string enLogradouroEnderecoPrincipalPessoa,
                                        string enBairroEnderecoPrincipalPessoa,
                                        string enMunicipioEnderecoPrincipalPessoa,
                                        string cdSiglaEstadoEnderecoPrincipalPessoa,
                                        string nuCepEnderecoPrincipalPessoa,
                                        string enReferenciaEnderecoPrincipalPessoa,
                                        string nuCaixaPostalEnderecoPrincipalPessoa,
                                        int cdPaisEnderecoCobrancaPessoa,
                                        string enLogradouroEnderecoCobrancaPessoa,
                                        string enBairroEnderecoCobrancaPessoa,
                                        string enMunicipioEnderecoCobrancaPessoa,
                                        string cdSiglaEstadoEnderecoCobrancaPessoa,
                                        string nuCepEnderecoCobrancaPessoa,
                                        string enReferenciaEnderecoCobrancaPessoa,
                                        string nuCaixaPostalEnderecoCobrancaPessoa,
                                        string cdPaisEnderecoEntregaPessoa,
                                        string enLogradouroEnderecoEntregaPessoa,
                                        string enBairroEnderecoEntregaPessoa,
                                        string enMunicipioEnderecoEntregaPessoa,
                                        string cdSiglaEstadoEnderecoEntregaPessoa,
                                        string nuCepEnderecoEntregaPessoa,
                                        string enReferenciaEnderecoEntregaPessoa,
                                        string nuCaixaPostalEnderecoEntregaPessoa,
                                        int cdPaisTelefonePrincipalPessoa,
                                        string nuDDDTelefonePrincipalPessoa,
                                        string nuTelefonePrincipalPessoa,
                                        int cdPaisTelefoneFAXPessoa,
                                        string nuDDDTelefoneFAXPessoa,
                                        string nuTelefoneFAXPessoa,
                                        int cdPaisTelefoneCelularPessoa,
                                        string nuDDDTelefoneCelularPessoa,
                                        string nuTelefoneCelularPessoa)
    {

        try
        {
            string MensagemDuplicidade;

            Erro = "";

            if (dsLoginPessoa.Trim() == "")
            {
                return "Usuário" + moPadrao.MensagemObrigatorio;
            }

            if (moPadrao.VeriricarCaracterInvalido(dsLoginPessoa.Trim()) == true)
            {
                return "Login " + moPadrao.MensagemCaracterInvalido;
            }


            MensagemDuplicidade = moPadrao.VerificarDuplicidadeLogin(cdPessoaSEQ, dsLoginPessoa);
            if (MensagemDuplicidade != "")
            {
                return MensagemDuplicidade;
            }


            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlCommand loSqlCommand;

            loSqlConnection.Open();

            loSqlCommand = new SqlCommand("sp_u_Pessoa_Colaborador_Atualizacao_Cadastral", loSqlConnection);
            loSqlCommand.CommandType = CommandType.StoredProcedure;

            loSqlCommand.Parameters.Add("@cdPessoaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdPessoaSEQ"].Value = ValorToDbNull(cdPessoaSEQ);

            loSqlCommand.Parameters.Add("@cdIndicadorPessoa", SqlDbType.Int);
            loSqlCommand.Parameters["@cdIndicadorPessoa"].Value = ValorToDbNull(cdIndicadorPessoa);

            loSqlCommand.Parameters.Add("@cdPessoaERP", SqlDbType.VarChar, 30);
            loSqlCommand.Parameters["@cdPessoaERP"].Value = ValorToDbNull(cdPessoaERP);

            loSqlCommand.Parameters.Add("@nmPessoa", SqlDbType.VarChar, 70);
            loSqlCommand.Parameters["@nmPessoa"].Value = ValorToDbNull(nmPessoa);

            loSqlCommand.Parameters.Add("@nmReduzidoPessoa", SqlDbType.VarChar, 30);
            loSqlCommand.Parameters["@nmReduzidoPessoa"].Value = ValorToDbNull(nmReduzidoPessoa);

            loSqlCommand.Parameters.Add("@enEmailPrincipalPessoa", SqlDbType.VarChar, 70);
            loSqlCommand.Parameters["@enEmailPrincipalPessoa"].Value = ValorToDbNull(enEmailPrincipalPessoa);

            loSqlCommand.Parameters.Add("@dsLoginPessoa", SqlDbType.VarChar, 30);
            loSqlCommand.Parameters["@dsLoginPessoa"].Value = ValorToDbNull(dsLoginPessoa);

            loSqlCommand.Parameters.Add("@nuInscricaoEstadualPessoa", SqlDbType.VarChar, 30);
            loSqlCommand.Parameters["@nuInscricaoEstadualPessoa"].Value = ValorToDbNull(nuInscricaoEstadualPessoa);

            loSqlCommand.Parameters.Add("@nuInscricaoMunicipalPessoa", SqlDbType.VarChar, 30);
            loSqlCommand.Parameters["@nuInscricaoMunicipalPessoa"].Value = ValorToDbNull(nuInscricaoMunicipalPessoa);

            loSqlCommand.Parameters.Add("@nuInscricaoRuralPessoa", SqlDbType.VarChar, 30);
            loSqlCommand.Parameters["@nuInscricaoRuralPessoa"].Value = ValorToDbNull(nuInscricaoRuralPessoa);

            loSqlCommand.Parameters.Add("@cdNacionalidadePessoa", SqlDbType.Int);
            loSqlCommand.Parameters["@cdNacionalidadePessoa"].Value = ValorToDbNull(cdNacionalidadePessoa);

            loSqlCommand.Parameters.Add("@nuRGCedulaEstrangeiroPessoa", SqlDbType.VarChar, 30);
            loSqlCommand.Parameters["@nuRGCedulaEstrangeiroPessoa"].Value = ValorToDbNull(nuRGCedulaEstrangeiroPessoa);

            loSqlCommand.Parameters.Add("@dtNascimentoPessoa", SqlDbType.DateTime);
            loSqlCommand.Parameters["@dtNascimentoPessoa"].Value = ValorToDbNull(dtNascimentoPessoa);

            loSqlCommand.Parameters.Add("@cdIndicadorSexoPessoa", SqlDbType.Int);
            loSqlCommand.Parameters["@cdIndicadorSexoPessoa"].Value = ValorToDbNull(cdIndicadorSexoPessoa);

            loSqlCommand.Parameters.Add("@cdIndicadorEstadoCivilPessoa", SqlDbType.Int);
            loSqlCommand.Parameters["@cdIndicadorEstadoCivilPessoa"].Value = ValorToDbNull(cdIndicadorEstadoCivilPessoa);

            loSqlCommand.Parameters.Add("@nmContatoPrincipalPessoa", SqlDbType.VarChar, 30);
            loSqlCommand.Parameters["@nmContatoPrincipalPessoa"].Value = ValorToDbNull(nmContatoPrincipalPessoa);

            loSqlCommand.Parameters.Add("@nmContatoCobrancaPessoa", SqlDbType.VarChar, 30);
            loSqlCommand.Parameters["@nmContatoCobrancaPessoa"].Value = ValorToDbNull(nmContatoCobrancaPessoa);

            loSqlCommand.Parameters.Add("@cdIndicadorStatusPessoa", SqlDbType.Int);
            loSqlCommand.Parameters["@cdIndicadorStatusPessoa"].Value = ValorToDbNull(cdIndicadorStatusPessoa);

            loSqlCommand.Parameters.Add("@cdPaisEnderecoPrincipalPessoa", SqlDbType.Int);
            loSqlCommand.Parameters["@cdPaisEnderecoPrincipalPessoa"].Value = ValorToDbNull(cdPaisEnderecoPrincipalPessoa);

            loSqlCommand.Parameters.Add("@enLogradouroEnderecoPrincipalPessoa", SqlDbType.VarChar, 100);
            loSqlCommand.Parameters["@enLogradouroEnderecoPrincipalPessoa"].Value = ValorToDbNull(enLogradouroEnderecoPrincipalPessoa);

            loSqlCommand.Parameters.Add("@enBairroEnderecoPrincipalPessoa", SqlDbType.VarChar, 70);
            loSqlCommand.Parameters["@enBairroEnderecoPrincipalPessoa"].Value = ValorToDbNull(enBairroEnderecoPrincipalPessoa);

            loSqlCommand.Parameters.Add("@enMunicipioEnderecoPrincipalPessoa", SqlDbType.VarChar, 70);
            loSqlCommand.Parameters["@enMunicipioEnderecoPrincipalPessoa"].Value = ValorToDbNull(enMunicipioEnderecoPrincipalPessoa);

            loSqlCommand.Parameters.Add("@cdSiglaEstadoEnderecoPrincipalPessoa", SqlDbType.VarChar, 5);
            loSqlCommand.Parameters["@cdSiglaEstadoEnderecoPrincipalPessoa"].Value = ValorToDbNull(cdSiglaEstadoEnderecoPrincipalPessoa);

            loSqlCommand.Parameters.Add("@nuCepEnderecoPrincipalPessoa", SqlDbType.VarChar, 8);
            loSqlCommand.Parameters["@nuCepEnderecoPrincipalPessoa"].Value = ValorToDbNull(nuCepEnderecoPrincipalPessoa);

            loSqlCommand.Parameters.Add("@enReferenciaEnderecoPrincipalPessoa", SqlDbType.VarChar, 30);
            loSqlCommand.Parameters["@enReferenciaEnderecoPrincipalPessoa"].Value = ValorToDbNull(enReferenciaEnderecoPrincipalPessoa);

            loSqlCommand.Parameters.Add("@nuCaixaPostalEnderecoPrincipalPessoa", SqlDbType.VarChar, 30);
            loSqlCommand.Parameters["@nuCaixaPostalEnderecoPrincipalPessoa"].Value = ValorToDbNull(nuCaixaPostalEnderecoPrincipalPessoa);

            loSqlCommand.Parameters.Add("@cdPaisEnderecoCobrancaPessoa", SqlDbType.Int);
            loSqlCommand.Parameters["@cdPaisEnderecoCobrancaPessoa"].Value = ValorToDbNull(cdPaisEnderecoCobrancaPessoa);

            loSqlCommand.Parameters.Add("@enLogradouroEnderecoCobrancaPessoa", SqlDbType.VarChar, 100);
            loSqlCommand.Parameters["@enLogradouroEnderecoCobrancaPessoa"].Value = ValorToDbNull(enLogradouroEnderecoCobrancaPessoa);

            loSqlCommand.Parameters.Add("@enBairroEnderecoCobrancaPessoa", SqlDbType.VarChar, 70);
            loSqlCommand.Parameters["@enBairroEnderecoCobrancaPessoa"].Value = ValorToDbNull(enBairroEnderecoCobrancaPessoa);

            loSqlCommand.Parameters.Add("@enMunicipioEnderecoCobrancaPessoa", SqlDbType.VarChar, 70);
            loSqlCommand.Parameters["@enMunicipioEnderecoCobrancaPessoa"].Value = ValorToDbNull(enMunicipioEnderecoCobrancaPessoa);

            loSqlCommand.Parameters.Add("@cdSiglaEstadoEnderecoCobrancaPessoa", SqlDbType.VarChar, 5);
            loSqlCommand.Parameters["@cdSiglaEstadoEnderecoCobrancaPessoa"].Value = ValorToDbNull(cdSiglaEstadoEnderecoCobrancaPessoa);

            loSqlCommand.Parameters.Add("@nuCepEnderecoCobrancaPessoa", SqlDbType.VarChar, 8);
            loSqlCommand.Parameters["@nuCepEnderecoCobrancaPessoa"].Value = ValorToDbNull(nuCepEnderecoCobrancaPessoa);

            loSqlCommand.Parameters.Add("@enReferenciaEnderecoCobrancaPessoa", SqlDbType.VarChar, 30);
            loSqlCommand.Parameters["@enReferenciaEnderecoCobrancaPessoa"].Value = ValorToDbNull(enReferenciaEnderecoCobrancaPessoa);

            loSqlCommand.Parameters.Add("@nuCaixaPostalEnderecoCobrancaPessoa", SqlDbType.VarChar, 30);
            loSqlCommand.Parameters["@nuCaixaPostalEnderecoCobrancaPessoa"].Value = ValorToDbNull(nuCaixaPostalEnderecoCobrancaPessoa);

            loSqlCommand.Parameters.Add("@cdPaisEnderecoEntregaPessoa", SqlDbType.Int);
            loSqlCommand.Parameters["@cdPaisEnderecoEntregaPessoa"].Value = ValorToDbNull(cdPaisEnderecoEntregaPessoa);

            loSqlCommand.Parameters.Add("@enLogradouroEnderecoEntregaPessoa", SqlDbType.VarChar, 100);
            loSqlCommand.Parameters["@enLogradouroEnderecoEntregaPessoa"].Value = ValorToDbNull(enLogradouroEnderecoEntregaPessoa);

            loSqlCommand.Parameters.Add("@enBairroEnderecoEntregaPessoa", SqlDbType.VarChar, 70);
            loSqlCommand.Parameters["@enBairroEnderecoEntregaPessoa"].Value = ValorToDbNull(enBairroEnderecoEntregaPessoa);

            loSqlCommand.Parameters.Add("@enMunicipioEnderecoEntregaPessoa", SqlDbType.VarChar, 70);
            loSqlCommand.Parameters["@enMunicipioEnderecoEntregaPessoa"].Value = ValorToDbNull(enMunicipioEnderecoEntregaPessoa);

            loSqlCommand.Parameters.Add("@cdSiglaEstadoEnderecoEntregaPessoa", SqlDbType.VarChar, 5);
            loSqlCommand.Parameters["@cdSiglaEstadoEnderecoEntregaPessoa"].Value = ValorToDbNull(cdSiglaEstadoEnderecoEntregaPessoa);

            loSqlCommand.Parameters.Add("@nuCepEnderecoEntregaPessoa", SqlDbType.VarChar, 8);
            loSqlCommand.Parameters["@nuCepEnderecoEntregaPessoa"].Value = ValorToDbNull(nuCepEnderecoEntregaPessoa);

            loSqlCommand.Parameters.Add("@enReferenciaEnderecoEntregaPessoa", SqlDbType.VarChar, 30);
            loSqlCommand.Parameters["@enReferenciaEnderecoEntregaPessoa"].Value = ValorToDbNull(enReferenciaEnderecoEntregaPessoa);

            loSqlCommand.Parameters.Add("@nuCaixaPostalEnderecoEntregaPessoa", SqlDbType.VarChar, 30);
            loSqlCommand.Parameters["@nuCaixaPostalEnderecoEntregaPessoa"].Value = ValorToDbNull(nuCaixaPostalEnderecoEntregaPessoa);

            loSqlCommand.Parameters.Add("@cdPaisTelefonePrincipalPessoa", SqlDbType.Int);
            loSqlCommand.Parameters["@cdPaisTelefonePrincipalPessoa"].Value = ValorToDbNull(cdPaisTelefonePrincipalPessoa);

            loSqlCommand.Parameters.Add("@nuDDDTelefonePrincipalPessoa", SqlDbType.VarChar, 5);
            loSqlCommand.Parameters["@nuDDDTelefonePrincipalPessoa"].Value = ValorToDbNull(nuDDDTelefonePrincipalPessoa);

            loSqlCommand.Parameters.Add("@nuTelefonePrincipalPessoa", SqlDbType.VarChar, 30);
            loSqlCommand.Parameters["@nuTelefonePrincipalPessoa"].Value = ValorToDbNull(nuTelefonePrincipalPessoa);

            loSqlCommand.Parameters.Add("@cdPaisTelefoneFAXPessoa", SqlDbType.Int);
            loSqlCommand.Parameters["@cdPaisTelefoneFAXPessoa"].Value = ValorToDbNull(cdPaisTelefoneFAXPessoa);

            loSqlCommand.Parameters.Add("@nuDDDTelefoneFAXPessoa", SqlDbType.VarChar, 5);
            loSqlCommand.Parameters["@nuDDDTelefoneFAXPessoa"].Value = ValorToDbNull(nuDDDTelefoneFAXPessoa);

            loSqlCommand.Parameters.Add("@nuTelefoneFAXPessoa", SqlDbType.VarChar, 30);
            loSqlCommand.Parameters["@nuTelefoneFAXPessoa"].Value = ValorToDbNull(nuTelefoneFAXPessoa);

            loSqlCommand.Parameters.Add("@cdPaisTelefoneCelularPessoa", SqlDbType.Int);
            loSqlCommand.Parameters["@cdPaisTelefoneCelularPessoa"].Value = ValorToDbNull(cdPaisTelefoneCelularPessoa);

            loSqlCommand.Parameters.Add("@nuDDDTelefoneCelularPessoa", SqlDbType.VarChar, 5);
            loSqlCommand.Parameters["@nuDDDTelefoneCelularPessoa"].Value = ValorToDbNull(nuDDDTelefoneCelularPessoa);

            loSqlCommand.Parameters.Add("@nuTelefoneCelularPessoa", SqlDbType.VarChar, 30);
            loSqlCommand.Parameters["@nuTelefoneCelularPessoa"].Value = ValorToDbNull(nuTelefoneCelularPessoa);

            loSqlCommand.ExecuteNonQuery();

            loSqlConnection.Close();
            loSqlConnection = null;

            return string.Empty;

        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            Erro = moPadrao.MensagemErroObtencao;
            return Erro;
        }
    }


    public bool VerificarLoginBloqueado(Int64 cdPessoaSEQ)
    {
        try
        {
            Erro = "";
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_Pessoa_Login", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;


            if (cdPessoaSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPessoaSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdPessoaSEQ"].Value = cdPessoaSEQ;
            }

            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            if (loDataTable.Rows.Count > 0)
            {
                if (Convert.ToInt16(loDataTable.Rows[0]["cdIndicadorSenhaBloqueadaPessoa"]) == 1)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            else
            {
                return true;
            }



        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            Erro = moPadrao.MensagemErroObtencao;
            return true;
        }
    }

    public bool VerificarPrimeiroAcesso(Int64 cdPessoaSEQ)
    {
        try
        {
            Erro = "";
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_Pessoa_Login", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;


            if (cdPessoaSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPessoaSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdPessoaSEQ"].Value = cdPessoaSEQ;
            }

            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            if (loDataTable.Rows.Count > 0)
            {
                if (Convert.ToInt16(loDataTable.Rows[0]["cdIndicadorPrimeiroAcessoPessoa"]) == 1)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            else
            {
                return true;
            }



        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            Erro = moPadrao.MensagemErroObtencao;
            return true;
        }
    }

    public string IncluirSolicitacaoEnvioEmail(Int64 cdPessoaSEQ, string nmPessoa, string dsSenhaLoginPessoa, Int64 cdUsuarioUltimaAlteracao)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {
            Erro = "";
            Int64 cdSolicitacaoEnvioEmailSEQ = 0;

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;


            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoSolicitacaoEnvioEmail");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_I_SolicitacaoEnvioEmail";
            loSqlCommand.CommandType = CommandType.StoredProcedure;

            loSqlCommand.Parameters.Add("@cdPessoaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdPessoaSEQ"].Value = cdPessoaSEQ;

            loSqlCommand.Parameters.Add("@nmPessoa", SqlDbType.VarChar, 70);
            loSqlCommand.Parameters["@nmPessoa"].Value = nmPessoa;

            loSqlCommand.Parameters.Add("@dsSenhaLoginPessoa", SqlDbType.VarChar, 255);
            loSqlCommand.Parameters["@dsSenhaLoginPessoa"].Value = dsSenhaLoginPessoa;

            loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

            loSqlCommand.Parameters.Add("@cdSolicitacaoEnvioEmailSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdSolicitacaoEnvioEmailSEQ"].Direction = ParameterDirection.Output;

            loSqlCommand.ExecuteNonQuery();

            cdSolicitacaoEnvioEmailSEQ = Convert.ToInt64(loSqlCommand.Parameters["@cdSolicitacaoEnvioEmailSEQ"].Value);

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            //return cdPessoaEmailSEQ;
            return "";

        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TransacaoSolicitacaoEnvioEmail");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            Erro = moPadrao.MensagemErroInclusao;
            return moPadrao.MensagemErroInclusao;
        }
    }

    public string AlterarSenha(Int64 cdPessoaSEQ, string dsSenhaLoginPessoa, Int64 cdUsuarioUltimaAlteracao)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {
            Erro = "";

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;


            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoSenha");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_U_Pessoa_Senha";
            loSqlCommand.CommandType = CommandType.StoredProcedure;


            loSqlCommand.Parameters.Add("@cdPessoaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdPessoaSEQ"].Value = cdPessoaSEQ;

            loSqlCommand.Parameters.Add("@dsSenhaLoginPessoa", SqlDbType.VarChar, 255);
            loSqlCommand.Parameters["@dsSenhaLoginPessoa"].Value = dsSenhaLoginPessoa;

            loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

            loSqlCommand.ExecuteNonQuery();

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";
        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TransacaoSenha");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            Erro = moPadrao.MensagemErroInclusao;
            return moPadrao.MensagemErroAlteracao;
        }
    }

    private object ValorToDbNull(object valor)
    {
        if (valor.ToString() == string.Empty || valor.ToString() == "0" || valor.ToString() == Convert.ToDateTime("0001-01-01").ToString())
            return DBNull.Value;
        else
            return valor;
    }



    #endregion Métodos
}
