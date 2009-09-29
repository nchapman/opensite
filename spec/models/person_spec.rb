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
    @person.should have(1).error_on(:email)
  end
  
  it "should require a valid email" do
    @person.attributes = @valid_attributes.with(:email => "jsmithexample.com")
    @person.should have(1).error_on(:email)
    
    @person.attributes = @valid_attributes.with(:email => "jsmith@examplecom")
    @person.should have(1).error_on(:email)
    
    @person.attributes = @valid_attributes.except(:email)
    @person.should have(1).error_on(:email)
    
    @person.attributes = @valid_attributes.with(:email => "")
    @person.should have(1).error_on(:email)
  end
  
  it "should require a unique email" do
    @another_person = Person.create!(@valid_attributes)
    @person.attributes = @valid_attributes
    @person.should have(1).error_on(:email)
  end
  
  it "should require a valid password" do
    @person.attributes = @valid_attributes.with(:password => "pass", :password_confirmation => "pass")
    @person.should have(1).error_on(:password)
  end
  
  it "should require password confirmation" do
    @person.attributes = @valid_attributes.with(:password_confirmation => "paZZword")
    @person.should have(1).error_on(:password)
  end
  
  it "should flush passwords after save" do
    @person.attributes = @valid_attributes
    @person.save!
    
    @person.password.should == nil
    @person.password_confirmation.should == nil
  end
  
  it "should encrypt password" do
    @person.attributes = @valid_attributes
    @person.encrypted_password.should_not == nil
    @person.encrypted_password.should_not == "password"
    @person.salt.should_not == nil
  end
  
  it "should not update the password if a blank one is provided" do
    @person.attributes = @valid_attributes
    @person.save
    
    encrypted_password = @person.encrypted_password
    
    @person.password = @person.password_confirmation = ""
    
    @person.should be_valid
    @person.encrypted_password.should == encrypted_password
  end
  
  it "should authenticate a user" do
    @person.attributes = @valid_attributes
    @person.save
    
    Person.authenticate("jsmith@example.com", "letmein").should == nil
    Person.authenticate("jsmith@example.com", "password").should_not == nil
  end
end
