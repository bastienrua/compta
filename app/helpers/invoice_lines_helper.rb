module InvoiceLinesHelper
  
  def invoice_line_contract_link(line)
    return unless line.contract
    link_to line.contract.title, edit_contract_path(line.contract)
  end
  
end
