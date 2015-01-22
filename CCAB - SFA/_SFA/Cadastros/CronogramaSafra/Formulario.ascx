<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Formulario.ascx.cs" Inherits="_SFA_CronogramaSafra_Formulario" %>
<!-- Cabeçalho Formulário -->

<script type="text/javascript" src="../../../scripts/JScript.js"></script>

<!-- Preparação da PopUp Modal que exibirá o Formulário (Permite que o formulário seja arrastado pela tela) -->
<asp:Button runat="server" ID="btShowPanel1" Style="display: none" />
<asp:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="btShowPanel1"
    PopupControlID="Panel1" PopupDragHandleControlID="Panel1DragHandle" BackgroundCssClass="modalBackground" />
    
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
<!-- Área de Mensagens -->
<div>
    <asp:ValidationSummary EnableClientScript="true" ID="ValidationSummary1" ShowSummary="false"
        ShowMessageBox="true" ValidationGroup="Form" HeaderText="O formulário contém erros:"
        runat="server" />
    <asp:CustomValidator ID="CustomValidator1" runat="server" ValidationGroup="Form" />
</div>
<!-- Formulário -->
<div>
    <asp:FormView ID="FormView1" runat="server" DataKeyNames="cdCronogramaSafraSEQ" CellPadding="5"
        AutoGenerateRows="false" Width="100%" GridLines="None">
        
        <EditItemTemplate>
            <div class="pageSection">
                <asp:HiddenField ID="cdCronogramaSafraSEQ" runat="server" Value='<%# Bind("cdCronogramaSafraSEQ") %>' />
                <asp:HiddenField ID="cdUsuarioUltimaAlteracao" runat="server" />
                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbCadastro_Mestra">
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            Descrição:*
                        </td>
                        <td class="tdCamposFormularios" colspan="4">
                            <conv:TextBox Type="Text" ID="dsCronogramaSafra" runat="server" ValidationGroup="Form"
                                Columns="35" MaxLength="30" CssClass="campoTexto" Text='<%# Bind("dsCronogramaSafra") %>' />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator0" runat="server" ErrorMessage="Descrição é campo obrigatório"
                                Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                ControlToValidate="dsCronogramaSafra" />
                        </td>
                    </tr>
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            Data Início:*
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Date" ID="dtInicioCronogramaSafra" 
                                runat="server" ValidationGroup="Form"
                                CssClass="campoTexto" Text='<%# Bind("dtInicioCronogramaSafra", "{0:dd/MM/yyyy}") %>' />
                            <asp:Label ID="Label1" runat="server" SkinID="data" style="font-size: xx-small; vertical-align: middle" Text="&nbsp;(ddmmaaaa)" />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator1" runat="server" 
                                Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                ErrorMessage="Data Inicial é campo obrigatório"
                                ControlToValidate="dtInicioCronogramaSafra" />
                            <asp:CompareValidator Display="None" id="CompareValidator1" runat="server" ValidationGroup="Form" 
                                Operator="DataTypeCheck" Type="Date" Text="*" ForeColor="#f6f6f6" EnableClientScript="true" 
                                ErrorMessage="Data Inicial informada não é válida" 
                                ControlToValidate="dtInicioCronogramaSafra" />
                        </td>
                        <td valign="middle" class="fonteTbCadastro">
                            Data Fim:*
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Date" ID="dtFimCronogramaSafra" 
                                runat="server" ValidationGroup="Form"
                                CssClass="campoTexto" Text='<%# Bind("dtFimCronogramaSafra", "{0:dd/MM/yyyy}") %>' />
                            <asp:Label ID="Label2" runat="server" SkinID="data" style="font-size: xx-small; vertical-align: middle" Text="&nbsp;(ddmmaaaa)" />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator2" runat="server" 
                                Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                ErrorMessage="Data Final é campo obrigatório"
                                ControlToValidate="dtFimCronogramaSafra" />
                            <asp:CompareValidator Display="None" id="CompareValidator2" runat="server" ValidationGroup="Form" 
                                Operator="DataTypeCheck" Type="Date" Text="*" ForeColor="#f6f6f6" EnableClientScript="true" 
                                ErrorMessage="Data Final informada não é válida" 
                                ControlToValidate="dtFimCronogramaSafra" />
                        </td>
                    </tr>
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            Data Limite Liberação Compra:*
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Date" ID="dtLimiteLiberacaoCCCronogramaSafra" 
                                runat="server" ValidationGroup="Form"
                                CssClass="campoTexto" Text='<%# Bind("dtLimiteLiberacaoCCCronogramaSafra", "{0:dd/MM/yyyy}") %>' />
                            <asp:Label ID="Label3" runat="server" SkinID="data" style="font-size: xx-small; vertical-align: middle" Text="&nbsp;(ddmmaaaa)" />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator3" runat="server" 
                                Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                ErrorMessage="Data Limite Liberação Compra é campo obrigatório"
                                ControlToValidate="dtLimiteLiberacaoCCCronogramaSafra" />
                            <asp:CompareValidator Display="None" id="CompareValidator3" runat="server" ValidationGroup="Form" 
                                Operator="DataTypeCheck" Type="Date" Text="*" ForeColor="#f6f6f6" EnableClientScript="true" 
                                ErrorMessage="Data Limite Liberação Compra informada não é válida" 
                                ControlToValidate="dtLimiteLiberacaoCCCronogramaSafra" />
                        </td>
                        <td valign="middle" class="fonteTbCadastro">
                            Data Limite Aprovação Compra:*
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Date" ID="dtLimiteAprovacaoCCCronogramaSafra" 
                                runat="server" ValidationGroup="Form"
                                CssClass="campoTexto" Text='<%# Bind("dtLimiteAprovacaoCCCronogramaSafra", "{0:dd/MM/yyyy}") %>' />
                            <asp:Label ID="Label4" runat="server" SkinID="data" style="font-size: xx-small; vertical-align: middle" Text="&nbsp;(ddmmaaaa)" />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator4" runat="server" 
                                Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                ErrorMessage="Data Limite Aprovação Compra é campo obrigatório"
                                ControlToValidate="dtLimiteAprovacaoCCCronogramaSafra" />
                            <asp:CompareValidator Display="None" id="CompareValidator4" runat="server" ValidationGroup="Form" 
                                Operator="DataTypeCheck" Type="Date" Text="*" ForeColor="#f6f6f6" EnableClientScript="true" 
                                ErrorMessage="Data Limite Aprovação Compra informada não é válida" 
                                ControlToValidate="dtLimiteAprovacaoCCCronogramaSafra" />
                        </td>
                    </tr>
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            Data Limite Liberação Pedido:*
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Date" ID="dtLimiteLiberacaoPVCronogramaSafra" 
                                runat="server" ValidationGroup="Form"
                                CssClass="campoTexto" Text='<%# Bind("dtLimiteLiberacaoPVCronogramaSafra", "{0:dd/MM/yyyy}") %>' />
                            <asp:Label ID="Label5" runat="server" SkinID="data" style="font-size: xx-small; vertical-align: middle" Text="&nbsp;(ddmmaaaa)" />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator5" runat="server" 
                                Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                ErrorMessage="Data Limite Liberação Pedido é campo obrigatório"
                                ControlToValidate="dtLimiteLiberacaoPVCronogramaSafra" />
                            <asp:CompareValidator Display="None" id="CompareValidator5" runat="server" ValidationGroup="Form" 
                                Operator="DataTypeCheck" Type="Date" Text="*" ForeColor="#f6f6f6" EnableClientScript="true" 
                                ErrorMessage="Data Limite Liberação Pedido informada não é válida" 
                                ControlToValidate="dtLimiteLiberacaoPVCronogramaSafra" />
                        </td>
                        <td valign="middle" class="fonteTbCadastro">
                            Data Limite Aprovação Pedido RC:*
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Date" ID="dtLimiteAprovacaoPVRCCronogramaSafra" 
                                runat="server" ValidationGroup="Form"
                                CssClass="campoTexto" Text='<%# Bind("dtLimiteAprovacaoPVRCCronogramaSafra", "{0:dd/MM/yyyy}") %>' />
                            <asp:Label ID="Label6" runat="server" SkinID="data" style="font-size: xx-small; vertical-align: middle" Text="&nbsp;(ddmmaaaa)" />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator6" runat="server" 
                                Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                ErrorMessage="Data Limite Liberação Pedido RC é campo obrigatório"
                                ControlToValidate="dtLimiteAprovacaoPVRCCronogramaSafra" />
                            <asp:CompareValidator Display="None" id="CompareValidator6" runat="server" ValidationGroup="Form" 
                                Operator="DataTypeCheck" Type="Date" Text="*" ForeColor="#f6f6f6" EnableClientScript="true" 
                                ErrorMessage="Data Limite Liberação Pedido RC informada não é válida" 
                                ControlToValidate="dtLimiteAprovacaoPVRCCronogramaSafra" />
                        </td>
                    </tr>
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            Data Limite Aprovação Pedido Área Comercial:*
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Date" ID="dtLimiteAprovacaoPVACCronogramaSafra" 
                                runat="server" ValidationGroup="Form"
                                CssClass="campoTexto" Text='<%# Bind("dtLimiteAprovacaoPVACCronogramaSafra", "{0:dd/MM/yyyy}") %>' />
                            <asp:Label ID="Label7" runat="server" SkinID="data" style="font-size: xx-small; vertical-align: middle" Text="&nbsp;(ddmmaaaa)" />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator7" runat="server" 
                                Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                ErrorMessage="Data Limite Aprovação Pedido Área Comercial é campo obrigatório"
                                ControlToValidate="dtLimiteAprovacaoPVACCronogramaSafra" />
                            <asp:CompareValidator Display="None" id="CompareValidator7" runat="server" ValidationGroup="Form" 
                                Operator="DataTypeCheck" Type="Date" Text="*" ForeColor="#f6f6f6" EnableClientScript="true" 
                                ErrorMessage="Data Limite Aprovação Pedido Área Comercial informada não é válida" 
                                ControlToValidate="dtLimiteAprovacaoPVACCronogramaSafra" />
                        </td>
                        <td class="fonteTbCadastro">
                            Situação:*
                        </td>
                        <td class="tdCamposFormularios">
                            <asp:DropDownList ID="cdIndicadorStatusCronogramaSafra" runat="server"   
                                CssClass="campoTexto" OnPreRender="ConfigCombo" DataValueField="vrDominioCodigoReferenciado" 
                                DataTextField="wkDominioCodigoReferenciado" DataSourceID="ObjectDataSource1" /> 
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="Situação é campo obrigatório"
                                Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                ControlToValidate="cdIndicadorStatusCronogramaSafra" InitialValue="0" />
                        </td>
                    </tr>
                    
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            Quantidade Produto Visualização Preço:*
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Numeric" DecimalPlaces="0" ID="qtProdutoPrecoCronogramaSafra" MaxLength="8" onBlur="RestringirInteiro(this);"
                                runat="server" ValidationGroup="Form"
                                CssClass="campoTexto" Text='<%# Bind("qtProdutoPrecoCronogramaSafra") %>' />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="Quantidade Produto Visualização Preço é campo obrigatório"
                                Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                ControlToValidate="qtProdutoPrecoCronogramaSafra" />
                        </td>

                    </tr>
                    
                    
                    
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            Observação:
                        </td>
                        <td class="tdCamposFormularios" colspan="4">
                            <conv:TextBox Type="Text" ID="wkCronogramaSafra" runat="server" ValidationGroup="Form"
                                Columns="50" Rows="5" TextMode="MultiLine" onkeyup="blocTexto(this, 255)" CssClass="campoTexto" Text='<%# Bind("wkCronogramaSafra") %>' />
                        </td>
                        <td></td>
                    </tr>
                </table>
            </div>
            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="ObterLista" TypeName="CodigoReferenciado">
                <SelectParameters>
                    <asp:Parameter Name="dsDominioCodigoReferenciado" DefaultValue="DMESPINDICADORATIVOINATIVO" Type="String" />
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

