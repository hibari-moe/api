require "../spec_helper"

describe JsonAPI do
  it "uses the JSON:API content type" do
    JsonAPI::CONTENT_TYPE.should eq "application/vnd.api+json"
  end
end
