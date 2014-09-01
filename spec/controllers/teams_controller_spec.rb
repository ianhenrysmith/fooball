require "rails_helper"

RSpec.describe TeamsController, type: :controller do
  include ControllerHelpers

  let(:user) { User.create( email: 'genghis@goldenhorde.horse', password: 'p1llageth3vill4ge' ) }
  let(:league) { League.create(admin_ids: [user.id], user_ids: [user.id], name: "Cannibals") }
  let(:team) do
    t = Team.create(owner_id: user.id, league_id: league.id, name: "Tatars")
    league.add_team!(t)
    t
  end

  before do
    sign_in_user(user)
  end

  describe "GET new" do
    it "assigns junk" do
      get :new, { team: { owner_id: user.id, league_id: league.id }}

      expect(assigns(:team)).to be_present
      expect(assigns(:league)).to eql(league)
    end
  end

  # describe "POST create" do
  #   it "creates comment" do
  #     post :create, { comment: { body: "smoo", parent_id: parent.id, parent_type: "Story", creator_id: user.id }}

  #     expect(Comment.count).to eql(1)
  #   end
  # end
end