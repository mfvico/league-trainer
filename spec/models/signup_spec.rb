require 'rails_helper'

describe "Signup" do

  def create_user
    User.create(
      first_name: "Vico",
      last_name: "Bellic",
      summoner: "vico",
      email: "not@you.com",
      password: "test",
      password_confirmation: "test"
    )
  end

  it "User cannot sign up without valid credentials" do
    user = User.new
    user.valid?
    expect(user.errors.present?).to eq(true)
    user.first_name = "Vico"
    user.valid?
    expect(user.errors.present?).to eq(true)
    user.last_name = "Bellic"
    user.valid?
    expect(user.errors.present?).to eq(true)
    user.email = "not@you.com"
    user.valid?
    expect(user.errors.present?).to eq(true)
    user.summoner = "vico"
    user.valid?
    expect(user.errors.present?).to eq(true)
    user.password = "test"
    user.password_confirmation = "test"
    user.valid?
    expect(user.errors.present?).to eq(false)
  end

  it "User cannot sign up with mismatched passwords" do
    user = User.new
    user.first_name = "Vico"
    user.last_name = "Bellic"
    user.email = "not@you.com"
    user.summoner = "vico"
    user.password = "test"
    user.password_confirmation = "testy"
    user.valid?
    expect(user.errors.present?).to eq(true)
    user.password_confirmation = "test"
    user.valid?
    expect(user.errors.present?).to eq(false)
  end

  it "User cannot sign up with a used email" do
    create_user
    user = User.new
    user.email = "not@you.com"
    user.valid?
    expect(user.errors[:email].present?).to eq(true)
    user.email = "its@me.com"
    user.valid?
    expect(user.errors[:email].present?).to eq(false)
  end

end
