require "../spec_helper"

describe Hibari::JsonAPI do
  it "uses the JSON:API content type" do
    Hibari::JsonAPI::CONTENT_TYPE.should eq "application/vnd.api+json"
  end
end
