
RSpec.describe Ranking, type: :model do
  subject { Ranking.new }

  it "can be initialized" do
    expect(subject).to be_present
  end

  it "has 0 week before start of season" do
    subject.set_created_at_date(Date.parse('30/8/2014'))

    expect(subject.week).to eql(0)
  end

  it "has 1 week right after start of season" do
    subject.set_created_at_date(Date.parse('8/9/2014'))

    expect(subject.week).to eql(1)
  end

  it "has 16 week before end of season" do
    subject.set_created_at_date(Date.parse('28/12/2014'))

    expect(subject.week).to eql(16)
  end

  it "has 17 week after end of season" do
    subject.set_created_at_date(Date.parse('01/03/2015'))

    expect(subject.week).to eql(17)
  end
end
