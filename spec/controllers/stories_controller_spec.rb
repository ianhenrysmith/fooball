require "rails_helper"

RSpec.describe StoriesController, type: :controller do
  include ControllerHelpers

  let(:user) { User.create( email: 'genghis@goldenhorde.horse', password: 'p1llageth3vill4ge' ) }
  let(:parent) { League.create }

  before do
    sign_in_user(user)
  end

  describe "GET new" do
    it "assigns @story" do
      get :new, { story: { body: "smoo", parent_id: parent.id, parent_type: "League", creator_id: user.id }}

      expect(assigns(:story)).to be_present
    end
  end

  describe "POST create" do
    it "creates story" do
      post :create, { story: { body: "smoo", parent_id: parent.id, parent_type: "League", creator_id: user.id }}

      expect(Story.count).to eql(1)
    end
  end
end