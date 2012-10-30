class AddPagseguroFieldsToCharity < ActiveRecord::Migration
  def change
    add_column :charities, :pagseguro_authenticity_token, :string
    add_column :charities, :pagseguro_email, :string
    Charity.update_all("pagseguro_authenticity_token = '#{PagSeguro.config["authenticity_token"]}', pagseguro_email = '#{PagSeguro.config["email"]}'")
  end
end
