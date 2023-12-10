require 'rails_helper'

RSpec.describe "user_admins/show", type: :view do
  before(:each) do
    assign(:user_admin, UserAdmin.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
