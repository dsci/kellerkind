require 'spec_helper'

describe "Locking and unlocking process" do
  let(:tmp_path) do
    File.expand_path(File.join(File.dirname(__FILE__),"..", "tmp"))
  end

  let(:lock_file){ File.join(tmp_path,"Kellerkind.lock") }

  before do
    Kellerkind::Config.stub!(:lock_dir).and_return(tmp_path)
  end

  describe "#lock_process" do

    after do
      FileUtils.rm(lock_file)
    end

    it "creates a file do mark the process as locked" do
      Kellerkind::Lock.lock_process
      File.exists?(lock_file).should be true
    end

  end

  describe "#unlock_process" do

    before do
      FileUtils.touch(lock_file)
    end

    it "removes the lock file to mark the process as runnable" do
      Kellerkind::Lock.unlock_process
      File.exists?(lock_file).should be false
    end

  end
end