require "rails_helper"

RSpec.describe RankingsController, type: :controller do
  include ControllerHelpers

  let(:user) { User.create( email: 'genghis@goldenhorde.horse', password: 'p1llageth3vill4ge' ) }
  let(:league) { League.create(admin_ids: [user.id], user_ids: [user.id], name: "Cannibals") }
  let(:ranking) { Ranking.create(week: 0, created_at_date: Date.parse("01/09/2014"), team_rankings: { :"1" => { team_id: team.id.to_s, comment: "Run away." } }, league_id: league.id ) }
  let(:team) do
    t = Team.create(owner_id: user.id, league_id: league.id, name: "Tatars")
    league.add_team!(t)
    t
  end

  before do
    sign_in_user(user)
  end

  describe "GET new" do
    it "assigns @ranking" do
      # so a new ranking needs a league id. may or may not be ideal.
      get :new, { ranking: { league_id: league.id } }

      expect(assigns(:ranking)).to be_present
    end
  end

  describe "GET show" do

    it "assigns @ranking and associated" do
      get :show, { id: ranking.id }

      expect(assigns(:ranking)).to eql(ranking)
      expect(assigns(:league)).to eql(league)
      expect(assigns(:users)).to eql([user])
      expect(assigns(:teams)).to eql([team])
      expect(assigns(:users_by_team_id)).to eql({ team.id => user })
    end
  end

  describe "PUT create" do

    it "assigns @ranking and associated" do
      put :create, { ranking: { league_id: league.id, created_at_date: Date.parse("03/09/2014"), week: 0, team_rankings: { :"1" => { team_id: team.id.to_s, comment: "Run away." } } }}

      expect(assigns(:ranking)).to eql(Ranking.last)
      expect(assigns(:league)).to eql(league)
      expect(assigns(:users)).to eql([user])
      expect(assigns(:teams)).to eql([team])
      expect(assigns(:users_by_team_id)).to eql({ team.id => user })
      expect(assigns(:message)).to be_present
    end
  end

end