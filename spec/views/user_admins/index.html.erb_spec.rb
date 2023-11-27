require 'rails_helper'

RSpec.describe "user_admins/index", type: :view do
  before(:each) do
    assign(:user_admins, [
      UserAdmin.create!(),
      UserAdmin.create!()
    ])
  end

  it "renders a list of user_admins" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
  end
end
