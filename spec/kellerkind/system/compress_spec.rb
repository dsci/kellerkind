require 'spec_helper'

describe Kellerkind::Compress do

  it{ should respond_to(:path) }
  it{ should respond_to(:database_name) }

  describe "instance methods" do
    let(:out_dir) do
      File.expand_path(File.join(File.dirname(__FILE__),"..", "tmp"))
    end
    let(:attributes) do
      {
        :database_name   => "test",
        :path            => out_dir
      }
    end

    it{ should respond_to(:gzip) }

    context "with a hash of attributes" do
      subject{ Kellerkind::Compress.new(attributes) }

      it "then initializes the instance with the attributes values" do
        subject.database_name.should eq attributes[:database_name]
        subject.path.should eq attributes[:path]
      end
    end

    describe "#gzip" do
      let(:test_dump) do
        File.join(out_dir, attributes[:database_name])
      end

      let(:compress) do
        Kellerkind::Compress.new(:path => out_dir, :database_name => "test")
      end

      before do
        FileUtils.mkdir_p(test_dump)
        FileUtils.touch(File.join(test_dump, "foo.txt"))
        compress.gzip
      end

      after do
        Dir["#{out_dir}/*.tar.gz"].each{ |tar| FileUtils.rm(tar) }
        FileUtils.rm_rf(test_dump)
      end

      it "tars and gzip the given database dump" do
        Dir["#{out_dir}/#{compress.database_name}_*.tar.gz"].should have(1).item
      end

    end

  end

end