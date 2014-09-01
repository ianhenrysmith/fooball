
RSpec.describe League, type: :model do
  subject { League.new }
  let(:user) { User.new }

  it "can be initialized" do
    expect(subject).to be_present
  end

  it "has admins" do
    subject.admin_ids << user.id

    expect(subject.admin?(user)).to be true
  end

end
