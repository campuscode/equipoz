require 'rails_helper'

feature 'User creates Contract' do
  scenario 'successfully' do
    customer = create(:customer, name: 'Campus')
    category = create(:category)
    equipment = create(:equipment, name: 'Furadeira Bosch vermelha',
                                   category: category)
    another_equipment = create(:equipment,
                               serial_number: 'CHK1245',
                               name: 'Betoneira CSM')
    create(:category_price, category: category,
                            rental_period: 15, price: 110)
    contract = build(:contract)

    equipment_description = "#{equipment.serial_number} \
#{equipment.name}"
    another_equipment_description = "#{another_equipment.serial_number} \
#{another_equipment.name}"

    visit root_path

    click_on 'Novo Contrato'

    select customer.name, from: 'Cliente'
    fill_in 'Endereço de Entrega', with: contract.delivery_address
    select('15', from: 'Prazo de Locação')
    fill_in 'Desconto', with: contract.discount
    check(equipment_description)
    check(another_equipment_description)
    fill_in 'Responsável', with: contract.contact

    click_on 'Emitir Contrato'

    expect(page).to have_content customer.name
    expect(page).to have_content contract.delivery_address
    expect(page).to have_content contract.rental_period
    expect(page).to have_content contract.amount
    expect(page).to have_content contract.discount
    expect(page).to have_content equipment_description
    expect(page).to have_content another_equipment_description
    expect(page).to have_content contract.contact
    expect(page).to have_content contract.total_amount
  end

  scenario 'no equipment' do
    customer = create(:customer, name: 'Campus')
    contract = build(:contract)

    visit new_contract_path

    select customer.name, from: 'Cliente'
    fill_in 'Endereço de Entrega', with: contract.delivery_address
    select('15', from: 'Prazo de Locação')

    fill_in 'Desconto', with: contract.discount
    fill_in 'Responsável', with: contract.contact

    click_on 'Emitir Contrato'

    expect(page).to have_content('Não foi possível emitir o contrato')
  end
end
