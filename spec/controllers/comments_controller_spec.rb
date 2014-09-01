require "rails_helper"

RSpec.describe CommentsController, type: :controller do
  include ControllerHelpers

  let(:user) { User.create }
  let(:parent) { Story.create }

  before do
    sign_in_user(user)
  end

  describe "GET new" do
    it "assigns @comment" do
      get :new, { comment: { body: "smoo", parent_id: parent.id, parent_type: "Story", creator_id: user.id }}

      expect(assigns(:comment)).to be_present
    end
  end

  describe "POST create" do
    it "creates comment" do
      request.host = "localhost:3000"

      post :create, { comment: { body: "smoo", parent_id: parent.id, parent_type: "Story", creator_id: user.id }}

      expect(Comment.count).to eql(1)
    end
  end
end