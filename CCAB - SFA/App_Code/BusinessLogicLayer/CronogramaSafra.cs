using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;


/// <summary>
/// Summary description for CronogramaSafra
/// </summary>
public class CronogramaSafra
{
    #region Variáveis Modulares

    HttpContext moHttpContext = HttpContext.Current;
    Usuario moUsuario = new Usuario();
    Padrao moPadrao = new Padrao();
    string msStringConexao;

    #endregion Variáveis Modulares

	public CronogramaSafra()
	{
        moUsuario = (Usuario)moHttpContext.Session["Usuario"];
        msStringConexao = moPadrao.ObterStringConexao();
    }

    #region Métodos

    public string Incluir(string dsCronogramaSafra, DateTime dtInicioCronogramaSafra, DateTime dtFimCronogramaSafra, DateTime dtLimiteLiberacaoCCCronogramaSafra, DateTime dtLimiteAprovacaoCCCronogramaSafra, DateTime dtLimiteLiberacaoPVCronogramaSafra, DateTime dtLimiteAprovacaoPVRCCronogramaSafra, DateTime dtLimiteAprovacaoPVACCronogramaSafra, string wkCronogramaSafra, Int64 cdIndicadorStatusCronogramaSafra, Int64 cdUsuarioUltimaAlteracao, Int64 qtProdutoPrecoCronogramaSafra)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {
            Int64 cdCronogramaSafraSEQ = 0;

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;



            //Consistências
            if (dsCronogramaSafra.Trim() == "")
            {
                return " " + moPadrao.MensagemObrigatorio;
            }

            if (dtInicioCronogramaSafra == DateTime.MinValue)
            {
                return "Início" + moPadrao.MensagemObrigatorio;
            }

            if (dtFimCronogramaSafra == DateTime.MinValue)
            {
                return "Fim" + moPadrao.MensagemObrigatorio;
            }

            if (dtLimiteLiberacaoCCCronogramaSafra == DateTime.MinValue)
            {
                return "Limite Liberação" + moPadrao.MensagemObrigatorio;
            }

            if (dtLimiteAprovacaoCCCronogramaSafra == DateTime.MinValue)
            {
                return "Limite Aprovação CC" + moPadrao.MensagemObrigatorio;
            }

            if (dtLimiteLiberacaoPVCronogramaSafra == DateTime.MinValue)
            {
                return "Limite Liberação PVC" + moPadrao.MensagemObrigatorio;
            }

            if (dtLimiteAprovacaoPVRCCronogramaSafra == DateTime.MinValue)
            {
                return "Limite Aprovação PVRC" + moPadrao.MensagemObrigatorio;
            }

            if (dtLimiteAprovacaoPVACCronogramaSafra == DateTime.MinValue)
            {
                return "Limite Aprovação PVAC" + moPadrao.MensagemObrigatorio;
            }

            if (cdUsuarioUltimaAlteracao == 0)
            {
                return "Usuário" + moPadrao.MensagemObrigatorio;
            }

            if (cdIndicadorStatusCronogramaSafra == 0)
            {
                return "Situação" + moPadrao.MensagemObrigatorio;
            }

            string MensagemRetorno;
            MensagemRetorno = ConsistirDatas(dtInicioCronogramaSafra, dtFimCronogramaSafra, dtLimiteLiberacaoCCCronogramaSafra, dtLimiteAprovacaoCCCronogramaSafra, dtLimiteLiberacaoPVCronogramaSafra, dtLimiteAprovacaoPVRCCronogramaSafra, dtLimiteAprovacaoPVACCronogramaSafra);
            if (MensagemRetorno != "")
            {
                return MensagemRetorno;
            }

            // Verifica se a descricao do do CronogramaSAFRA já foi cadastrada
            bool lbDisponivel = true;
            lbDisponivel = VerificaDescricaoCronogramaSafra(dsCronogramaSafra.Trim(), 0);
            if (lbDisponivel == false)
            {
                return "Descrição do Cronograma Safra já cadastrada";

            }

            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoCronogramaSafra");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;


            loSqlCommand.CommandText = "SP_I_CronogramaSafra";
            loSqlCommand.CommandType = CommandType.StoredProcedure;


            loSqlCommand.Parameters.Add("@dsCronogramaSafra", SqlDbType.VarChar, 30);
            loSqlCommand.Parameters["@dsCronogramaSafra"].Value = dsCronogramaSafra;

            loSqlCommand.Parameters.Add("@dtInicioCronogramaSafra", SqlDbType.DateTime);
            loSqlCommand.Parameters["@dtInicioCronogramaSafra"].Value = dtInicioCronogramaSafra;

            loSqlCommand.Parameters.Add("@dtFimCronogramaSafra", SqlDbType.DateTime);
            loSqlCommand.Parameters["@dtFimCronogramaSafra"].Value = dtFimCronogramaSafra;

            loSqlCommand.Parameters.Add("@dtLimiteLiberacaoCCCronogramaSafra", SqlDbType.DateTime);
            loSqlCommand.Parameters["@dtLimiteLiberacaoCCCronogramaSafra"].Value = dtLimiteLiberacaoCCCronogramaSafra;

            loSqlCommand.Parameters.Add("@dtLimiteAprovacaoCCCronogramaSafra", SqlDbType.DateTime);
            loSqlCommand.Parameters["@dtLimiteAprovacaoCCCronogramaSafra"].Value = dtLimiteAprovacaoCCCronogramaSafra;

            loSqlCommand.Parameters.Add("@dtLimiteLiberacaoPVCronogramaSafra", SqlDbType.DateTime);
            loSqlCommand.Parameters["@dtLimiteLiberacaoPVCronogramaSafra"].Value = dtLimiteLiberacaoPVCronogramaSafra;

            loSqlCommand.Parameters.Add("@dtLimiteAprovacaoPVRCCronogramaSafra", SqlDbType.DateTime);
            loSqlCommand.Parameters["@dtLimiteAprovacaoPVRCCronogramaSafra"].Value = dtLimiteAprovacaoPVRCCronogramaSafra;

            loSqlCommand.Parameters.Add("@dtLimiteAprovacaoPVACCronogramaSafra", SqlDbType.DateTime);
            loSqlCommand.Parameters["@dtLimiteAprovacaoPVACCronogramaSafra"].Value = dtLimiteAprovacaoPVACCronogramaSafra;

            if (wkCronogramaSafra.Trim() != "")
            {
                loSqlCommand.Parameters.Add("@wkCronogramaSafra", SqlDbType.VarChar, 255);
                loSqlCommand.Parameters["@wkCronogramaSafra"].Value = wkCronogramaSafra;
            }

            loSqlCommand.Parameters.Add("@cdIndicadorStatusCronogramaSafra", SqlDbType.Int);
            loSqlCommand.Parameters["@cdIndicadorStatusCronogramaSafra"].Value = cdIndicadorStatusCronogramaSafra;

            loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

            loSqlCommand.Parameters.Add("@qtProdutoPrecoCronogramaSafra", SqlDbType.BigInt);
            loSqlCommand.Parameters["@qtProdutoPrecoCronogramaSafra"].Value = qtProdutoPrecoCronogramaSafra;

            loSqlCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCronogramaSafraSEQ"].Direction = ParameterDirection.Output;


            loSqlCommand.ExecuteNonQuery();

            cdCronogramaSafraSEQ = Convert.ToInt64(loSqlCommand.Parameters["@cdCronogramaSafraSEQ"].Value);

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";

        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TransacaoCronogramaSafra");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroInclusao;
        }
    }

    public string Alterar(Int64 cdCronogramaSafraSEQ, string dsCronogramaSafra, DateTime dtInicioCronogramaSafra, DateTime dtFimCronogramaSafra, DateTime dtLimiteLiberacaoCCCronogramaSafra, DateTime dtLimiteAprovacaoCCCronogramaSafra, DateTime dtLimiteLiberacaoPVCronogramaSafra, DateTime dtLimiteAprovacaoPVRCCronogramaSafra, DateTime dtLimiteAprovacaoPVACCronogramaSafra, string wkCronogramaSafra, Int64 cdIndicadorStatusCronogramaSafra, Int64 cdUsuarioUltimaAlteracao, Int64 qtProdutoPrecoCronogramaSafra)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;


            //Consistências
            if (cdCronogramaSafraSEQ == 0)
            {
                return "Código Cronograma" + moPadrao.MensagemObrigatorio;
            }

            if (dsCronogramaSafra.Trim() == "")
            {
                return " " + moPadrao.MensagemObrigatorio;
            }

            if (dtInicioCronogramaSafra == DateTime.MinValue)
            {
                return "Início" + moPadrao.MensagemObrigatorio;
            }

            if (dtFimCronogramaSafra == DateTime.MinValue)
            {
                return "Fim" + moPadrao.MensagemObrigatorio;
            }

            if (dtLimiteLiberacaoCCCronogramaSafra == DateTime.MinValue)
            {
                return "Limite Liberação" + moPadrao.MensagemObrigatorio;
            }

            if (dtLimiteAprovacaoCCCronogramaSafra == DateTime.MinValue)
            {
                return "Limite Aprovação CC" + moPadrao.MensagemObrigatorio;
            }

            if (dtLimiteLiberacaoPVCronogramaSafra == DateTime.MinValue)
            {
                return "Limite Liberação PVC" + moPadrao.MensagemObrigatorio;
            }

            if (dtLimiteAprovacaoPVRCCronogramaSafra == DateTime.MinValue)
            {
                return "Limite Aprovação PVRC" + moPadrao.MensagemObrigatorio;
            }

            if (dtLimiteAprovacaoPVACCronogramaSafra == DateTime.MinValue)
            {
                return "Limite Aprovação PVAC" + moPadrao.MensagemObrigatorio;
            }

            if (cdUsuarioUltimaAlteracao == 0)
            {
                return "Usuário" + moPadrao.MensagemObrigatorio;
            }

            if (cdIndicadorStatusCronogramaSafra == 0)
            {
                return "Situação" + moPadrao.MensagemObrigatorio;
            }

            string MensagemRetorno;
            MensagemRetorno = ConsistirDatas(dtInicioCronogramaSafra, dtFimCronogramaSafra, dtLimiteLiberacaoCCCronogramaSafra, dtLimiteAprovacaoCCCronogramaSafra, dtLimiteLiberacaoPVCronogramaSafra, dtLimiteAprovacaoPVRCCronogramaSafra, dtLimiteAprovacaoPVACCronogramaSafra);
            if (MensagemRetorno != "")
            {
                return MensagemRetorno;
            }

            // Verifica se a descricao do do CronogramaSAFRA já foi cadastrada
            bool lbDisponivel = true;
            lbDisponivel = VerificaDescricaoCronogramaSafra(dsCronogramaSafra.Trim(), cdCronogramaSafraSEQ);
            if (lbDisponivel == false)
            {
                return "Descrição do Cronograma Safra já cadastrada";

            }

            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoCronogramaSafra");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_U_CronogramaSafra";
            loSqlCommand.CommandType = CommandType.StoredProcedure;

            loSqlCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

            loSqlCommand.Parameters.Add("@dsCronogramaSafra", SqlDbType.VarChar, 30);
            loSqlCommand.Parameters["@dsCronogramaSafra"].Value = dsCronogramaSafra;

            loSqlCommand.Parameters.Add("@dtInicioCronogramaSafra", SqlDbType.DateTime);
            loSqlCommand.Parameters["@dtInicioCronogramaSafra"].Value = dtInicioCronogramaSafra;

            loSqlCommand.Parameters.Add("@dtFimCronogramaSafra", SqlDbType.DateTime);
            loSqlCommand.Parameters["@dtFimCronogramaSafra"].Value = dtFimCronogramaSafra;

            loSqlCommand.Parameters.Add("@dtLimiteLiberacaoCCCronogramaSafra", SqlDbType.DateTime);
            loSqlCommand.Parameters["@dtLimiteLiberacaoCCCronogramaSafra"].Value = dtLimiteLiberacaoCCCronogramaSafra;

            loSqlCommand.Parameters.Add("@dtLimiteAprovacaoCCCronogramaSafra", SqlDbType.DateTime);
            loSqlCommand.Parameters["@dtLimiteAprovacaoCCCronogramaSafra"].Value = dtLimiteAprovacaoCCCronogramaSafra;

            loSqlCommand.Parameters.Add("@dtLimiteLiberacaoPVCronogramaSafra", SqlDbType.DateTime);
            loSqlCommand.Parameters["@dtLimiteLiberacaoPVCronogramaSafra"].Value = dtLimiteLiberacaoPVCronogramaSafra;

            loSqlCommand.Parameters.Add("@dtLimiteAprovacaoPVRCCronogramaSafra", SqlDbType.DateTime);
            loSqlCommand.Parameters["@dtLimiteAprovacaoPVRCCronogramaSafra"].Value = dtLimiteAprovacaoPVRCCronogramaSafra;

            loSqlCommand.Parameters.Add("@dtLimiteAprovacaoPVACCronogramaSafra", SqlDbType.DateTime);
            loSqlCommand.Parameters["@dtLimiteAprovacaoPVACCronogramaSafra"].Value = dtLimiteAprovacaoPVACCronogramaSafra;

            if (wkCronogramaSafra.Trim() != "")
            {
                loSqlCommand.Parameters.Add("@wkCronogramaSafra", SqlDbType.VarChar, 255);
                loSqlCommand.Parameters["@wkCronogramaSafra"].Value = wkCronogramaSafra;
            }

            loSqlCommand.Parameters.Add("@cdIndicadorStatusCronogramaSafra", SqlDbType.Int);
            loSqlCommand.Parameters["@cdIndicadorStatusCronogramaSafra"].Value = cdIndicadorStatusCronogramaSafra;

            loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

            loSqlCommand.Parameters.Add("@qtProdutoPrecoCronogramaSafra", SqlDbType.BigInt);
            loSqlCommand.Parameters["@qtProdutoPrecoCronogramaSafra"].Value = qtProdutoPrecoCronogramaSafra;

            loSqlCommand.ExecuteNonQuery();

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";
        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TransacaoCronogramaSafra");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroAlteracao;
        }
    }

    public string Excluir(Int64 cdCronogramaSafraSEQ)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;

            // Verifica se o cronograma safra pode ser excluido
            bool lbDisponivel = true;
            lbDisponivel = VerificaExclusaoCronogramaSafra(cdCronogramaSafraSEQ);
            if (lbDisponivel == false)
            {
                return "Exclusão não permitida pois já há Tabela de Preço cadastrada para este registro";

            }

            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoCronogramaSafra");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_D_CronogramaSafra";
            loSqlCommand.CommandType = CommandType.StoredProcedure;


            loSqlCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

            loSqlCommand.ExecuteNonQuery();

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";
        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TransacaoCronogramaSafra");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroExclusao;
        }
    }

    public DataTable ObterLista(string dsCronogramaSafra, Int64 cdIndicadorStatusCronogramaSafra, string Ano, Int64 cdPessoaSEQ, int cdIndicadorSituacaoCooperativa)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_CronogramaSafra", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            if (dsCronogramaSafra.Trim() != "")
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@dsCronogramaSafra", SqlDbType.VarChar, 30);
                loSqlDataAdapter.SelectCommand.Parameters["@dsCronogramaSafra"].Value = dsCronogramaSafra;
            }

            if (cdIndicadorStatusCronogramaSafra != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorStatusCronogramaSafra", SqlDbType.Int);
                loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorStatusCronogramaSafra"].Value = cdIndicadorStatusCronogramaSafra;
            }

            if (Ano != "" & Ano != "Todos")
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@Ano", SqlDbType.VarChar, 4);
                loSqlDataAdapter.SelectCommand.Parameters["@Ano"].Value = Ano;
            }

            if (cdPessoaSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPessoaSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdPessoaSEQ"].Value = cdPessoaSEQ;
            }

            if (cdIndicadorSituacaoCooperativa != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorSituacaoCooperativa", SqlDbType.Int);
                loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorSituacaoCooperativa"].Value = cdIndicadorSituacaoCooperativa;
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


    public DataTable ObterListaAno()
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_CronogramaSafraAno", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            //if (dsCronogramaSafra.Trim() != "")
            //{
            //    loSqlDataAdapter.SelectCommand.Parameters.Add("@dsCronogramaSafra", SqlDbType.VarChar, 30);
            //    loSqlDataAdapter.SelectCommand.Parameters["@dsCronogramaSafra"].Value = dsCronogramaSafra;
            //}

            //if (cdIndicadorStatusCronogramaSafra != 0)
            //{
            //    loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorStatusCronogramaSafra", SqlDbType.Int);
            //    loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorStatusCronogramaSafra"].Value = cdIndicadorStatusCronogramaSafra;
            //}

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


    public DataTable Obter(Int64 cdCronogramaSafraSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_CronogramaSafra", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;


            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;



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

    public DataTable ObterListaHistorico(Int64 cdCronogramaSafraSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_CronogramaSafraHistorico", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;



            if (cdCronogramaSafraSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;
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

    public DataTable ObterHistorico(Int64 cdCronogramaSafraHistoricoSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_CronogramaSafraHistorico", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;



            if (cdCronogramaSafraHistoricoSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraHistoricoSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraHistoricoSEQ"].Value = cdCronogramaSafraHistoricoSEQ;
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


    private string ConsistirDatas(DateTime dtInicioCronogramaSafra, DateTime dtFimCronogramaSafra, DateTime dtLimiteLiberacaoCCCronogramaSafra, DateTime dtLimiteAprovacaoCCCronogramaSafra, DateTime dtLimiteLiberacaoPVCronogramaSafra, DateTime dtLimiteAprovacaoPVRCCronogramaSafra, DateTime dtLimiteAprovacaoPVACCronogramaSafra)
    {

        // Período
        DateTime dtInicio = dtInicioCronogramaSafra;
        DateTime dtFim = dtFimCronogramaSafra;

        if (dtFim < dtInicio)
            return "Data Fim deve ser maior ou igual a Data Início";

        // Data Limite Liberação Compra
        DateTime dtLibCompra = dtLimiteLiberacaoCCCronogramaSafra;

        if (dtLibCompra < dtInicio || dtLibCompra > dtFim)
            return "Data Limite Liberação Compra deve estar no período entre Data Início e Data Fim";

        // Data Limite Aprovação Compra
        DateTime dtAprovCompra = dtLimiteAprovacaoCCCronogramaSafra;

        if (dtAprovCompra < dtLibCompra || dtAprovCompra > dtFim)
            return "Data Limite Aprovação Compra deve estar no período entre Data Limite Liberação Compra e Data Fim";

        // Data Limite Liberação Pedido
        DateTime dtLibPedido = dtLimiteLiberacaoPVCronogramaSafra;

        if (dtLibPedido < dtAprovCompra || dtLibPedido > dtFim)
            return "Data Limite Liberação Pedido deve estar no período entre Data Limite Aprovação Compra e Data Fim";

        // Data Limite Aprovação Pedido RC
        DateTime dtLibPedidoRC = dtLimiteAprovacaoPVRCCronogramaSafra;

        if (dtLibPedidoRC < dtLibPedido || dtLibPedidoRC > dtFim)
            return "Data Limite Aprovação Pedido RC deve estar no período entre Data Limite Liberação Pedido e Data Fim";

        // Data Limite Aprovação Pedido Área Comercial
        DateTime dtAprovPedido = dtLimiteAprovacaoPVACCronogramaSafra;

        if (dtAprovPedido < dtLibPedidoRC || dtAprovPedido > dtFim)
            return "Data Limite Aprovação Pedido Área Comercial deve estar no período entre Data Limite Aprovação Pedido RC e Data Fim";


        return "";
    }

    private bool VerificaDescricaoCronogramaSafra(String dsCronogramaSafra, Int64 cdCronogramaSafraSEQ)
    {
        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_VerificaDescricaoCronogramaSafra", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@dsCronogramaSafra", SqlDbType.VarChar, 30);
            loSqlDataAdapter.SelectCommand.Parameters["@dsCronogramaSafra"].Value = dsCronogramaSafra;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            if (loDataTable.Rows.Count > 0)
            {
                return false;
            }
            else
            {
                return true;
            }
        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }

    }

    private bool VerificaExclusaoCronogramaSafra(Int64 cdCronogramaSafraSEQ)
    {
        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_VerificaExclusaoCronogramaSafra", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            if (loDataTable.Rows.Count > 0)
            {
                return false;
            }
            else
            {
                return true;
            }
        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }

    }

    #endregion Métodos
}
