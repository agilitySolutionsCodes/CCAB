<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Formulario.ascx.cs" Inherits="_SFA_ProdutoHistorico_Formulario" %>
<%@ Register TagPrefix="uc" TagName="DadosPai" Src="~/_SFA/Cadastros/ProdutoHistorico/DadosPai.ascx" %>

<!-- Preparação da PopUp Modal que exibirá o Formulário (Permite que o formulário seja arrastado pela tela) -->
<asp:Button runat="server" ID="btShowPanel1" Style="display: none" />
<asp:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="btShowPanel1"
    PopupControlID="Panel1" PopupDragHandleControlID="Panel1DragHandle" BackgroundCssClass="modalBackground" />

<!-- Cabeçalho Formulário -->
<div class="pageSection">
    <asp:Panel runat="Server" ID="Panel1DragHandle" CssClass="drag">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td class="tbTitulo_bordaEsquerda">
                    &nbsp;
                </td>
                <td class="tbTitulo_BG">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td width="250" class="tbTitulo_NomeTela" align="left">
                                <asp:Label runat="server" SkinID="normal" ID="lbOperacao" />
                            </td>
                            <td width="*">
                                <asp:Image ID="Image2" runat="server" Width="18" Height="36" ImageAlign="Right" ImageUrl="~/imgsCCAB/tbTitulo_imgMarcador.jpg" />
                            </td>
                            <td width="265" class="tbTitulo_NomeTela" align="left">
                                <asp:Label ID="lbNomeTela" runat="server" SkinID="normal" />
                            </td>
                        </tr>
                    </table>
                </td>
                <td class="tbTitulo_bordaDireita">
                    &nbsp;
                </td>
            </tr>
        </table>
    </asp:Panel>
</div>

<!-- Identificação do Pai --> 
<%if (MostraDadosPai){%>
<div style="margin-bottom: 14px;">
    <uc:DadosPai ID="DadosPai1" runat="server" />
</div>
<%} %>
            
<!-- Área de Mensagens -->
<div>
    <asp:ValidationSummary EnableClientScript="true" ID="ValidationSummary1" ShowSummary="false"
        ShowMessageBox="true" ValidationGroup="Form" HeaderText="O formulário contém erros:"
        runat="server" />
    <asp:CustomValidator ID="CustomValidator1" runat="server" ValidationGroup="Form" />
</div>
<!-- Formulário -->
<div>
    <asp:FormView ID="FormView1" runat="server" DataKeyNames="cdProdutoHistoricoSEQ" CellPadding="5"
        AutoGenerateRows="false" Width="100%" GridLines="None">
        
        <EditItemTemplate>
            <div class="pageSection">
                <asp:HiddenField ID="cdProdutoHistoricoSEQ" runat="server" Value='<%# Bind("cdProdutoHistoricoSEQ") %>' />                
                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbCadastro_Mestra">
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            Evento:
                        </td>
                        <td class="tdCamposFormularios">
                            <asp:DropDownList ID="cdTipoEventoHistorico" runat="server" ValidationGroup="Form"
                                CssClass="campoTexto" OnPreRender="ConfigCombo" DataSourceID="ObjectDataSource2" 
                                DataTextField="wkDominioCodigoReferenciado" DataValueField="vrDominioCodigoReferenciado" />
                        </td>
                        <td>
                        </td>
                        <td valign="middle" class="fonteTbCadastro">
                            Data:
                        </td>
                        <td class="tdCamposFormularios">
                            <asp:TextBox ID="dtOcorrenciaHistorico" runat="server" AutoPostBack="false" ValidationGroup="Form"
                                Columns="20" MaxLength="20" CssClass="campoTexto" Text='<%# Bind("dtOcorrenciaHistorico") %>' />
                        </td>
                        <td>
                    </tr>
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            Usuário:
                        </td>
                        <td class="tdCamposFormularios">
                            <asp:TextBox ID="nmUsuario" runat="server" AutoPostBack="false" ValidationGroup="Form"
                                Columns="10" MaxLength="10" CssClass="campoTexto" Text='<%# Bind("nmUsuario") %>' />
                        </td>
                        <td>
                        </td>
                        <td valign="middle" class="fonteTbCadastro">
                        </td>
                        <td class="tdCamposFormularios">
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            Código:*
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Numeric" DecimalPlaces="0" ID="cdProdutoERP" runat="server" ValidationGroup="Form"
                                Columns="30" MaxLength="30" CssClass="campoTexto" Text='<%# Bind("cdProdutoERP") %>' />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Código é campo obrigatório"
                                Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                ControlToValidate="cdProdutoERP" />
                        </td>
                        <td valign="middle" class="fonteTbCadastro">
                            Unidade:*
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Text" ID="dsUnidadeProduto" runat="server" ValidationGroup="Form"
                                Columns="30" MaxLength="30" CssClass="campoTexto" Text='<%# Bind("dsUnidadeProduto") %>' />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Unidade é campo obrigatório"
                                Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                ControlToValidate="dsUnidadeProduto" />
                        </td>
                    </tr>
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            Descrição:*
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Text" ID="dsProduto" runat="server" ValidationGroup="Form"
                                Columns="40" MaxLength="70" CssClass="campoTexto" Text='<%# Bind("dsProduto") %>' />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Descrição é campo obrigatório"
                                Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                ControlToValidate="dsProduto" />
                        </td>
                        <td class="fonteTbCadastro">
                            Qtd Embalagem:
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Numeric" DecimalPlaces="6" ID="qtEmbalagemProduto" runat="server" ValidationGroup="Form"  
                                Columns="20" MaxLength="22" CssClass="campoTexto" Text='<%# Bind("qtEmbalagemProduto", "{0:###,###,###,##0.000000}") %>' />
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td class="fonteTbCadastro">
                            Peso Liq:
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Numeric" DecimalPlaces="6" ID="qtPesoLiquidoProduto" runat="server" ValidationGroup="Form"  
                                Columns="20" MaxLength="22" CssClass="campoTexto" Text='<%# Bind("qtPesoLiquidoProduto", "{0:###,###,###,##0.000000}") %>' />
                        </td>
                        <td>
                        </td>
                        <td class="fonteTbCadastro">
                            Peso Bruto:
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Numeric" DecimalPlaces="6" ID="qtPesoBrutoProduto" runat="server" ValidationGroup="Form"  
                                Columns="20" MaxLength="22" CssClass="campoTexto" Text='<%# Bind("qtPesoBrutoProduto", "{0:###,###,###,##0.000000}") %>' />
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            Liberado p/ Colocação Pedido:*
                        </td>
                        <td class="tdCamposFormularios">
                            <asp:DropDownList ID="cdIndicadorLiberadoPedidoProduto" runat="server" ValidationGroup="Form"
                                CssClass="campoTexto" OnPreRender="ConfigCombo" DataSourceID="ObjectDataSource1" 
                                DataTextField="wkDominioCodigoReferenciado" DataValueField="vrDominioCodigoReferenciado" />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="[Liberado para Colocação de Pedido] é campo obrigatório"
                                Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                ControlToValidate="cdIndicadorLiberadoPedidoProduto" InitialValue="0" />
                        </td>
                        <td class="fonteTbCadastro">
                            Ordem de Exibição:
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Numeric" DecimalPlaces="0" ID="nuOrdemApresentacaoProduto" runat="server" ValidationGroup="Form"  
                                Columns="6" MaxLength="6" CssClass="campoTexto" Text='<%# Bind("nuOrdemApresentacaoProduto") %>' />
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            Observação:
                        </td>
                        <td class="tdCamposFormularios" colspan="5">
                            <conv:TextBox  Type="Text" ID="wkProduto" runat="server" ValidationGroup="Form"
                                Columns="50" Rows="5" TextMode="MultiLine" onkeyup="blocTexto(this, 255)" CssClass="campoTexto" Text='<%# Bind("wkProduto") %>' />
                        </td>
                    </tr>
                </table>
            </div>
            
            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="ObterLista" TypeName="CodigoReferenciado">
                <SelectParameters>
                    <asp:Parameter Name="dsDominioCodigoReferenciado" DefaultValue="DMESPINDICADORSIMNAO" Type="String" />
                </SelectParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" SelectMethod="ObterLista" TypeName="CodigoReferenciado">
                <SelectParameters>
                    <asp:Parameter Name="dsDominioCodigoReferenciado" DefaultValue="DMESPTIPOEVENTOHISTORICO" Type="String" />
                </SelectParameters>
            </asp:ObjectDataSource>
        </EditItemTemplate>          
    </asp:FormView>
    <div style="text-align: right;">
        <asp:Button runat="server" ID="btAction" CssClass="button" ValidationGroup="Form"
            CausesValidation="true" OnCommand="btAction_OnClick" />
        <asp:Button runat="server" ID="btCancel" CommandName="Cancel" CssClass="button" Text="cancelar" 
            CausesValidation="false" OnCommand="btCancel_OnClick" />
    </div>
</div>

