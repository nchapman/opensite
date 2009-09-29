require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Person do
  before(:each) do
    @person = Person.new
    
    @valid_attributes = {
      :first_name => "John",
      :last_name => "Smith",
      :email => "jsmith@example.com",
      :password => "password",
      :password_confirmation => "password"
    }
  end

  it "should be valid" do
    @person.attributes = @valid_attributes
    @person.should be_valid
  end
  
  it "should validate presence of first name" do
    @person.attributes = @valid_attributes.except(:first_name)
    @person.should have(1).error_on(:first_name)
  end
  
  it "should validate presence of last name" do
    @person.attributes = @valid_attributes.except(:last_name)
    @person.should have(1).error_on(:last_name)
  end
  
  it "should validate presence of email" do 
    @person.attributes = @valid_attributes.except(:email)
    @person.should have(2).error_on(:email)
  end
  
  it "should require a valid email" do
    @person.attributes = @valid_attributes.with(:email => "jsmithexample.com")
    @person.should have(1).error_on(:email)
    
    @person.attributes = @valid_attributes.with(:email => "jsmith@examplecom")
    @person.should have(1).error_on(:email)
  end
  
  it "should require a unique email" do
    @another_person = Person.create!(@valid_attributes)
    @person.attributes = @valid_attributes
    
    @person.should have(1).error_on(:email)
  end
  
  it "should require password confirmation" do
    @person.attributes = @valid_attributes.with(:password_confirmation => "paZZword")
    @person.should have(1).error_on(:password)
  end
end
