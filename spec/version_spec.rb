require File.expand_path('../spec_helper', __FILE__)

RSpec.describe PaylocityWebService::VERSION do
  it "has a version number" do
    expect(PaylocityWebService::VERSION).not_to be nil
  end
end