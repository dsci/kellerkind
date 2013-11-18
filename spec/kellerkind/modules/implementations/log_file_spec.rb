require 'spec_helper'

describe Kellerkind::LogFile do
  let(:out_dir) do
    File.expand_path(File.join(File.dirname(__FILE__),"..", '..',"tmp"))
  end

  it { should respond_to(:paths) }
  it { should respond_to(:out) }
  it { should respond_to(:recreate) }


  describe "instance methods" do

    let(:attributes) do
      {
        :paths    => ["$HOME/tmp/kellerkind.lock"],
        :out      => out_dir,
        :recreate => true
      }
    end

    it{ should respond_to(:archive) }

    describe "#initialize" do

      context "with a hash of attributes" do

        context "that uses the proper prefix" do

          subject{ Kellerkind::LogFile.new(attributes) }

          it "then initializes the instance with the attribute values" do
            subject.paths.should eq attributes[:paths]
            subject.out.should eq attributes[:out]
            subject.recreate.should eq attributes[:recreate]
          end

        end

      end
    end

    describe "#archive" do
      let(:rel_path) do
        path = File.join(__FILE__,'..','..','..','..','fixtures')
        File.expand_path(path)
      end

      let(:sample_file){ "#{rel_path}/sample.log" }

      before do
        FileUtils.touch(sample_file)
        attributes[:paths] = [sample_file]
      end

      after do
        Dir["#{out_dir}/*.tar.gz"].each{ |tar| FileUtils.rm(tar) }
        if File.exist?(sample_file)
          FileUtils.rm(sample_file)
        end
      end

      context ":recreate given and true" do

        subject{ Kellerkind::LogFile.new(attributes) }

        it "moves and compresses the files" do
          subject.archive
          Dir["#{out_dir}/sample.log_*.tar.gz"].should have(1).item
        end

        it "files are newly created" do
          File.exist?(sample_file).should be true
        end
      end

      context ":recreate given and false" do

        before do
          attributes[:recreate] = false
        end

        subject{ Kellerkind::LogFile.new(attributes) }

        it "files are removed" do
          subject.archive
          File.exist?(sample_file).should be false
        end
      end
    end

  end

end