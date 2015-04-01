require_relative '../spec_helper'

RSpec.describe Rack::FileWatcher do
  let(:target_file) do
    AppSpecHelper::TEST_FILE
  end

  context "when monitored file has updated." do
    before do
      get '/'
    end

    it "block is executed." do
      FileUtils.touch(target_file, mtime: Time.now + 10)

      expect { get '/' }.to output('Updated.').to_stdout
    end
  end

  context "when monitored file hasn't updated." do
    before do
      get '/'
    end

    it "block is not executed." do
      expect { get '/' }.to_not output('Updated.').to_stdout
    end
  end

  context "when monitored file was not exist." do
    before do
      FileUtils.rm_rf(target_file)
    end

    it "create new file." do
      expect { get '/' }.to change { File.exist?(target_file) }.to(true)
    end
  end

  context "when monitored file was exist." do
    before do
      FileUtils.touch(target_file, mtime: Time.at(100))
    end

    it "time stamp of the file is updated" do
      expect { get '/' }.to change { File.mtime(target_file) }.from(Time.at(100))
    end
  end
end
