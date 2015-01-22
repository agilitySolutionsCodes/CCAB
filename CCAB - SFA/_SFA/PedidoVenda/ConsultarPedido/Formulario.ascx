<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Formulario.ascx.cs" Inherits="_SFA_PedidoVenda_ConsultarPedido_Formulario" %>

<script type="text/javascript" src="../../../scripts/JScript.js"></script>

<!-- Preparação da PopUp Modal que exibirá o Formulário (Permite que o formulário seja arrastado pela tela) -->
<asp:Button runat="server" ID="btShowPanel1" Style="display: none" />
<asp:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="btShowPanel1"
    PopupControlID="Panel1" PopupDragHandleControlID="Panel1DragHandle" BackgroundCssClass="modalBackground" />
<asp:HiddenField ID="cdTipoPedidoVenda" runat="server" />

<script type="text/javascript">

    function ExibirRelatorioPrePedido(TipoRelatorio, cdPedidoVendaSEQ, cdPedidoVendaERPSEQ, cdAgenteComercialCooperativaPedidoVenda, cdCronogramaSafraSEQ, cdClienteFaturamentoPedidoVenda, cdClienteEntregaPedidoVenda, cdIndicadorMoedaPedidoVenda, cdIndicadorStatusPedidoVenda, cdPessoaOrigemFaturamento) 
    {
        //window.open("./../../Relatorios/PrePedido.aspx?cdPedidoVendaSEQ=" + cdPedidoVendaSEQ + "&cdPedidoVendaERPSEQ=" + cdPedidoVendaERPSEQ, "PrePedido", "toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=yes,width=700,height=500,left=100,top=50");
        window.open("./../../Relatorios/PrePedido.aspx?TipoRelatorio=" + TipoRelatorio + "&cdPedidoVendaSEQ=" + cdPedidoVendaSEQ + "&cdPedidoVendaERPSEQ=" + cdPedidoVendaERPSEQ + "&cdAgenteComercialCooperativaPedidoVenda=" + cdAgenteComercialCooperativaPedidoVenda + "&cdCronogramaSafraSEQ=" + cdCronogramaSafraSEQ + "&cdClienteFaturamentoPedidoVenda=" + cdClienteFaturamentoPedidoVenda + "&cdClienteEntregaPedidoVenda=" + cdClienteEntregaPedidoVenda + "&cdIndicadorMoedaPedidoVenda=" + cdIndicadorMoedaPedidoVenda + "&cdIndicadorStatusPedidoVenda=" + cdIndicadorStatusPedidoVenda + "&cdPessoaOrigemFaturamento=" + cdPessoaOrigemFaturamento, "PrePedido", "toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=yes,width=700,height=500,left=100,top=50");
    }

</script>


<div style="width: 98%;">
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
    <!-- Cabeçalho Pedido SFA -->
    <div style="margin-bottom: 15px;">
        <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <div style="font-size: x-small; font-weight: bold; text-align: left; vertical-align: middle;">
                    <fieldset style="padding: 5px 5px;">
                        <asp:Label runat="server" ID="lbContents" SkinID="normal" />
                    </fieldset>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <!-- Formulário -->
    <div>
        <div style="margin-bottom: 15px;">
            <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <asp:GridView ID="GridView1" DataKeyNames="cdPedidoVendaERP" runat="server" SkinID="NoPaging">
                        <Columns>
                            <asp:TemplateField ShowHeader="false">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btViewItens" runat="server" CommandName="Select" CommandArgument='<%# Eval("cdPedidoVendaERPSEQ") %>'
                                        Text="Ver Itens" OnClientClick="divItens.style.display = 'block';" OnClick="btViewItens_Click" />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="cdPedidoVendaERPUsuario" HeaderText="Nº Pedido Portal" SortExpression="cdPedidoVendaERPUsuario">
                                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                                <HeaderStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="cdPedidoVendaERP" HeaderText="Nº Pré-Pedido" SortExpression="cdPedidoVendaERP">
                                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                                <HeaderStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="dtVenctoPedidoVendaERP" HeaderText="Vencimento" SortExpression="dtVenctoPedidoVendaERP">
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="vrTotalMoedaPedidoVendaERP" HeaderText="Valor Total" DataFormatString="{0:###,##0.00}"
                                SortExpression="vrTotalMoedaPedidoVendaERP">
                                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                                <HeaderStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="vrTotalAbertoMoedaPedidoVendaERP" HeaderText="Valor Total em Aberto"
                                DataFormatString="{0:###,##0.0000}" SortExpression="vrTotalAbertoMoedaPedidoVendaERP">
                                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                                <HeaderStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="dsIndicadorStatusPedido" HeaderText="Situação" SortExpression="dsIndicadorStatusPedido">
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
                                <HeaderStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                        </Columns>
                    </asp:GridView>
                    
                    <div style="clear: both; text-align: right; margin-top: 15px;">
                        <asp:Button runat="server" ID="btnImprimirTodos" CommandName="Cancel" CssClass="button" Text="Imprimir Todos"
                            CausesValidation="false" Width="160px" />
                    </div>
                                        
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <div id="divItens" style="display: none;">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <asp:GridView ID="GridView2" runat="server" SkinID="NoPaging">
                        <Columns>
                            <asp:BoundField DataField="dtAnoMesPedidoVendaItemEntrega" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Data de Entrega" SortExpression="qtItem">
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="dsProduto" HeaderText="Produto" SortExpression="dsProduto">
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
                                <HeaderStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="qtPedidoVendaERPItem" HeaderText="Quantidade" DataFormatString="{0:###,##0.00}" SortExpression="qtPedidoVendaERPItem">
                                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                                <HeaderStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="qtAbertoPedidoVendaERPItem" HeaderText="Quantidade em Aberto" DataFormatString="{0:###,##0.00}" SortExpression="qtAbertoPedidoVendaERPItem">
                                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                                <HeaderStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="vrUnitarioMoedaPedidoVendaERPItem" HeaderText="Valor Unitário" DataFormatString="{0:###,##0.00}"
                                SortExpression="vrUnitarioMoedaPedidoVendaERPItem">
                                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                                <HeaderStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="vrTotalMoedaPedidoVendaERPItem" HeaderText="Valor Total" DataFormatString="{0:###,##0.00}"
                                SortExpression="vrTotalMoedaPedidoVendaERPItem">
                                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                                <HeaderStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="vrTotalMoedaAbertoPedidoVendaERPItem" HeaderText="Valor Total em Aberto" DataFormatString="{0:###,##0.00}"
                                SortExpression="vrTotalMoedaAbertoPedidoVendaERPItem">
                                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                                <HeaderStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="pcDescontoPontualidade" HeaderText="% Desc. Pontualidade"
                                SortExpression="pcDescontoPontualidade">
                                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                                <HeaderStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            
                            <asp:BoundField DataField="dsIndicadorStatusPedido" HeaderText="Situação" SortExpression="dsIndicadorStatusPedido">
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
                                <HeaderStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                        </Columns>
                    </asp:GridView>
                    
                    
                    <div style="clear: both; text-align: right; margin-top: 15px;">

                        <asp:Button runat="server" ID="btnImprimirSelecionado" CommandName="Cancel" CssClass="button" Text="Imprimir Selecionado"
                            CausesValidation="false" Width="160px" />
                    </div>
                    
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        
        <div style="clear: both; text-align: right; margin-top: 15px;">
            <asp:Button runat="server" ID="Button6" CommandName="Cancel" CssClass="button" Text="fechar"
                CausesValidation="false" OnCommand="btCancel_OnClick" />
        </div>
                    
    </div>
</div>
