class AddFieldsToCharity < ActiveRecord::Migration
  def change
    add_column :charities, :active, :bool
    add_column :charities, :logo, :string
    add_column :charities, :cnpj, :string
  end
end
