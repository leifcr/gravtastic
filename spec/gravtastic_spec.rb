require "helper.rb"

describe Gravtastic do

  before(:each) do
    @g = Class.new do |c|
      c.send(:include, Gravtastic)
      c.is_gravtastic
    end
  end

  describe ".is_gravtastic" do

    it "includes the methods" do
      expect(@g.included_modules).to include(Gravtastic::InstanceMethods)
    end

  end

  describe 'default' do

    it "options are {:rating => 'PG', :secure => true, :filetype => :png}" do
      expect(@g.gravatar_defaults).to eq ({
              :rating => 'PG',
              :secure => true,
              :filetype => :png,
            })
    end

    it "source is :email" do
      expect(@g.gravatar_source).to eq(:email)
    end

  end

  describe "#gravatar_id" do

    it "downcases email" do
      a = @g.new
      stub(a).email do 'USER@EXAMPLE.COM' end
      b = @g.new
      stub(b).email do 'user@example.com' end
      expect(a.gravatar_id).to eq(b.gravatar_id)
    end

  end

  describe "#gravatar_url" do

    before(:each) do
      @user = @g.new
      stub(@user).email{ 'user@example.com' }
    end

    it "makes a pretty URL" do
      expect(@user.gravatar_url(:secure => false)).to eq('http://gravatar.com/avatar/b58996c504c5638798eb6b511e6f49af.png?r=PG')
    end

    it "makes a secure URL" do
      expect(@user.gravatar_url).to eq('https://secure.gravatar.com/avatar/b58996c504c5638798eb6b511e6f49af.png?r=PG')
    end

    it "makes a jpeggy URL" do
      expect(@user.gravatar_url(:secure => false, :filetype => :jpg)).to eq('http://gravatar.com/avatar/b58996c504c5638798eb6b511e6f49af.jpg?r=PG')
    end

    it "makes a saucy URL" do
      expect(@user.gravatar_url(:secure => false, :rating => 'R')).to eq('http://gravatar.com/avatar/b58996c504c5638798eb6b511e6f49af.png?r=R')
    end

    it "makes a forcedefault URL" do
      expect(@user.gravatar_url(:secure => false, :forcedefault => true)).to eq('http://gravatar.com/avatar/b58996c504c5638798eb6b511e6f49af.png?f=y&r=PG')
    end

    it "abides to some new fancy feature" do
      expect(@user.gravatar_url(:secure => false, :extreme => true)).to eq('http://gravatar.com/avatar/b58996c504c5638798eb6b511e6f49af.png?extreme=true&r=PG')
    end

    it "makes a URL from the defaults" do
      stub(@user.class).gravatar_defaults{ {:size => 20, :rating => 'R18', :secure => true, :filetype => :png} }
      expect(@user.gravatar_url).to eq('https://secure.gravatar.com/avatar/b58996c504c5638798eb6b511e6f49af.png?r=R18&s=20')
    end

    it "makes a URL with the default option" do
      expect(@user.gravatar_url(:default => 'default.jpg')).to eq('https://secure.gravatar.com/avatar/b58996c504c5638798eb6b511e6f49af.png?d=default.jpg&r=PG')
    end

    it "makes a URL when the default option is a lambda" do
      expect(@user.gravatar_url(:default => lambda {|u| "#{u.email}.jpg"})).to eq('https://secure.gravatar.com/avatar/b58996c504c5638798eb6b511e6f49af.png?d=user@example.com.jpg&r=PG')
    end

  end

end
