require "rails_helper"

RSpec.describe LeaguesController, type: :controller do
  include ControllerHelpers

  let(:user) { User.create( email: 'genghis@goldenhorde.horse', password: 'p1llageth3vill4ge' ) }
  let(:league) { League.create(admin_ids: [user.id], user_ids: [user.id], name: "Cannibals") }


  let(:_team) do
    t = Team.create(owner_id: user.id, league_id: league.id, name: "Tatars")
    league.add_team!(t)
    t
  end

  let(:_story) { Story.create(creator_id: user.id, parent_id: league.id, parent_type: "League", title: "Nomads", body: "Mongolian steppe.") }
  let(:_topic) { Topic.create(creator_id: user.id, parent_id: league.id, parent_type: "League", title: "Berbers", body: "Sahara desert.") }
  let(:_ranking) { Ranking.create(week: 0, created_at_date: Date.parse("01/09/2014"), team_rankings: { :"1" => { team_id: team.id.to_s, comment: "Run away." } }, league_id: league.id ) }

  before do
    sign_in_user(user)
  end

  describe "GET new" do
    it "assigns @league" do
      get :new

      expect(assigns(:league)).to be_present
    end
  end

  describe "POST create" do
    it "creates league" do
      post :create, { league: { name: "Barbarians" }}

      league = League.first

      expect(response.redirect_url).to eql(league_url(league))
      expect(League.count).to eql(1)
      expect(league.admin_ids).to eql([user.id])
      expect(league.user_ids).to eql([user.id])
    end
  end

  describe "PUT update" do
    it "assigns and updates @league" do
      put :update, { id: league.id, league: { name: "Huns" }}

      expect(assigns(:league)).to eql(league)
      expect(league.reload.name).to eql("Huns")
    end
  end

  context "a setup league" do
    let!(:team) { _team }
    let!(:story) { _story }
    let!(:topic) { _topic }
    let!(:ranking) { _ranking }

    describe "GET index" do
      it "assigns @leagues and @teams" do
        get :index

        expect(assigns(:leagues)).to eql([league])
        expect(assigns(:teams)).to eql([team])
      end
    end

    describe "GET show" do
      it "assigns associated" do
        get :show, { id: league.id }

        expect( assigns(:league) ).to eql( league )
        expect( assigns(:stories) ).to eql( [story] )
        expect( assigns(:topics) ).to eql( [topic] )
        expect( assigns(:users) ).to eql( [user] )
        expect( assigns(:admins) ).to eql( [user] )
        expect( assigns(:teams) ).to eql( [team] )
        expect( assigns(:rankings) ).to eql( [ranking] )
        expect( assigns(:users_by_team_id) ).to eql( { team.id => user } )
      end
    end

    describe "GET edit" do
      it "assigns associated" do
        get :edit, { id: league.id }

        expect( assigns(:league) ).to eql( league )
        expect( assigns(:users) ).to eql( [user] )
        expect( assigns(:admins) ).to eql( [user] )
        expect( assigns(:teams) ).to eql( [team] )
        expect( assigns(:rankings) ).to eql( [ranking] )
        expect( assigns(:users_by_team_id) ).to eql( { team.id => user } )
      end
    end
  end

end