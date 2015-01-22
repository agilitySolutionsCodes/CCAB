using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;


/// <summary>
/// Summary description for Produto
/// </summary>
public class Produto
{
    #region Variáveis Modulares

    HttpContext moHttpContext = HttpContext.Current;
    Usuario moUsuario = new Usuario();
    Padrao moPadrao = new Padrao();
    string msStringConexao;

    #endregion Variáveis Modulares

	public Produto()
	{
        moUsuario = (Usuario)moHttpContext.Session["Usuario"];
        msStringConexao = moPadrao.ObterStringConexao();
    }

    #region Métodos

    public DataTable Obter(Int64 cdProdutoSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_Produto", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;



            if (cdProdutoSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdProdutoSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdProdutoSEQ"].Value = cdProdutoSEQ;
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

    public DataTable ObterLista(string cdProdutoERP, string dsProduto, int cdIndicadorLiberadoPedidoProduto, int cdTipoProduto, int cdFornecedor)
    {


        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_Produto", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;
            
            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdProdutoERP", SqlDbType.VarChar, 30);
            loSqlDataAdapter.SelectCommand.Parameters["@cdProdutoERP"].Value = string.IsNullOrEmpty(cdProdutoERP) ? (object)DBNull.Value : cdProdutoERP;
            
            loSqlDataAdapter.SelectCommand.Parameters.Add("@dsProduto", SqlDbType.VarChar, 70);
            loSqlDataAdapter.SelectCommand.Parameters["@dsProduto"].Value = string.IsNullOrEmpty(dsProduto) ? (object)DBNull.Value : dsProduto; ;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorLiberadoPedidoProduto", SqlDbType.Int);
            loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorLiberadoPedidoProduto"].Value = cdIndicadorLiberadoPedidoProduto.Equals(0) ? (object)DBNull.Value : cdIndicadorLiberadoPedidoProduto;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdTipoProduto", SqlDbType.Int);
            loSqlDataAdapter.SelectCommand.Parameters["@cdTipoProduto"].Value = cdTipoProduto.Equals(0) ? (object)DBNull.Value : cdTipoProduto;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdFornecedorSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdFornecedorSEQ"].Value = cdFornecedor.Equals(0) ? (object)DBNull.Value : cdFornecedor;
            
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

    public DataTable ObterHistorico(Int64 cdProdutoHistoricoSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_ProdutoHistorico", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;



            if (cdProdutoHistoricoSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdProdutoHistoricoSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdProdutoHistoricoSEQ"].Value = cdProdutoHistoricoSEQ;
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

    public DataTable ObterListaHistorico(Int64 cdProdutoSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_ProdutoHistorico", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;



            if (cdProdutoSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdProdutoSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdProdutoSEQ"].Value = cdProdutoSEQ;
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

    public string Incluir(Int64 cdPessoaSEQ, int cdIndicadorTipoProduto, int cdIndicadorPreferencialProduto, int cdIndicadorStatusProduto, string enProduto, string wkProduto)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {
            Int64 cdProdutoSEQ = 0;

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;

            string MensagemDuplicidade;

            //Consistências
            if (cdIndicadorTipoProduto == 0)
            {
                return "Tipo de Email " + moPadrao.MensagemObrigatorio;
            }
            if (enProduto.Trim() == "")
            {
                return "Descrição " + moPadrao.MensagemObrigatorio;
            }
            if (cdIndicadorPreferencialProduto == 0)
            {
                return "Email Preferencial " + moPadrao.MensagemObrigatorio;
            }

            MensagemDuplicidade = VerificarDuplicidade(0, cdPessoaSEQ, enProduto);
            if (MensagemDuplicidade != "")
            {
                return MensagemDuplicidade;
            }

            if (cdIndicadorPreferencialProduto == 1)
            {
                MensagemDuplicidade = VerificarDuplicidadePreferencial(cdPessoaSEQ, 0);
                if (MensagemDuplicidade != "")
                {
                    return MensagemDuplicidade;
                }
            }
            

            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoProduto");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_I_Produto";
            loSqlCommand.CommandType = CommandType.StoredProcedure;

            loSqlCommand.Parameters.Add("@cdPessoaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdPessoaSEQ"].Value = cdPessoaSEQ;

            loSqlCommand.Parameters.Add("@cdIndicadorTipoProduto", SqlDbType.Int);
            loSqlCommand.Parameters["@cdIndicadorTipoProduto"].Value = cdIndicadorTipoProduto;

            loSqlCommand.Parameters.Add("@cdIndicadorPreferencialProduto", SqlDbType.Int);
            loSqlCommand.Parameters["@cdIndicadorPreferencialProduto"].Value = cdIndicadorPreferencialProduto;

            loSqlCommand.Parameters.Add("@cdIndicadorStatusProduto", SqlDbType.Int);
            loSqlCommand.Parameters["@cdIndicadorStatusProduto"].Value = 1;

            loSqlCommand.Parameters.Add("@enProduto", SqlDbType.VarChar, 70);
            loSqlCommand.Parameters["@enProduto"].Value = enProduto;

            if (wkProduto.Trim() != "")
            {
                loSqlCommand.Parameters.Add("@wkProduto", SqlDbType.VarChar, 255);
                loSqlCommand.Parameters["@wkProduto"].Value = wkProduto;
            }

            loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = moUsuario.cdUsuario;

            loSqlCommand.Parameters.Add("@cdProdutoSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdProdutoSEQ"].Direction = ParameterDirection.Output;

            loSqlCommand.ExecuteNonQuery();

            cdProdutoSEQ = Convert.ToInt64(loSqlCommand.Parameters["@cdProdutoSEQ"].Value);

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            //return cdProdutoSEQ;
            return "";

        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TransacaoProduto");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroInclusao;
        }
    }

    public string Alterar(Int64 cdProdutoSEQ, string cdProdutoERP, string dsProduto, string dsUnidadeProduto, double qtEmbalagemProduto, double qtPesoLiquidoProduto, double qtPesoBrutoProduto, int cdIndicadorLiberadoPedidoProduto, Int64 cdGrupoProdutoSEQ, string wkProduto, Int64 cdRecnoMicrosiga, Int64 cdUsuarioUltimaAlteracao)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;



            //Consistências

            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoProduto");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_U_Produto";
            loSqlCommand.CommandType = CommandType.StoredProcedure;

            loSqlCommand.Parameters.Add("@cdProdutoSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdProdutoSEQ"].Value = cdProdutoSEQ;

            loSqlCommand.Parameters.Add("@cdProdutoERP", SqlDbType.VarChar, 30);
            loSqlCommand.Parameters["@cdProdutoERP"].Value = cdProdutoERP;

            loSqlCommand.Parameters.Add("@dsProduto", SqlDbType.VarChar, 70);
            loSqlCommand.Parameters["@dsProduto"].Value = dsProduto;

            loSqlCommand.Parameters.Add("@dsUnidadeProduto", SqlDbType.VarChar, 30);
            loSqlCommand.Parameters["@dsUnidadeProduto"].Value = dsUnidadeProduto;

            if (qtEmbalagemProduto != 0)
            {
                loSqlCommand.Parameters.Add("@qtEmbalagemProduto", SqlDbType.Float);
                loSqlCommand.Parameters["@qtEmbalagemProduto"].Value = qtEmbalagemProduto;
            }

            if (qtPesoLiquidoProduto != 0)
            {
                loSqlCommand.Parameters.Add("@qtPesoLiquidoProduto", SqlDbType.Float);
                loSqlCommand.Parameters["@qtPesoLiquidoProduto"].Value = qtPesoLiquidoProduto;
            }

            if (qtPesoBrutoProduto != 0)
            {
                loSqlCommand.Parameters.Add("@qtPesoBrutoProduto", SqlDbType.Float);
                loSqlCommand.Parameters["@qtPesoBrutoProduto"].Value = qtPesoBrutoProduto;
            }

            loSqlCommand.Parameters.Add("@cdIndicadorLiberadoPedidoProduto", SqlDbType.Int);
            loSqlCommand.Parameters["@cdIndicadorLiberadoPedidoProduto"].Value = cdIndicadorLiberadoPedidoProduto;

            if (cdGrupoProdutoSEQ != 0)
            {
                loSqlCommand.Parameters.Add("@cdGrupoProdutoSEQ", SqlDbType.BigInt);
                loSqlCommand.Parameters["@cdGrupoProdutoSEQ"].Value = cdGrupoProdutoSEQ;
            }

            if (wkProduto.Trim() != "")
            {
                loSqlCommand.Parameters.Add("@wkProduto", SqlDbType.VarChar, 255);
                loSqlCommand.Parameters["@wkProduto"].Value = wkProduto;
            }

            if (cdRecnoMicrosiga != 0)
            {
                loSqlCommand.Parameters.Add("@cdRecnoMicrosiga", SqlDbType.BigInt);
                loSqlCommand.Parameters["@cdRecnoMicrosiga"].Value = cdRecnoMicrosiga;
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
            loSqlTransaction.Rollback("TransacaoProduto");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroAlteracao;
        }
    }

    private string VerificarDuplicidade(Int64 cdProdutoSEQ, Int64 cdPessoaSEQ, string enProduto)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_Produto_Duplicidade", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;


            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPessoaSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdPessoaSEQ"].Value = cdPessoaSEQ;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@enProduto", SqlDbType.VarChar, 70);
            loSqlDataAdapter.SelectCommand.Parameters["@enProduto"].Value = enProduto;

            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            if (cdProdutoSEQ == 0)
            {
                if (loDataTable.Rows.Count > 0)
                {
                    return "Email já existe.";
                }
            }
            else
            {
                if (loDataTable.Rows.Count > 0)
                {
                    if (Convert.ToInt32(loDataTable.Rows[0]["cdProdutoSEQ"]) != cdProdutoSEQ)
                    {
                        return "Email já existe.";
                    }
                }
            }

            return "";

        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroObtencao;
        }
    }

    private string VerificarDuplicidadePreferencial(Int64 cdPessoaSEQ, Int64 cdProdutoSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_Produto_DuplicidadePreferencial", loSqlConnection);

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

            if (cdProdutoSEQ == 0)
            {
                if (loDataTable.Rows.Count > 0)
                {
                    return "Email Preferencial já existe.";
                }
            }
            else
            {
                if (loDataTable.Rows.Count > 0)
                {
                    if (Convert.ToInt32(loDataTable.Rows[0]["cdProdutoSEQ"]) != cdProdutoSEQ)
                    {
                        return "Email Preferencial já existe.";
                    }
                }
            }

            return "";

        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroObtencao;
        }
    }



    #endregion Métodos
}
