require "../spec_helper"

describe Hibari do
  it "uses the json content type" do
    Hibari::CONTENT_TYPE.should eq "application/vnd.api+json"
  end
end
