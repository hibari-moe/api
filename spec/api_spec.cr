require "./spec_helper"
require "json"

describe Hibari do
  it "renders /" do
    get "/"
    data = JSON.parse(response.body).as_h
    data["hello"].should eq "Hello"
    data["world"].should eq "World"
  end
end
