require 'rails_helper'

RSpec.describe "user_admins/new", type: :view do
  before(:each) do
    assign(:user_admin, UserAdmin.new())
  end

  it "renders new user_admin form" do
    render

    assert_select "form[action=?][method=?]", user_admins_path, "post" do
    end
  end
end
