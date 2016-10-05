describe "Class 'String'" do
  before do
    @sample_string = "_THIS IS SAMPLE STRING_"
  end

  it "translate to itself when not defined" do
    @sample_string._.should == @sample_string
  end
end
