require 'spec_helper'

describe Kellerkind::Mongodb do

  describe "class methods" do

    describe "#exec" do

      let(:dbname){ "kellerkindTest"}
      let(:out_dir) do
        File.expand_path(File.join(File.dirname(__FILE__),"..", "tmp"))
      end
      before do
        rel_path  = File.join(__FILE__,'..','..','..','fixtures')
        js_path   = File.expand_path(rel_path)
        system("`which mongo` #{js_path}/mongodb.js")
        Kellerkind::Process.unlock
      end

      after do
        Dir["#{out_dir}/#{dbname}*.tar.gz"].each{ |tar| FileUtils.rm(tar) }
      end

      let(:attributes) do
        {
          :mongo_db     => dbname,
          :mongo_host   => "localhost",
          :mongo_port   => "27017",
          :out          => out_dir,
          :remove_dump  => true,
          :compress     => true
        }
      end

      it "dumps a database" do
        Kellerkind::Mongodb.exec(attributes)
        Dir["#{out_dir}/#{dbname}_*.tar.gz"].should have(1).item
      end

    end

  end
end
