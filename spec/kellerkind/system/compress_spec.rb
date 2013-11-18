require 'spec_helper'

describe Kellerkind::Compress do

  it{ should respond_to(:source_path) }
  it{ should respond_to(:target_path) }
  it{ should respond_to(:tarball_prefix)}

  describe "instance methods" do
    let(:out_dir) do
      File.expand_path(File.join(File.dirname(__FILE__),"..", "tmp"))
    end
    let(:attributes) do
      {
        :tarball_prefix   => "test",
        :target_path      => out_dir
      }
    end

    it{ should respond_to(:gzip) }

    context "with a hash of attributes" do
      subject{ Kellerkind::Compress.new(attributes) }

      it "then initializes the instance with the attributes values" do
        subject.target_path.should eq attributes[:target_path]
        subject.tarball_prefix.should eq attributes[:tarball_prefix]
      end
    end

    describe "#gzip" do
      let(:test_dump) do
        File.join(out_dir, "kellerkindTest")
      end

      let(:compress) do
        Kellerkind::Compress.new(:target_path     => out_dir,
                                 :source_path     => test_dump,
                                 :tarball_prefix  => "test")
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
        Dir["#{out_dir}/#{compress.tarball_prefix}_*.tar.gz"].should have(1).item
      end

    end

  end

end