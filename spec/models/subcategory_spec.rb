require File.dirname(__FILE__) + '/../spec_helper'

describe Subcategory do
  before(:each) do
    @subcategory = Subcategory.new
  end

  it "should be valid" do
    @subcategory.should be_valid
  end
end
