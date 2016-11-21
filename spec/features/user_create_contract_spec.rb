require 'rails_helper'

feature 'User creates Contract' do
  scenario 'successfully' do

    contract = build(:contract)

    customer = create(:customer, name: 'Campus')

    visit new_contract_path


    select customer.name, from: 'Cliente'
    fill_in 'Endereço de Entrega', with: contract.delivery_address
    fill_in 'Prazo de Locação', with: contract.rental_period
    fill_in 'Valor Total', with: contract.total_amount
    fill_in 'Desconto', with: contract.discount
    fill_in 'Equipment', with: contract.equipment
    fill_in 'Responsável', with: contract.contact

    click_on 'Emitir Contrato'

    expect(page).to have_content contract.customer.name
    expect(page).to have_content contract.delivery_address
    expect(page).to have_content contract.rental_period
    expect(page).to have_content contract.total_amount
    expect(page).to have_content contract.discount
    expect(page).to have_content contract.equipment
    expect(page).to have_content contract.contact
  end
end