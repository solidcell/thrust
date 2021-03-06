require 'spec_helper'

describe Thrust::Tasks::Clean do
  let(:out) { double(:out) }
  let(:xcode_tools_provider) { double(Thrust::XcodeToolsProvider) }

  subject { Thrust::Tasks::Clean.new(out, xcode_tools_provider) }

  describe '#run' do
    it 'cleans the build' do
      app_config = Thrust::AppConfig.new(
        'project_name' => 'project-name',
        'workspace_name' => 'workspace-name',
        'build_directory' => 'build-dir'
      )

      tools_options = {
        project_name: 'project-name',
        workspace_name: 'workspace-name'
      }

      xcode_tools = double(Thrust::XcodeTools)

      allow(xcode_tools_provider).to receive(:instance).with(out, nil, 'build-dir', tools_options).and_return(xcode_tools)

      expect(xcode_tools).to receive(:clean_build)

      subject.run(app_config)
    end
  end
end
