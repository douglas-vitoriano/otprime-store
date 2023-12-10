require 'rails_helper'

RSpec.describe "user_admins/edit", type: :view do
  let(:user_admin) {
    UserAdmin.create!()
  }

  before(:each) do
    assign(:user_admin, user_admin)
  end

  it "renders the edit user_admin form" do
    render

    assert_select "form[action=?][method=?]", user_admin_path(user_admin), "post" do
    end
  end
end
