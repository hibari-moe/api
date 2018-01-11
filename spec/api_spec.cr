require "./spec_helper"

describe Hibari do
  it "renders /" do
    get "/"
    response.body.should eq "Hello World!"
  end
end
