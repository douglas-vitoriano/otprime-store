require "rails_helper"

RSpec.describe User, type: :model do
  context "Espero validar os campos obrigatórios, " do
    it "valida o campo nome" do
      user = build(:user)
      expect(user.valid?).to eq(true)
      # poderia ser usado assim também: expect(user).to be_truthy
      #                          ou
      #para forma negativa: expect(user.valid?).to eq(false) ou expect(user).to be_falsey
    end

    it "valida campo nome não esta presente" do
      user = build(:user, name: nil)
      expect(user.valid?).to eq(false)
    end

    it "valida o campo telefone" do
      user = build(:user)
      expect(user.valid?).to eq(true)
    end

    it "valida campo telefone não esta presente" do
      user = build(:user, phone_number: nil)
      expect(user.valid?).to eq(false)
    end
  end
end
