require 'spec_helper'

describe Kellerkind::Mongo do

  it{ should respond_to(:db) }
  it{ should respond_to(:host) }
  it{ should respond_to(:username) }
  it{ should respond_to(:password) }
  it{ should respond_to(:port) }
  it{ should respond_to(:out) }

  describe "instance methoods" do

    let(:attributes) do
      {
        :mongo_db         => "test",
        :mongo_host       => "localhost",
        :mongo_username   => "rspec_user",
        :mongo_password   => "no_pwd",
        :mongo_port       => "27017"
      }
    end

    it{ should respond_to(:dump_database) }
    it{ should respond_to(:dump_argument_list)}

    describe "#initialize" do

      context "with a hash of attributes" do

        context "that uses the proper prefix" do

          subject{ Kellerkind::Mongo.new(attributes) }

          it "then initializes the instance with the attributes values" do
            subject.db.should eq attributes[:mongo_db]
            subject.host.should eq attributes[:mongo_host]
            subject.username.should eq attributes[:mongo_username]
            subject.password.should eq attributes[:mongo_password]
            subject.port.should eq attributes[:mongo_port]

            subject.dump_database
          end

        end

        context "that uses not the proper prefix" do
          let(:inproper_attributes) do
            attributes.delete(:mongo_db)
            attributes[:super_database] = "testa"
            attributes
          end

          subject{ Kellerkind::Mongo.new(inproper_attributes) }

          it "then initializes the instance without these attributes" do
            subject.db.should be nil
          end

        end

      end

    end

    describe "#dump_argument_list" do

      context "and arguments given" do

        let(:mongo){ Kellerkind::Mongo.new(attributes) }

        subject{ mongo.dump_argument_list }

        context "then returns a parameter list including the instances attributes" do

          it{ should match(/--db #{attributes[:mongo_db]}{1,}/) }
          it{ should match(/--password #{attributes[:mongo_password]}{1,}/) }
          it{ should match(/--host #{attributes[:mongo_host]}{1,}/) }
          it{ should match(/--port #{attributes[:mongo_port]}{1,}/)}
          it{ should match(/--username #{attributes[:mongo_username]}{1,}/)}

          it{ should_not match(/--host #{attributes[:mongo_host]}{2,*}/)}
          it{ should_not match(/--db #{attributes[:mongo_db]}{2,*}/) }
          it{ should_not match(/--password #{attributes[:mongo_password]}{2,*}/) }
          it{ should_not match(/--host #{attributes[:mongo_host]}{2,*}/) }
          it{ should_not match(/--port #{attributes[:mongo_port]}{2,*}/)}
          it{ should_not match(/--user_name #{attributes[:mongo_username]}{2,*}/)}

        end

      end

      context "and no arguments given" do

        let(:mongo){ Kellerkind::Mongo.new }

        subject{ mongo.dump_argument_list }

        it "then returns an empty string" do
          subject.should be_empty
        end

      end

    end

    describe "#dump_database" do
      let(:out_dir) do
        File.expand_path(File.join(File.dirname(__FILE__),"..", "tmp"))
      end
      let(:dump_attributes) do
        {
          :mongo_db   => "kellerkindTest",
          :mongo_port => "27017",
          :mongo_host => "localhost",
          :mongo_out  => out_dir
        }
      end

      before do
        js_path = File.expand_path(File.join(__FILE__,'..','..','..','fixtures'))
        system("`which mongo` #{js_path}/mongodb.js")
      end

      after do
        if File.exists?(out_dir)
          FileUtils.rm_rf(out_dir)
        end
      end

      subject{ Kellerkind::Mongo.new(dump_attributes) }

      it "dumps database content into --out" do
        subject.dump_database
        File.exists?("#{out_dir}/kellerkindTest").should be true
        File.exists?("#{out_dir}/kellerkindTest/tests.bson").should be true
        File.exists?("#{out_dir}/kellerkindTest/tests.metadata.json").should be true
        File.exists?("#{out_dir}/kellerkindTest/system.indexes.bson").should be true
      end

    end

  end

end