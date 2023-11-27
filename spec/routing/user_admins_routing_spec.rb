require "rails_helper"

RSpec.describe UserAdminsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/user_admins").to route_to("user_admins#index")
    end

    it "routes to #new" do
      expect(get: "/user_admins/new").to route_to("user_admins#new")
    end

    it "routes to #show" do
      expect(get: "/user_admins/1").to route_to("user_admins#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/user_admins/1/edit").to route_to("user_admins#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/user_admins").to route_to("user_admins#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/user_admins/1").to route_to("user_admins#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/user_admins/1").to route_to("user_admins#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/user_admins/1").to route_to("user_admins#destroy", id: "1")
    end
  end
end
